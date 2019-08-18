use utf8;
package ClubTriumph::Schema::Result::Active;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Active

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

=head1 TABLE: C<active>

=cut

__PACKAGE__->table("active");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_nullable: 1

=head2 ip_address

  data_type: 'text'
  is_nullable: 1

=head2 robot_string

  data_type: 'text'
  is_nullable: 1

=head2 time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: 'current_timestamp()'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_nullable => 1 },
  "ip_address",
  { data_type => "text", is_nullable => 1 },
  "robot_string",
  { data_type => "text", is_nullable => 1 },
  "time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => "current_timestamp()",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-05 17:31:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rXTKVIzAFtNoZqZfNi0Obw

__PACKAGE__->add_columns(
	"time",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1, timezone => "UTC" },
);
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
