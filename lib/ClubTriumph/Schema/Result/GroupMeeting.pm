use utf8;
package ClubTriumph::Schema::Result::GroupMeeting;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::GroupMeeting

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

=head1 TABLE: C<group_meetings>

=cut

__PACKAGE__->table("group_meetings");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 location

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 day_of_week

  data_type: 'integer'
  is_nullable: 1

=head2 week_of_month

  data_type: 'integer'
  is_nullable: 1

=head2 local_group

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 time

  data_type: 'time'
  is_nullable: 1

=head2 frequency

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "location",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "day_of_week",
  { data_type => "integer", is_nullable => 1 },
  "week_of_month",
  { data_type => "integer", is_nullable => 1 },
  "local_group",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "time",
  { data_type => "time", is_nullable => 1 },
  "frequency",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 local_group

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->belongs_to(
  "local_group",
  "ClubTriumph::Schema::Result::LocalGroup",
  { id => "local_group" },
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
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2015-03-23 12:13:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vEQcQ98+PqUa9zPxpSDdGg


sub nextmeeting
{
	my ($self,$startdate)  = @_;
	if ($self->week_of_month >5 ) {return ''}
	my $secondsinday=60*60*24;
	my $testdate=time;
	if ($startdate) {$testdate = $startdate}
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$ydat,$isdst)=localtime($testdate);
	my $lastdate;
	my $found=0;
	my $lmon=$mon;
	while ($found==0)
	{
		($sec,$min,$hour,$mday,$mon,$year,$wday,$ydat,$isdst)=localtime($testdate);
		$year += 1900;

		{

      	if (($wday==$self->day_of_week)&&($mday>($self->week_of_month)*7)&&
      	($mday<(($self->week_of_month)*7+8))&&
      	(!($self-> frequency)||($self-> frequency eq "monthly")
			||(($self-> frequency eq "odd")&&(int($mon/2) == ($mon/2)))
			||(($self-> frequency eq "even")&&(int($mon/2) != ($mon/2)))))
				{$found=1}
      	if (($self->week_of_month)==4)
      		{
      		if (($mon!=$lmon)&&$lastdate)
      			{$found=1;  
      			($sec,$min,$hour,$mday,$mon,$year,$wday,$ydat,$isdst)=localtime($lastdate);
      			$year += 1900;
      			}
      		if ($wday==$self->day_of_week) {$lastdate=$testdate}
      		$lmon=$mon;
      		}
		}
     	$testdate += $secondsinday;

	}
$mon+=1;
return "$mday/$mon/$year";
}

sub meeting_between {
	my ($self, $startep, $endep, $user) = @_;
	my $nextmeeting = $self->nextmeeting($startep);
	return unless ($nextmeeting);
	my ($mday,$mon,$year) = split(/\//,$nextmeeting);
	my ($hour,$minute,$second) = split (/:/,$self->time);
	use Time::Local;
	my $meetingep = timegm($second,$minute,$hour,$mday,$mon-1,$year);
	if ($meetingep < $endep + 24*60*60) {return {next => $meetingep, meeting => $self}}
}

sub meetingtext
{
	my $self = $_[0];

	my @week = ('first', 'second', 'third', 'fourth', 'last');
	my @weekday = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
	my %frequency = (''=>'every month','monthly'=>'every month', 'odd'=>'odd months', 'even' => 'even months');
	my $time = $self -> time;
	$time =~ s/:00$//;
	return 'on the '.$week[$self->week_of_month].' '. $weekday[$self->day_of_week].' of '.$frequency{$self->frequency}.' at '.$time;
}

	
	
sub html {
	my $self = $_[0];
	my $html = '<STRONG>'.$self-> local_group -> title.'</STRONG><BR><small>meets at - </small>';
	$html.= $self-> location -> html;
	$html.= '<small>next meeting- </small>'.$self-> nextmeeting.'<br>';
	if ($self -> editable) {$html .= '<small><small><a href = "/group_meeting/'.$self -> id.'/edit">edit</a></small></small>'}
	return $html
}
	
	
sub editable {
	return 1
	
}
	
sub distance {
	my ($self,$location) = @_;
	return unless ($location);
	use GIS::Distance;
	my $gis = GIS::Distance->new();
	my $distance = $gis->distance($self->location->latitude,$self->location->longitude => $$location{lat}, $$location{lon});
	return $distance
}
	
	



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
