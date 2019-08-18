use utf8;
package ClubTriumph::Schema::Result::Application;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Application

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

=head1 TABLE: C<applications>

=cut

__PACKAGE__->table("applications");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 surname

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address1

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address2

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address3

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address4

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address5

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 tel

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 area

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 paytype

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 payref

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 principle_member

  data_type: 'integer'
  is_nullable: 1

=head2 user

  data_type: 'integer'
  is_nullable: 1

=head2 memno

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "surname",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address1",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address2",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address3",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address4",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address5",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "postcode",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "tel",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "area",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "paytype",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "payref",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "principle_member",
  { data_type => "integer", is_nullable => 1 },
  "user",
  { data_type => "integer", is_nullable => 1 },
  "memno",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2015-11-06 19:27:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/BoeMbHjgBKQ4lxCFuTKZw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
