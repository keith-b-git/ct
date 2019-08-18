package ClubTriumph::Schema::ResultSet::Active;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';


sub current {
	my ($self) = shift;
	my @results;
	my $oldest = DateTime->now->subtract(hours => 1);
	$self->search({time => {'<' => $oldest}})->delete;
	foreach my $punter ($self->search({},{group_by => 'robot_string', order_by => {-desc => 'time'}})) {
		push (@results, {name =>$punter->robot_string, user => $punter->user, count => $self->count({robot_string => $punter->robot_string})});
	}
	return \@results;
}


1;
 
