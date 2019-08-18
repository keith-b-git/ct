package ClubTriumph::Schema::ResultSet::User;
use utf8;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub active {
    my ($self, $mins) = @_;
    my $datetime = DateTime->now->subtract(minutes => $mins);
    my $date_str = $self->result_source->schema->storage
                          ->datetime_parser->format_datetime($datetime);
 
#    return $self->search_related('histories' => {
#        time => { '>' => $date_str }
    return $self->search({
        'histories.time' => { '>' => $date_str }
    },{prefetch => 'histories'});   #, 'collapse' => 1, 'columns' => 'username'
}
 
1;
