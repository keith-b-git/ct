use utf8;
package ClubTriumph::Schema::Result::DbStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::DbStatus

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

=head1 TABLE: C<db_status>

=cut

__PACKAGE__->table("db_status");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 menu_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'current_timestamp()'
  is_nullable: 1

=head2 last_notification

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "menu_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "current_timestamp()",
    is_nullable => 1,
  },
  "last_notification",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-08-22 13:00:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:85/nKfw558mbC6YzdQulHg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
