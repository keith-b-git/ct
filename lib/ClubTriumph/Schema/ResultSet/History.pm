package ClubTriumph::Schema::ResultSet::History;
 
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
 
    my @recent = $self->search({
        'time' => { '>' => $date_str }
    },{columns => 'user'});
    return @recent;
}
 
sub recent {
	my ($self,$user,$rows) =@_;
	return unless $user;
	my $history = $self->search_rs({user => $user->id}, { columns => ['menu','time'], distinct => 1, order_by => { -desc => 'time'}}); #rows => $rows,
	my $menu_items = $history->related_resultset('menu');
	return $menu_items->viewable($user)->search({}, {rows => $rows, group_by => ['pid']});
}
 
sub popular {
	my ($self,$user,$rows) =@_;
	my $history = $self->search_rs({}, { columns => ['menu','popularity'], distinct => 1, order_by => { -desc => 'popularity'}}); #rows => $rows,
	my $menu_items = $history->related_resultset('menu');
	return $menu_items->viewable($user)->search({}, {rows => $rows, group_by => ['pid']});
} 

sub prune { #removal old guff
	my $self = shift;
	my $prunedate = DateTime->now->clone->subtract(years => 1);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	$self->search({time => {'<' => $dtf->format_datetime($prunedate)}})->delete;
}

1;
