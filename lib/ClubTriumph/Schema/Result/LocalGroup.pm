use utf8;
package ClubTriumph::Schema::Result::LocalGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::LocalGroup

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

=head1 TABLE: C<local_groups>

=cut

__PACKAGE__->table("local_groups");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 organiser

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 description

  data_type: 'mediumtext'
  is_nullable: 1

=head2 member_info

  data_type: 'mediumtext'
  is_nullable: 1

=head2 colr

  data_type: 'integer'
  is_nullable: 1

=head2 county_filter

  data_type: 'mediumtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "organiser",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "description",
  { data_type => "mediumtext", is_nullable => 1 },
  "member_info",
  { data_type => "mediumtext", is_nullable => 1 },
  "colr",
  { data_type => "integer", is_nullable => 1 },
  "county_filter",
  { data_type => "mediumtext", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 club_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->has_many(
  "club_roles",
  "ClubTriumph::Schema::Result::ClubRole",
  { "foreign.local_group" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 group_meetings

Type: has_many

Related object: L<ClubTriumph::Schema::Result::GroupMeeting>

=cut

__PACKAGE__->has_many(
  "group_meetings",
  "ClubTriumph::Schema::Result::GroupMeeting",
  { "foreign.local_group" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 members

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->has_many(
  "members",
  "ClubTriumph::Schema::Result::Member",
  { "foreign.local_group" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 members_lg_preferences

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->has_many(
  "members_lg_preferences",
  "ClubTriumph::Schema::Result::Member",
  { "foreign.lg_preference" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 memforms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->has_many(
  "memforms",
  "ClubTriumph::Schema::Result::Memform",
  { "foreign.local_group" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.local_group" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organiser

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "organiser",
  "ClubTriumph::Schema::Result::Member",
  { memno => "organiser" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bF7CGvnQUE1XoXg6dUEfbQ

__PACKAGE__->many_to_many(items => 'blog_groups', 'item');

sub html {
	my $self = $_[0];
	return $self -> title;

}

sub blogs {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '2'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}
sub images {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '3'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}

sub image_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '3'})
}

sub blog_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '2'})
}

sub champ_points {
	my $self = $_[0];
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
	if ($year < 1900) {$year += 1900}; 
	return $self->members->search_related('champpoints',{year => $year},{prefetch => 'championship_pt'})->get_column('points')->sum
}

sub distance {
	my ($self, $location) = @_;
	my $distance;
	my @meetings = $self->group_meetings;
	foreach my $meeting (@meetings) {
		if ($meeting->location && $meeting->location->latitude && $meeting->location->longitude) {
			if (!defined($distance) || ($meeting->distance($location)->value() < $distance->value())) {
				$distance = $meeting->distance($location)
			}
		}
	}
	return $distance;
}

sub title_distance {
	my ($self, $location) = @_;
	return $self->title.' ('.$self->distance($location).')'
}

sub colour {
	my $self = shift;
	my @distances ;
	foreach my $meeting ($self->result_source->schema->resultset('GroupMeeting')->search({local_group => {'!=' => $self->id}}))  {
		my $distance = $meeting->location->distance({lat => $self->group_meetings->first->location->latitude, lon => $self->group_meetings->first->location->longitude})->value('miles');
		if (!$distances[$meeting->local_group->colr] || ($distances[$meeting->local_group->colr] > $distance)) {
			$distances[$meeting->local_group->colr] = $distance 
		}
	}
	my $colour =1;
	my $distance;
	foreach my $i  (1,2,3,4,5) {
		if (!$distances[$i] || ($distances[$i] > $distance)) {
			$colour = $i;
			$distance = $distances[$i];
		}
	}

	$self->update({colr => $colour})
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
