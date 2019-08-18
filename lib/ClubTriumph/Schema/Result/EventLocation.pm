use utf8;
package ClubTriumph::Schema::Result::EventLocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::EventLocation

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

=head1 TABLE: C<event_location>

=cut

__PACKAGE__->table("event_location");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 event_

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 location

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 context

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "event_",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "location",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "context",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 event

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "ClubTriumph::Schema::Result::Event",
  { id => "event_" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 location

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Location>

=cut

__PACKAGE__->belongs_to(
  "location",
  "ClubTriumph::Schema::Result::Location",
  { id => "location" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-12-11 17:30:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uweXSv0XCyzoIi+Dv66Q3g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
