package ClubTriumph::Schema::ResultSet::Entry;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub nondraft {
	my ($self, $c) =@_;
	return [$self->search({status => {'!=' => 'draft'}},{order_by => 'entry_no'})]
}
 
sub export_data { #generates data suitable for export
	my ($self,$c) = @_;
	my @results;
	while (my $entry = $self->next) {
		my $entrants_name;
		if ($entry->member) {$entrants_name = $entry->member->fullname}
		my $i = 1;
		my (@crew, @crewmobiles, @extras, @localgroups);
		foreach my $entrant ($entry->entrants) {
			push (@crew,$entrant->name);
			push (@crewmobiles ,$entrant->mobile);
			my $localgroup = ' ';
			if ($entrant->memno && $entrant->memno->club_member && $entrant->memno->local_group) {
				$localgroup = $entrant->memno->local_group->title
			}
			push (@localgroups, $localgroup);
			my %options;
			foreach my $extra ($entry->entry_merchandises->search({entrant => $entrant->id})) {
				$options{$extra->merchandise->id} = $extra->moption;
			}
			push (@extras, \%options);
		}
		my ($car, $regno, $year, $colour,$engine);
		if ( $entry->car) {
			if ( $entry->car->triumph && $entry->car->triumph->triumph) {$car = $entry->car->triumph->fullname}
			$regno = $entry->car->regno;
			if ($entry->car->mandate) {	$year = $entry->car->mandate->year}
			elsif ($entry->car->regdate) {	$year = $entry->car->regdate->year}
			$colour = $entry->car->colour;
			$engine = $entry->car->engsize;
		}
		elsif (!$entry->member) {
			$regno = $entry->regno;
			$engine = $entry->engine_size;
			$car = $entry->other_car
		}
		my ($town, $email);
		if ($entry->member) {
			$town = $entry->member->address4;
			$email = $entry->member->email
		}
		unless ($email) {$email = $entry->user->email if ($entry->user)}
		my %result =  (
			status => $entry->status,
			title => $entry->title,
			entry_no =>$entry->entry_no,
			entrants_name => $entrants_name,
			crew1 => $crew[0],
			crew2 => $crew[1],
			crew3 => $crew[2],
			crew4 => $crew[3],
			car => $car,
			year => $year,
			colour => $colour,
			engine => $engine,
			reg => $regno,
			town => $town,
			email => $email,
			crew_1_mobile =>$crewmobiles[0],
			crew_2_mobile =>$crewmobiles[1],
			crew_3_mobile =>$crewmobiles[2],
			crew_4_mobile =>$crewmobiles[3],
			crew1_local_group => $localgroups[0],
			crew2_local_group => $localgroups[1],
			crew3_local_group => $localgroups[2],
			crew4_local_group => $localgroups[3],
		);
		my $n = 1;
		foreach my $option (@extras) {
			foreach my $item (keys %$option) {
				$result{'crew_'.$n.'_'.$item} = $$option{$item};
			}
			$n++;
		}
		push (@results, \%result);
	}
	return \@results;
} 

sub new_sms {
	my ($self, $c, $sms) = @_;
	my $entrant = $self->search_related('entrants',{mobile => $sms->originator})->first;
	if ($entrant) {
		$entrant->team->new_sms($c,$sms)
	}
	
}

sub locatable {
	my ($self, $c) = @_; 
	my $tenminutesago = DateTime->now->subtract(minutes => 10);
	return $self->search({'telegrams.locationtime' => {'>' => $tenminutesago}},{prefetch => 'telegrams'});
}

sub find_team {
	my ($self,$text) = @_;
	return $self->search({-or => [entry_no => $text, title => $text]})
}

1;
