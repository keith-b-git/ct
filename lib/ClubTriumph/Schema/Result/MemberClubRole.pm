use utf8;
package ClubTriumph::Schema::Result::MemberClubRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::MemberClubRole

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

=head1 TABLE: C<member_club_role>

=cut

__PACKAGE__->table("member_club_role");

=head1 ACCESSORS

=head2 member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 club_role

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "club_role",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</member>

=item * L</club_role>

=back

=cut

__PACKAGE__->set_primary_key("member", "club_role");

=head1 RELATIONS

=head2 club_role

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->belongs_to(
  "club_role",
  "ClubTriumph::Schema::Result::ClubRole",
  { id => "club_role" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 member

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "member",
  "ClubTriumph::Schema::Result::Member",
  { memno => "member" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-02-17 13:10:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Yg0the/z1kFZuxiCJHWlsA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
