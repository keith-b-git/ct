package ClubTriumph::Schema::ResultSet::Register;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub in_club { 
	my $self = $_[0];
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $extime = DateTime->now->subtract(months => 1);
	my $now = DateTime->now;
	my $me = $self->current_source_alias;
	return $self->count({
		-and => ['memno.memno' => {'>' => 1},
		 -or => ['memno.expdate' => {'>' => $dtf->format_datetime($extime)},
		 'memno.class' => 'HON'],
		 "$me.sold" =>  undef]},
		 {prefetch => 'memno'});
}
 
sub club_cars { 
	my $self = $_[0];
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $extime = DateTime->now->subtract(months => 1);
	my $now = DateTime->now;
	my $me = $self->current_source_alias;
	return $self->search({
		-and => ['memno.memno' => {'>' => 1},
		 -or => ['memno.expdate' => {'>' => $dtf->format_datetime($extime)},
		 'memno.class' => 'HON'],
		 "$me.sold" => undef]},
		 {prefetch => 'memno'});
} 

1;
