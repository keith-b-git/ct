package ClubTriumph::Schema::ResultSet::Event;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub ordered_events {
	my ($self,$user) = @_;
	return  $self->search({},{order_by => { -desc =>'start' },group_by => 'id'});
	
} 

sub future_events {
	my ($self,$user) = @_;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $now = DateTime->now;
	my @events = $self->search({end => {'>' =>  $dtf->format_datetime($now)}},{order_by => 'start'});
	return @events;
	
}
 
sub future_events_rs {
	my ($self,$user) = @_;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $now = DateTime->now;
	return $self->search_rs({end => {'>' =>  $dtf->format_datetime($now)}},{order_by => 'start'});

	
}
 
sub past_events {
	my ($self,$user) = @_;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my ($now) = DateTime->now;
	my @events = $self->search({end => {'<' => $dtf->format_datetime($now)}},{order_by => { -desc =>'start' }});
	return @events;
}

sub past_events_rs {
	my ($self,$user) = @_;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my ($now) = DateTime->now;
	return $self->search({end => {'<' => $dtf->format_datetime($now)}},{order_by => { -desc =>'start' }});

	
}

sub events_between {
	my ($self, $startep, $endep, $user) = @_;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $start = DateTime->from_epoch(epoch => $startep);
	my $end = DateTime->from_epoch(epoch => $endep);
	my @events = $self->search({-and => [{end => {'>=' => $dtf->format_datetime($start)}},{start => {'<=' => $dtf->format_datetime($end)}}]});
	return @events;
}

sub current_and_future {
	my $self = shift;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my ($now) = DateTime->now->subtract(years => 1);
	return $self->search({'end' => {'>=' =>  $dtf->format_datetime($now)}},{order_by => 'start', group_by => 'id'})
}

sub member_viewable {
	my $self = shift;
	my @events = $self->search({'menus.view' => {'>=' => 64}},{prefetch => 'menus'});
	return @events;
}
1;
