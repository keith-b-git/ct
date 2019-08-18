use utf8;
package ClubTriumph::Schema::Result::ClubRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::ClubRole

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

=head1 TABLE: C<club_roles>

=cut

__PACKAGE__->table("club_roles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 description

  data_type: 'mediumtext'
  is_nullable: 1

=head2 club_role

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 club_event

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 local_group

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 club_officer

  data_type: 'integer'
  is_nullable: 1

=head2 front_page

  data_type: 'integer'
  is_nullable: 1

=head2 comps_page

  data_type: 'integer'
  is_nullable: 1

=head2 access_level

  data_type: 'integer'
  is_nullable: 1

=head2 editor_of

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 membership_admin

  data_type: 'tinyint'
  is_nullable: 1

=head2 public_email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 club_email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 public_tel

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 club_tel

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "description",
  { data_type => "mediumtext", is_nullable => 1 },
  "club_role",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "club_event",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "local_group",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "club_officer",
  { data_type => "integer", is_nullable => 1 },
  "front_page",
  { data_type => "integer", is_nullable => 1 },
  "comps_page",
  { data_type => "integer", is_nullable => 1 },
  "access_level",
  { data_type => "integer", is_nullable => 1 },
  "editor_of",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "membership_admin",
  { data_type => "tinyint", is_nullable => 1 },
  "public_email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "club_email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "public_tel",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "club_tel",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 club_event

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "club_event",
  "ClubTriumph::Schema::Result::Event",
  { id => "club_event" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 editor_of

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Contenttype>

=cut

__PACKAGE__->belongs_to(
  "editor_of",
  "ClubTriumph::Schema::Result::Contenttype",
  { id => "editor_of" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 local_group

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->belongs_to(
  "local_group",
  "ClubTriumph::Schema::Result::LocalGroup",
  { id => "local_group" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 member_club_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::MemberClubRole>

=cut

__PACKAGE__->has_many(
  "member_club_roles",
  "ClubTriumph::Schema::Result::MemberClubRole",
  { "foreign.club_role" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menu_linked_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menu_linked_roles",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.linked_role" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menu_managers

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menu_managers",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.manager" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.club_role" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 members

Type: many_to_many

Composing rels: L</member_club_roles> -> member

=cut

__PACKAGE__->many_to_many("members", "member_club_roles", "member");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-18 17:43:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:laQK+27j6avEy4BHPspwrQ

sub incumbents {
	my $self=shift;
	return $self->members->current_members
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
