use utf8;
package ClubTriumph::Schema::Result::Pm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Pm

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

=head1 TABLE: C<pm>

=cut

__PACKAGE__->table("pm");

=head1 ACCESSORS

=head2 userpm

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 itempm

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 unread

  data_type: 'tinyint'
  is_nullable: 1

=head2 folder

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "userpm",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "itempm",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "unread",
  { data_type => "tinyint", is_nullable => 1 },
  "folder",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</userpm>

=item * L</itempm>

=back

=cut

__PACKAGE__->set_primary_key("userpm", "itempm");

=head1 RELATIONS

=head2 itempm

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "itempm",
  "ClubTriumph::Schema::Result::Item",
  { id => "itempm" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 userpm

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "userpm",
  "ClubTriumph::Schema::Result::User",
  { id => "userpm" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aRLZtRlqT4wnAeQ67PrkhA

__PACKAGE__->add_unique_constraint(
  user_item_folder => [ qw/userpm itempm folder/],
);

around 'delete' => sub { #delete item if there are now pms attached.
	my $orig = shift;
	my $self = shift;
	my $item = $self->itempm;
	$self->$orig(@_);
	unless ($item->pms->count({})) {$item->delete}
};


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
