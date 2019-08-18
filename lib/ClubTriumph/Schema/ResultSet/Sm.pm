package ClubTriumph::Schema::ResultSet::Sm;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub new_sms {
	my ($self,$c) = @_;
	my $time;
	if ($c->req->params->{unix_time}) {
		$time = DateTime->from_epoch(epoch => $c->req->params->{unix_time});
	}
	else {
		$time = DateTime->now;
	}
	use Phone::Number;
	my $orig = new Phone::Number($c->req->params->{originator});
	my $dest = new Phone::Number($c->req->params->{destination});
	my $sms = $self->new_result({
		originator => $orig->formatted,
		destination => $dest->formatted,
		message => $c->req->params->{message},
		time => $time,
		udh => $c->req->params->{udh} || undef,
		messid => $c->req->params->{id} || $time->epoch
	});
	$sms->insert;
	return $sms;
}
1;
