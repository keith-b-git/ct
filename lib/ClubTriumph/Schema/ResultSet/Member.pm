package ClubTriumph::Schema::ResultSet::Member;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub associates {
    my ($self, $memno) = @_;
    my $obj = $self -> find ($memno);
	my $assocs = $obj->assocs;
	my @assocs = split (/ /,$assocs);

	return $self->search({memno => {-in =>  [@assocs]}});

}


sub current_members { 
	my ($self,$date) = @_;
	unless ($date) {$date = DateTime->now}
	my $extime = $date->clone->truncate(to => 'month')->subtract(months => 1);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->search({
		-and => ['memno' => {'>' => 1},
		 -or => [-and => ['expdate' => {'>' => $dtf->format_datetime($extime)},
		 'joindate' => {'<' => $dtf->format_datetime($date)}],
		 -and => ['class' => 'HON', -or => [expdate =>undef, expdate => '0000-00-00 00:00:00']]]]});
}

sub near_expiry { 
	my ($self,$date) = @_;
	unless ($date) {$date = DateTime->now}
	my $extime = $date->clone->truncate(to => 'month');
	my $starttime = $date->clone->add(months => 1)->truncate(to => 'month');
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->search({
		-and => ['memno' => {'>' => 1},
		 'expdate' => {'>' => $dtf->format_datetime($extime)},
		 'expdate' => {'<' => $dtf->format_datetime($starttime)}]
		 });
}

sub grace_period { 
	my ($self,$date) = @_;
	unless ($date) {$date = DateTime->now}
	my $extime = $date->clone->subtract(months => 1)->truncate(to => 'month');
	my $starttime = $date->clone->truncate(to => 'month');
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->search({
		-and => ['memno' => {'>' => 1},
		 'expdate' => {'>' => $dtf->format_datetime($extime)},
		 'expdate' => {'<' => $dtf->format_datetime($starttime)}]
		 });
}

sub expired { 
	my ($self,$date) = @_;
	unless ($date) {$date = DateTime->now}
	my $extime = $date->clone->subtract(months => 2)->truncate(to => 'month');
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->search({
		-and => ['memno' => {'>' => 1},
		 'expdate' => {'>' => $dtf->format_datetime($extime)}]
		 });
}

sub wordsearch {
	my ($self,$search) = @_;
	if ($search =~ /^\d{5}$/) {
		$search =~ s/^0*//;
		return $self->search({
			memno => "$search",
			});
		}
	$search =~ /(^.*) (.*$)/;
	return $self->search({
		-or => [
		-and => [forename => {'like' => "%$1%"}, surname => {'like' => "$2"}],
		forename => {'like' => "%$search%"},
		surname => {'like' => "%$search%"},
		address1 => {'like' => "%$search%"},
		address2 => {'like' => "%$search%"},
		address3 => {'like' => "%$search%"},
		address4 => {'like' => "%$search%"},
		address5 => {'like' => "%$search%"},
		postcode => {'like' => "%$search%"},
		comments => {'like' => "%$search%"},
		email => {'like' => "%$search%"},
		]
	});
}

sub by_surname {
	my $self = shift; 
	return $self->search_rs({},{order_by => 'surname'})
}

sub viewable_by {
	my ($self,$user) = @_;
	if ($user && $user->club_member) {return $self}
	return $self->search({memno => {'<' => 1}}); #return empty set
}


1;
