package ClubTriumph::Schema::ResultSet::Memform;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub remove_ophans {
	my $self = shift;
	$self->search({main_member => undef, area => undef, country => undef})->delete
}

1;
