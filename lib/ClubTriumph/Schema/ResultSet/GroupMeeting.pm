package ClubTriumph::Schema::ResultSet::GroupMeeting;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 


sub meetings_between {
	my ($self, $start, $end, $user) = @_;
	my @meetings;
	foreach my $meeting ($self->all) {
		my $nextmeet = $meeting->meeting_between($start,$end);
		if ($nextmeet) {push (@meetings, $nextmeet)}
	}
	return @meetings;
}

1;
