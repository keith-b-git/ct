package ClubTriumph::Schema::ResultSet::ClubRole;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub shopkeeper { # just a helper to return the shopkeeper role
	my $self = shift;
	return $self->find({description => 'Club Shopkeeper'});
}

1;
