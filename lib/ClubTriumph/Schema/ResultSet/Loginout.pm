package ClubTriumph::Schema::ResultSet::Loginout;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 


sub prune { #removal old guff
	my $self = shift;
	my $prunedate = DateTime->now->clone->subtract(years => 1);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	$self->search({time => {'<' => $dtf->format_datetime($prunedate)}})->delete;
}

1;
