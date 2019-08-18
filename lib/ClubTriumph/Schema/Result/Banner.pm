use utf8;
package ClubTriumph::Schema::Result::Banner;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Banner

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

=head1 TABLE: C<banners>

=cut

__PACKAGE__->table("banners");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 image_top

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 image_bottom

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 image_mpu

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 url_top

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 url_bottom

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 url_mpu

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 active

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "image_top",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "image_bottom",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "image_mpu",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "url_top",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "url_bottom",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "url_mpu",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "active",
  { data_type => "integer", is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<id>

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->add_unique_constraint("id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aS+6tLQsQf6r6AojuPBVqA

sub valid { #
	my ($self,$c) = @_;
	return $self->active;
}

sub image {
	my ($self,$type) = @_;
	my $field = "image_$type";
	return $self->$field;
}

sub url {
	my ($self,$type) = @_;
	my $field = "url_$type";
	return $self->$field;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
