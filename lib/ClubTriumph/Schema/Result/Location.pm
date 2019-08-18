use utf8;
package ClubTriumph::Schema::Result::Location;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Location

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

=head1 TABLE: C<locations>

=cut

__PACKAGE__->table("locations");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

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

=head2 county

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 town

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 country

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 latitude

  data_type: 'float'
  is_nullable: 1

=head2 longitude

  data_type: 'float'
  is_nullable: 1

=head2 grid_ref

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 created_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address1",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address2",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "county",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "town",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "postcode",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "country",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "latitude",
  { data_type => "float", is_nullable => 1 },
  "longitude",
  { data_type => "float", is_nullable => 1 },
  "grid_ref",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "created_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 created_by

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "ClubTriumph::Schema::Result::User",
  { id => "created_by" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 event_locations

Type: has_many

Related object: L<ClubTriumph::Schema::Result::EventLocation>

=cut

__PACKAGE__->has_many(
  "event_locations",
  "ClubTriumph::Schema::Result::EventLocation",
  { "foreign.location" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_meetings

Type: has_many

Related object: L<ClubTriumph::Schema::Result::GroupMeeting>

=cut

__PACKAGE__->has_many(
  "group_meetings",
  "ClubTriumph::Schema::Result::GroupMeeting",
  { "foreign.location" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.location" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-01 14:38:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CqhBfaBtLJYSM4o8X6Xkjg
use Geography::Countries;

sub editable {
	return 1
}

sub html
{
	my $self = $_[0];
	my $html;
	if ($self->name) {$html .= '<STRONG>'.$self->name.'</STRONG><BR>'}
	if (editable) {$html .= ' <small><small><a href = "/location/id/'.$self -> id.'/edit">edit location</a></small></small><br>'}
	if (editable) {$html .= ' <small><small><a href = "/location/id/'.$self -> id.'/delete">delete location</a></small></small><br>'}
	if ($self->address1) {$html .= $self->address1.'<BR>'}
	if ($self->address2) {$html .= $self->address2.'<BR>'}
	if ($self->town) {$html .= $self->town.'<BR>'}
	if ($self->county) {$html .= $self->county.'<BR>'}
	if ($self->postcode) {$html .= $self->postcode.'<BR>'}
	if ($self->country) {$html .= $self->country.'<BR>'}
	if ($self->grid_ref) {$html .= '<small>Grid Ref- </small>'.$self->grid_ref.'<BR>'}
	if ($self->longitude) {$html .= '<small>Longitude- </small>'.$self->longitude.'<BR>'}
	if ($self->latitude) {$html .= '<small>Latitude </small>'.$self->latitude.'<BR>'}
	return $html
}

sub name_town {
	my $self = $_[0];
	my $stuff = $self->name;
	if ($self->address1) {$stuff .= ', '.$self->address1, return $stuff}
	if ($self->address2) {$stuff .= ', '.$self->address2, return $stuff}
	if ($self->town) {$stuff .= ', '.$self->town, return $stuff}
	if ($self->county) {$stuff .= ', '.$self->county, return $stuff}
	return $stuff;
	}

sub full_address { #returns address as string, will include country unless it is the same as the one given
	my ($self,$country) = @_;
	my $stuff ='';
	if ($self->address1) {$stuff .= ', '.$self->address1}
	if ($self->address2) {$stuff .= ', '.$self->address2}
	if ($self->town) {$stuff .= ', '.$self->town}
	if ($self->county) {$stuff .= ', '.$self->county}
	if ($self->postcode) {$stuff .= ', '.$self->postcode}
	if ($self->country && $self->country ne $country) {$stuff .= ', '.country($self->country)}
	$stuff =~ s/^, //;
	return $stuff;
	}

sub distance {
	my ($self,$location) = @_;
	return unless ($location);
	use GIS::Distance;
	my $gis = GIS::Distance->new();
	my $distance = $gis->distance($self->latitude,$self->longitude => $$location{lat}, $$location{lon});
	return $distance
}


__PACKAGE__->many_to_many(events => 'event_locations', 'event');


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
