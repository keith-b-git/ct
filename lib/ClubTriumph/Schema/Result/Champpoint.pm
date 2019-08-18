use utf8;
package ClubTriumph::Schema::Result::Champpoint;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Champpoint

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

=head1 TABLE: C<champpoints>

=cut

__PACKAGE__->table("champpoints");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 points

  data_type: 'integer'
  is_nullable: 1

=head2 championship_pts

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 memberpts

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 eventpts

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
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "points",
  { data_type => "integer", is_nullable => 1 },
  "championship_pts",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "memberpts",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "eventpts",
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
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 eventpt

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "eventpt",
  "ClubTriumph::Schema::Result::Event",
  { id => "eventpts" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 memberpt

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "memberpt",
  "ClubTriumph::Schema::Result::Member",
  { memno => "memberpts" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-12-06 17:19:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MHN8SMulTfcl8v9RSTPYIQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
