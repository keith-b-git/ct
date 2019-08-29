package ClubTriumph::Controller::calendar;
use Moose;
use namespace::autoclean;
use Time::Local;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::calendar - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub events : Local {
	my($self, $c) = @_;
	my ($year,$mon,$mday) = split(/-/,$c->req->params->{start});
	my $startep = timelocal(0,0,0,$mday,$mon-1,$year);
	($year,$mon,$mday) = split(/-/,$c->req->params->{end});
	my $endep = timelocal(0,0,0,$mday,$mon-1,$year);
	my @events;
	my @ctevents = $c->model('ClubTriumphDB::Event')->events_between($startep,$endep);
	foreach my $event (@ctevents) {
		if ($event->title&& $event->id && $event->start && $event->end && $event->menus) {
		my $colour = '#7080FF';
		if ($event->entered_by($c->user)) {$colour = '#ff2020'}
		push ( @events, {
			title => $event->title,
			start => $event->start->iso8601(),
			end => $event->end->iso8601(),
			id => $event->id,
			url => '/menu/'.$event->menus->first->pid.'/view',
			color => $colour
			} );
		}
	}

	my @meetings = $c->model('ClubTriumphDB::GroupMeeting')->meetings_between($startep,$endep);
	foreach my $meeting (@meetings) {
		my $start = DateTime->from_epoch(epoch => $$meeting{next})->iso8601();
		my $end = DateTime->from_epoch(epoch => $$meeting{next}+120*60, time_zone => 'Europe/London')->iso8601();
		my $url = '';
		if ($$meeting{meeting}->local_group && $$meeting{meeting}->local_group->menus && $$meeting{meeting}->local_group->menus->first) {$url = '/menu/'.$$meeting{meeting}->local_group->menus->first->pid.'/view'}
		my $colour = '#808080';
		if ($c->user && $c->user->club_member && ($c->user->memno->local_group->id == $$meeting{meeting}->local_group->id)) {$colour = '#ff2020'}
		push (@events, {
			title => $$meeting{meeting}->local_group->title.' group meeting',
			start => $start,
			end => $end,
			id => $$meeting{meeting}->id,
			url => $url,
			color => $colour
		})
	}
	$c->stash('json_data' => \@events);
	$c->forward('View::JSON');
}

sub cal_events :Chained('/menu/base') :PathPart('cal_events') :Args(0) {
	my($self, $c) = @_;
	my ($year,$mon,$mday) = split(/-/,$c->req->params->{start});
	my $startep = timelocal(0,0,0,$mday,$mon-1,$year);
	($year,$mon,$mday) = split(/-/,$c->req->params->{end});
	my $endep = timelocal(0,0,0,$mday,$mon-1,$year);
	my @events;
	my @ctevents = $c->stash->{menu_item}->descendants->related_resultset('event')->events_between($startep,$endep);
	foreach my $event (@ctevents) {
		if ($event->title&& $event->id && $event->start && $event->end && $event->menus) {
		my $colour = '#7080FF';
		if ($event->entered_by($c->user)) {$colour = '#ff2020'}
		push ( @events, {
			title => $event->title,
			start => $event->start->iso8601(),
			end => $event->end->iso8601(),
			id => $event->id,
			url => '/menu/'.$event->menus->first->pid.'/view',
			color => $colour
			} );
		}
	}

	my @meetings = $c->stash->{menu_item}->descendants->related_resultset('local_group')->related_resultset('group_meetings')->meetings_between($startep,$endep);
	foreach my $meeting (@meetings) {
		my $start = DateTime->from_epoch(epoch => $$meeting{next})->iso8601();
		my $end = DateTime->from_epoch(epoch => $$meeting{next}+120*60, time_zone => 'Europe/London')->iso8601();
		my $url = '';
		if ($$meeting{meeting}->local_group && $$meeting{meeting}->local_group->menus && $$meeting{meeting}->local_group->menus->first) {$url = '/menu/'.$$meeting{meeting}->local_group->menus->first->pid.'/view'}
		my $colour = '#808080';
		if ($c->user && $c->user->club_member && ($c->user->memno->local_group->id == $$meeting{meeting}->local_group->id)) {$colour = '#ff2020'}
		push (@events, {
			title => $$meeting{meeting}->local_group->title.' group meeting',
			start => $start,
			end => $end,
			id => $$meeting{meeting}->id,
			url => $url,
			color => $colour
		})
	}
	$c->stash('json_data' => \@events);
	$c->forward('View::JSON');
}



=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
