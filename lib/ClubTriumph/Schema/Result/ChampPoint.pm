use utf8;
package ClubTriumph::Schema::Result::ChampPoint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::ChampPoint

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

=head1 TABLE: C<champ_points>

=cut

__PACKAGE__->table("champ_points");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 points

  data_type: 'integer'
  is_nullable: 1

=head2 championship_pts

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 member_pts

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 event_pts

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 event_title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "points",
  { data_type => "integer", is_nullable => 1 },
  "championship_pts",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "member_pts",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "event_pts",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "event_title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 championship_pt

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Championship>

=cut

__PACKAGE__->belongs_to(
  "championship_pt",
  "ClubTriumph::Schema::Result::Championship",
  { id => "championship_pts" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 event_pt

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event_pt",
  "ClubTriumph::Schema::Result::Event",
  { id => "event_pts" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 member_pt

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "member_pt",
  "ClubTriumph::Schema::Result::Member",
  { memno => "member_pts" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-11-24 17:05:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hdbnnPknIqTfhLU24OobiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
