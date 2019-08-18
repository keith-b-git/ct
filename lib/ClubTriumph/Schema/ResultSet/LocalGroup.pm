package ClubTriumph::Schema::ResultSet::LocalGroup;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 


sub sorted{
	my $self = shift;
	return $self->search({},{order_by => 'title'});
}

1;
