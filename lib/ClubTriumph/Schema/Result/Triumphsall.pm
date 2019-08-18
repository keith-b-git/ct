use utf8;
package ClubTriumph::Schema::Result::Triumphsall;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Triumphsall

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

=head1 TABLE: C<triumphsall>

=cut

__PACKAGE__->table("triumphsall");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 triumph

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 body

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 first

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 last

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 home

  data_type: 'integer'
  is_nullable: 1

=head2 export

  data_type: 'integer'
  is_nullable: 1

=head2 bhp

  data_type: 'integer'
  is_nullable: 1

=head2 torque

  data_type: 'integer'
  is_nullable: 1

=head2 top_speed

  data_type: 'integer'
  is_nullable: 1

=head2 zero_sixty

  data_type: 'float'
  is_nullable: 1

=head2 cc

  data_type: 'integer'
  is_nullable: 1

=head2 front_susp

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 rear_susp

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 steering

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 engtype

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 front_brakes

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 rear_brakes

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 width

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 length

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 height

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 text

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "triumph",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "body",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "first",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "last",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "home",
  { data_type => "integer", is_nullable => 1 },
  "export",
  { data_type => "integer", is_nullable => 1 },
  "bhp",
  { data_type => "integer", is_nullable => 1 },
  "torque",
  { data_type => "integer", is_nullable => 1 },
  "top_speed",
  { data_type => "integer", is_nullable => 1 },
  "zero_sixty",
  { data_type => "float", is_nullable => 1 },
  "cc",
  { data_type => "integer", is_nullable => 1 },
  "front_susp",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "rear_susp",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "steering",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "engtype",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "front_brakes",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "rear_brakes",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "width",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "length",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "height",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "text",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 body

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Body>

=cut

__PACKAGE__->belongs_to(
  "body",
  "ClubTriumph::Schema::Result::Body",
  { id => "body" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.car" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 registers

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Register>

=cut

__PACKAGE__->has_many(
  "registers",
  "ClubTriumph::Schema::Result::Register",
  { "foreign.triumph" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 triumph

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Triumph>

=cut

__PACKAGE__->belongs_to(
  "triumph",
  "ClubTriumph::Schema::Result::Triumph",
  { id => "triumph" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-03-20 19:02:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pUEqlrIlHCP+R9Bo1j21SQ

sub on_register {
	my $self = $_[0];
	return $self->registers->count;
}

sub in_club {
	my $self = $_[0];
#	my $extime = $self->registers->result_source->schema->storage->datetime_parser->format_datetime(time);
#	my $extime = DateTime->now->subtract(months => 1);
#	my $parser = $self->registers->result_source->schema->storage->datetime_parser;
#	return $self->registers->count({
#		-and => ['memno.memno' => {'>' => 1},
#		 -or => ['memno.expdate' => {'>' => $extime},
#		 'memno.class' => 'HON']]},
#		 {prefetch => 'memno'});
return $self->registers->in_club
}

sub fullname {
	my $self = $_[0];
	return $self->triumph->model->model.$self->triumph->mark->mark.' '.$self->body->body
}

sub shortname {
	my $self = $_[0];
	if ($self->triumph && $self->triumph->model && $self->triumph->mark) {
		return $self->triumph->model->model.$self->triumph->mark->mark
	}
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
