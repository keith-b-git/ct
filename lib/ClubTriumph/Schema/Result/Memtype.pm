use utf8;
package ClubTriumph::Schema::Result::Memtype;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Memtype

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

=head1 TABLE: C<memtypes>

=cut

__PACKAGE__->table("memtypes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 fee

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 joinfee

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 active

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 ass_fee

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "fee",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "joinfee",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "active",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "ass_fee",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 members

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->has_many(
  "members",
  "ClubTriumph::Schema::Result::Member",
  { "foreign.area" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 memforms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->has_many(
  "memforms",
  "ClubTriumph::Schema::Result::Memform",
  { "foreign.area" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2015-07-26 20:05:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1gYHOA47o5KSLopjlliUdg

sub desc_cost {
	my $self = $_[0];
	return $self->description.' (£'.$self->fee.')'
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
