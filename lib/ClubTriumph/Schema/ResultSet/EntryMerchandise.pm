package ClubTriumph::Schema::ResultSet::EntryMerchandise;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
sub findoption {
	my ($self,$option)  = @_;
	return $self->search({merchandise => $option})->first
}

1;
