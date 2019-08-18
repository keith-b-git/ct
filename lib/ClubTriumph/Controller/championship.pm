package ClubTriumph::Controller::championship;
use Moose;
use ClubTriumph::Form::Championship;
use ClubTriumph::Form::Champpoints;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::championship - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::championship in championship.');
}

sub championship :Chained('/menu/base') :PathPart('championship') :CaptureArgs(0) {
	my ($self, $c) = @_;
	$c->stash(championship => $c->stash->{menu_item}->championship);
	die "Championship not found!" if !$c->stash->{championship};
	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for Club Role ***");
}

 sub create :  Chained('/menu/base') PathPart('new_championship') Args(0)  {
	my ($self, $c ) = @_;

	my $championship = $c->model('ClubTriumphDB::Championship')->new_result({});
	$c->stash(formtitle => 'Creating New Championship');
	return $self->champform($c, $championship);
	}

 sub create_challenge :  Chained('/menu/base') PathPart('new_challenge') Args(0)  {
	my ($self, $c ) = @_;

	my $championship = $c->model('ClubTriumphDB::Championship')->new_result({});
	$c->stash(formtitle => 'Creating New Challenge');
	return $self->form($c, $championship);
	}

sub edit : Chained('championship') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(formtitle => 'Editing '.$c->stash->{championship}->title);
	if ($c->stash->{championship}->events->count({}) || ($c->stash->{menu_item}->title =~ /challenge/i)) {
		return $self->form($c, $c->stash->{championship});
	} else {
		return $self->champform($c, $c->stash->{championship});
	}
}



sub form  {
	my ( $self, $c, $championship ) = @_;

	my $form = ClubTriumph::Form::Championship->new(events_rs => $c->model('ClubTriumphDB::Event') );
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $championship );
	$form->process( item => $championship, params => $c->req->params, user => $c->user, events_rs => $c->model('ClubTriumphDB::Event') );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("championship edited")}));
	}

sub champform  {
	my ( $self, $c, $championship ) = @_;

	my $form = ClubTriumph::Form::Championship->new(events_rs => $c->model('ClubTriumphDB::Event') );
	$c->stash( template => 'menu/simpleform.tt2', form => $form );
	$form->process( item => $championship, params => $c->req->params, user => $c->user, events_rs => $c->model('ClubTriumphDB::Event'),
	inactive => ['events','add_element']
	 );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("championship edited")}));
	}


sub points : Chained('championship') PathPart('points') Args(1) {
	my ( $self, $c, $eventid ) = @_;
	my $event = $c->model('ClubTriumphDB::Event')->find($eventid);
	$c->stash(formtitle => 'Adding '.$event->title.' points for '.$c->stash->{championship}->title);
	return $self->pointsform($c, $c->stash->{championship}, $event);
}

sub champpoints : Chained('championship') PathPart('champpoints') Args(0) {
	my ( $self, $c, $eventid ) = @_;
	$c->stash(formtitle => 'Adding points for '.$c->stash->{championship}->title);
	return $self->pointsform($c, $c->stash->{championship});
}



sub pointsform  {
	my ( $self, $c, $championship, $event ) = @_;
	my $inactive;
	my $resultset;
	if ($event) {
		$resultset = $championship->champpoints_rs->search_rs({'eventpts' => $event->id});
		$inactive = ['none'];
	} else {
		$inactive = ['champpoints.eventpts', 'eventtitle'];
		$resultset = $championship->champpoints_rs;
	}
		
	my $form = ClubTriumph::Form::Champpoints->new(members_rs => $c->model('ClubTriumphDB::Member'), 
		event => $event, 
		resultset => $resultset,
		inactive => $inactive );
	
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $championship );
	$form->process(  params => $c->req->params, user => $c->user, members_rs => $c->model('ClubTriumphDB::Member'), event => $event );#item => $championship,
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("championship edited")}));
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
