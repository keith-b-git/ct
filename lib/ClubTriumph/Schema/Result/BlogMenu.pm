use utf8;
package ClubTriumph::Schema::Result::BlogMenu;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::BlogMenu

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

=head1 TABLE: C<blog_menu>

=cut

__PACKAGE__->table("blog_menu");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 menu

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 modified

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 ancs

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 path

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 item_view

  data_type: 'integer'
  is_nullable: 1

=head2 menu_view

  data_type: 'integer'
  is_nullable: 1

=head2 sortby

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_nullable: 1

=head2 sticky

  data_type: 'integer'
  is_nullable: 1

=head2 replies

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "menu",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "modified",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "ancs",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "path",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "item_view",
  { data_type => "integer", is_nullable => 1 },
  "menu_view",
  { data_type => "integer", is_nullable => 1 },
  "sortby",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "integer", is_nullable => 1 },
  "sticky",
  { data_type => "integer", is_nullable => 1 },
  "replies",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</item>

=item * L</menu>

=back

=cut

__PACKAGE__->set_primary_key("id", "item", "menu");

=head1 RELATIONS

=head2 anc

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::BlogMenu>

=cut

__PACKAGE__->belongs_to(
  "anc",
  "ClubTriumph::Schema::Result::BlogMenu",
  { id => "ancs" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 blog_menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::BlogMenu>

=cut

__PACKAGE__->has_many(
  "blog_menus",
  "ClubTriumph::Schema::Result::BlogMenu",
  { "foreign.ancs" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "ClubTriumph::Schema::Result::Item",
  { id => "item" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 menu

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "menu",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "menu" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "ClubTriumph::Schema::Result::User",
  { id => "user" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 19:16:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:T0OmNouRNHHpVKkG2dsdsQ

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "modified",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);


sub update_link {
	my $self=shift;
	my $id;
	if ($self->item->author) {$id = $self->item->author->id}
	$self->update({});
		return;
	$self->update({
		item_view => $self->item->view,
		menu_view => $self->menu->view,
		path => $self->menu->path,
		sortby => $self->item->sortby,
		type => $self->item->contenttype->id,
		sticky => $self->item->sticky,
		user => $id,
		replies => $self->item->items->count({})
	});
}




sub set_ancestor_links {
	return 1;
	my $self = $_[0];
	if ($self->menu && $self->menu->parent && $self->item->id && $self->menu->pid) {
		my $menu = $self->menu;
		my @link_ids;
		while ($menu->parent) {
			$menu = $menu->parent;
			while ($self->result_source->resultset->count({item => $self->item->id, menu => $menu->pid, ancs => $self->id})> 1 ){ #deal with any duplicates
				$self->result_source->resultset->search({item => $self->item->id, menu => $menu->pid, ancs => $self->id})->first->delete;
				print "duplicate link removed for item ".$self->item->id." menu ".$menu->pid;
			}
			my $lnk = $self->result_source->resultset->find_or_create({item => $self->item->id, menu => $menu->pid, ancs => $self->id});
			push (@link_ids, $lnk->menu->pid);
		}
		$self->blog_menus->search({menu => {'-not_in' => \@link_ids}})->delete;
			
	}
}
=cut
after 'insert' => sub {
	my $self = shift;
	my $menu_item = $self->menu;
	my $local =1;
	while ($menu_item) {
#		$menu_item->count_items($self->item->contenttype->id,$self->item->view);
		$menu_item->add_to_count($self->item, $local);
		$local = 0;
		$menu_item = $menu_item->parent;
	}
};

around 'delete' => sub {
	my $orig = shift;
	my $self = shift;
	my $menu_item = $self->menu;
	my $type = $self->item->contenttype->id;
	my $level = $self->item->view;
	$self->$orig(@_);
	while ($menu_item) {
		$menu_item->count_items($type,$level);
		$menu_item = $menu_item->parent;
	}
	
};
=cut

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
