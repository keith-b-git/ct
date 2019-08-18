use utf8;
package ClubTriumph::Schema::Result::Searchable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Searchable

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<searchables>

=cut

__PACKAGE__->table("searchables");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 menu

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 clubtorque

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 length

  data_type: 'integer'
  is_nullable: 1

=head2 spidered

  data_type: 'tinyint'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_nullable: 1

=head2 view

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "menu",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "clubtorque",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "length",
  { data_type => "integer", is_nullable => 1 },
  "spidered",
  { data_type => "tinyint", is_nullable => 1 },
  "type",
  { data_type => "integer", is_nullable => 1 },
  "view",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 clubtorque

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Article>

=cut

__PACKAGE__->belongs_to(
  "clubtorque",
  "ClubTriumph::Schema::Result::Article",
  { id => "clubtorque" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "ClubTriumph::Schema::Result::Item",
  { id => "item" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 menu

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "menu",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "menu" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 wordcounts

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Wordcount>

=cut

__PACKAGE__->has_many(
  "wordcounts",
  "ClubTriumph::Schema::Result::Wordcount",
  { "foreign.searchable" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2015-01-02 23:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gtPrL3p1INx6WWpk7RO/yw

sub title {
	my ($self,$c) = @_;
	if ($self->clubtorque) {return $self->clubtorque->articleedition->title.' '.$self->clubtorque->title}
	if ($self->item) {return $self->item->known_as}
	
}

sub content {
	my ($self,$c) = @_;
	use HTML::Strip;
	my $hs = HTML::Strip->new();
	if ($self->clubtorque) {return $self->clubtorque->gettext}
	if ($self->item) {
		my $text = $hs->parse($self->item->content);
		utf8::encode($text);
		$hs->eof;
		return $text}
}

sub link_url {
	my ($self,$c,$menu_item,$user) = @_;
	if ($self->clubtorque) {return $c->uri_for('/clubtorque','article',$self->clubtorque->id)}
	if ($self->item) {
		my $context = $self->item->display_context($menu_item,$user);
		unless ($context) {return}
		return $c->uri_for('/menu',$context->pid,'item',$self->item->id,'view')
	}
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
