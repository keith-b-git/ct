package ClubTriumph::Controller::event;
use Moose;
use ClubTriumph::Form::Event_Location;
use ClubTriumph::Form::Location;
use ClubTriumph::Form::Event;
use ClubTriumph::Form::Event1;
use ClubTriumph::Form::EventMan;
use ClubTriumph::Form::EventMer;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::event - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

#sub index :Path :Args(0) {
 #   my ( $self, $c ) = @_;

 #   $c->response->body('Matched ClubTriumph::Controller::event in event.');
#}


sub base :Chained('/') :PathPart('event') :CaptureArgs(0) {
my ($self, $c) = @_;
    
	# Store the ResultSet in stash so it's available for other methods
	$c->stash(event_resultset => $c->model('ClubTriumphDB::Event'));
	$c->stash(series_resultset => $c->model('ClubTriumphDB::EventSeries'));
	$c->load_status_msgs;    
	# Print a message to the debug log
#	$c->log->debug('*** INSIDE BASE METHOD ***');
    }
=cut
sub series :Chained('base') :PathPart('series') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
	$c->stash(series => $c->stash->{series_resultset}->find($id));

	#   $c->detach('/error_404') if !$c->stash->{object};
	die "Content $id not found!" if !$c->stash->{series};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for event series id=$id ***");
}

sub series_list : Chained('base') :PathPart('serieslist') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(series => [$c->stash->{series_resultset}->all]);
	$c->stash( template => 'event/series_list.tt2');
	
}

sub create_series : Chained('base') :PathPart('createseries') :Args(0) {
	my ($self, $c ) = @_;
	my $series = $c->model('ClubTriumphDB::EventSeries')->new_result({});
        return $self->series_form($c, $series);
}

sub series_form {
	my ( $self, $c, $series ) = @_;

	my $form = ClubTriumph::Form::Event_Series->new;
	# Set the template

	$c->stash( template => 'event/series_form.tt2', form => $form, $series );
	$form->process( item => $series, params => $c->req->params, user_id => $c->user->id );
	return unless $form->validated;
	$c->response->redirect($c->uri_for( 'serieslist')); # {mid => $c->set_status_msg("Book created")}
 #        {mid => $c->set_status_msg("content created")}));
	}
	
sub series_edit : Chained('series') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->series_form($c, $c->stash->{series});
    }
=cut
sub event :Chained('/menu/base') :PathPart('event') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;
#	$c->stash(event => $c->stash->{event_resultset}->find($id));
	$c->stash(event => $c->stash->{menu_item}->event);
	#   $c->detach('/error_404') if !$c->stash->{object};
	die "Event $id not found!" if !$c->stash->{event};
	$c->stash(form_stages => $c->stash->{event}->form_stages);
	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for event id=$id ***");
}

sub create_event : Chained('/menu/base') :PathPart('createevent') :Args(0) {
	my ($self, $c ) = @_;
	$c->stash(formtitle => 'Creating New Event');
	my $event = $c->model('ClubTriumphDB::Event')->new_result({organiser => $c->user->memno});
    return $self->event_form1($c, $event);
}

sub event_delete : Chained('event') :PathPart('delete') :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash -> {event} -> delete;
	$c->response->redirect($c->uri_for( 'list',{mid => $c->set_status_msg("event deleted")})); 
	
}

sub event_edit : Chained('event') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
	$c->stash(formtitle => 'Editing '.$c->stash->{event}->title.' - Stage 1 - Event Details');
	return $self->event_form1($c, $c->stash->{event});
    }

sub event_edit2 : Chained('event') PathPart('edit2') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
	return $self->event_form($c, $c->stash->{event});
    }
    
sub event_edit3 : Chained('event') PathPart('edit3') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
#	$c->flash(location_return => {'url','/event/'.$c->stash->{event}->id.'/edit'});
	return $self->event_man_form($c, $c->stash->{event});
}

sub event_edit4 : Chained('event') PathPart('edit4') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
	return $self->event_mer_form($c, $c->stash->{event});
}

sub event_form1 {
	my ( $self, $c, $event ) = @_;

	my $form = ClubTriumph::Form::Event1->new( user => $c->user );
	# Set the template
#	$c->stash(locations => [$c->model('ClubTriumphDB::Location')->all]); 
	$c->stash( template => 'menu/simpleform.tt2', form => $form );
	$form->process( item => $event, params => $c->req->params, user => $c->user, menu_parent => $c->stash->{menu_item}  );
	return unless $form->validated;
	if ($event->menus) {
		$event->menus->single->spider($c)
	}
	$c->response->redirect($c->uri_for( '/menu',$event->menus->first->pid,'event', 'edit2')); 
}
	
sub event_form {
	my ( $self, $c, $event ) = @_;
	if ($c->req->params->{previous} eq 'Previous') {$c->response->redirect($c->uri_for( '/menu',$c->stash->{event}->menus->first->pid,'event', 'edit'))}
	my $form = ClubTriumph::Form::Event->new;
	# Set the template
	$c->stash(locations => [$c->model('ClubTriumphDB::Location')->all]); 
	$c->stash( template => 'event/event_form.tt2', form => $form, formtitle => 'Editing '.$event->title.' - stage 2');
	$form->process( item => $event, params => $c->req->params, user_id => $c->user->id);
	return unless $form->validated;
	if ($event->menus) {
		$event->menus->single->spider($c)
	}
	if ($c->req->params->{previous}) {$c->response->redirect($c->uri_for( '/menu',$c->stash->{event}->menus->first->pid,'event', 'edit'))}
	else {$c->response->redirect($c->uri_for('/menu',$event->menus->first->pid,'event', 'addlocation'))}
 #        {mid => $c->set_status_msg("content created")}));
}
	
sub event_man_form {
	my ( $self, $c, $event ) = @_;

	my $form = ClubTriumph::Form::EventMan->new;
 
	$c->stash( template => 'menu/simpleform.tt2', form => $form,  formtitle => 'Editing '.$event->title.' - Stage 3 - Event management');
	$form->process( item => $event, params => $c->req->params, user_id => $c->user->id );
	return unless $form->validated;
	if ($c->req->params->{extras}) {
		$c->response->redirect($c->uri_for( '/menu',$event->menus->first->pid,'event','edit4'))}
	elsif ($c->req->params->{previous}) {
		$c->response->redirect($c->uri_for( '/menu',$event->menus->first->pid,'event','addlocation'))}
	else {
		$c->response->redirect($c->uri_for( '/menu',$event -> menus->first->pid, 'contentedit')) #,{mid => $c->set_status_msg("Event Updated")}
	}

	}

sub event_mer_form {
	my ( $self, $c, $event ) = @_;

	my $form = ClubTriumph::Form::EventMer->new;
 
	$c->stash( template => 'menu/simpleform.tt2', form => $form,  formtitle => 'Editing '.$event->title.' - Stage 4 - Event Options');
	$form->process( item => $event, params => $c->req->params, user_id => $c->user->id );
	return unless $form->validated;
	if ($c->req->params->{previous}) {
		$c->response->redirect($c->uri_for( '/menu',$event->menus->first->pid,'event','addlocation'))}
	else {
		$c->response->redirect($c->uri_for( '/menu',$event -> menus->single->pid, 'contentedit')); #,{mid => $c->set_status_msg("Event Updated")}
		} # 
	}



sub list : Chained('base') :PathPart('list') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(events => [$c->stash->{event_resultset}->all]);
	$c->stash( template => 'event/list.tt2');
	
}

sub view : Chained('event') :PathPart('view') Args(0) {
	my ( $self, $c ) = @_;
	$c->session(last_visited => {tag => 'event', 'tagid' => $c->stash->{event}->id});
	$c->stash( template => 'event/view.tt2');
	
}

sub location_edit : Chained('event') PathPart('location') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
#	$c->flash(location_return => {'url','/event/'.$c->stash->{event}->id.'/edit'});
	return $self->location_form($c, $c->stash->{event});
    }
   
sub add_location : Chained('event') :PathPart('addlocation') :Args(0) {
	my ($self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
#	$c->flash(location_return => {'url','/event/createevent'});
	my $eventloc = $c->model('ClubTriumphDB::EventLocation')->new_result({});
    return $self->location_form($c, $eventloc);
}   
   
sub location_form {
	my ( $self, $c, $event ) = @_;

	my $form = ClubTriumph::Form::Event_Location->new;
	# Set the template
	$c->stash(locations => [$c->model('ClubTriumphDB::Location')->all]); 
	$c->stash( template => 'event/location_form.tt2', form => $form, $event );
	$form->process( item => $event,
		params => $c->req->params,
		user_id => $c->user->id,
		name => 'locationform',
		event => $c-> stash -> {event});
	return unless $form->validated;
	$c->response->redirect($c->uri_for('/menu', $c -> stash -> {event} -> menus->first->pid,'event','addlocation'));
#	$c->response->redirect($c->uri_for('id', $c-> stash -> {event}-> id, 'addlocation')); # {mid => $c->set_status_msg("Book created")}
 #        {mid => $c->set_status_msg("content created")}));
	}

sub new_location : Chained('event') :PathPart('newlocation') :Args(0) {
	my ($self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
#	$c->flash(location_return => {'url','/event/createevent'});
	my $eventloc = $c->model('ClubTriumphDB::Location')->new_result({country => 'GB'});
    return $self->loc_form($c, $eventloc);
}

sub loc_form {
	my ( $self, $c, $location ) = @_;

	my $form = ClubTriumph::Form::Location->new;
	# Set the template
	$c->stash(locations => [$c->model('ClubTriumphDB::Location')->all]); 
	$c->stash( template => 'location/edit.tt2', form => $form, formtitle => 'Editing '.$c->stash->{event}->title.' Stage 3 - creating new location' );
	$form->process( item => $location, params => $c->req->params,
		user_id => $c->user->id,
		name => 'locationform',
		event => $c-> stash -> {event},
		event_location => $c->model('ClubTriumphDB::EventLocation'));
	return unless $form->validated;
	if ($location->menus) {
		$location->menus->single->spider($c)
	}
	$c->response->redirect($c->uri_for('/menu', $c -> stash -> {event} -> menus->first->pid,'event','addlocation'));
#	$c->response->redirect($c->uri_for('id', $c-> stash -> {event}-> id, 'addlocation')); # {mid => $c->set_status_msg("Book created")}
 #        {mid => $c->set_status_msg("content created")}));
	}

sub location :Chained('event') :PathPart('location') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
	$c->stash(event_locations => $c->model('ClubTriumphDB::EventLocation'));
	$c->stash(event_location => $c->stash->{event_locations}->find($id));
	#   $c->detach('/error_404') if !$c->stash->{object};
	die "Event Location $id not found!" if !$c->stash->{event_location};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for event location id=$id ***");
}

sub location_remove : Chained('location') :PathPart('remove') :Args(0){
		my ( $self, $c) = @_;
		$c -> stash -> {event_location} -> delete;
		$c->response->redirect($c->uri_for('/menu', $c -> stash -> {event} -> menus->first->pid,'event','addlocation'));
#		$c->response->redirect($c->uri_for('id', $c -> stash -> {event} -> id,'addlocation'));
}

sub location_up : Chained('location') :PathPart('up') :Args(0){
	my ( $self, $c) = @_;
	my @locations = $c -> stash -> {event} -> event_locations;
#	my $this = firstidx { $_-> location -> id == $c -> stash -> {event_location} -> location -> id } @locations;
	my $this;
	my $n =0;
	foreach my $location (@locations)
	{if ($c -> stash -> {event_location}-> location -> id == $location -> location -> id) 
		{$this = $n};
		 $n++;
		}
	if ($this > 0)
	{
		my $thisloc = $locations[$this] -> location;
		my $thatloc = $locations[$this -1]-> location;
		$locations[$this] -> update({ location => $thatloc });
		$locations[$this -1] -> update({ location => $thisloc });
	}
	$c->response->redirect($c->uri_for('/menu', $c -> stash -> {event} -> menus->first->pid,'event','addlocation'));
}
	
sub location_down : Chained('location') :PathPart('down') :Args(0){
	my ( $self, $c) = @_;
	my @locations = $c -> stash -> {event} -> event_locations;
#	my $this = firstidx { $_-> location -> id == $c -> stash -> {event_location} -> location -> id } @locations;
	my $this;
	my $n =0;
	foreach my $location (@locations)
	{if ($c -> stash -> {event_location}-> location -> id == $location -> location -> id) 
		{$this = $n};
		 $n++;
		}
	if ($this < @locations)
	{
		my $thisloc = $locations[$this] -> location;
		my $thatloc = $locations[$this +1]-> location;
		$locations[$this] -> update({ location => $thatloc });
		$locations[$this +1] -> update({ location => $thisloc });
	}
	$c->response->redirect($c->uri_for('/menu', $c -> stash -> {event} -> menus->first->pid,'event','addlocation'));
#	$c->response->redirect($c->uri_for('id', $c -> stash -> {event} -> id,'addlocation'));
}





sub view_entries : Chained('event') :PathPart('viewentries') :Args(0) {
	my ($self, $c ) = @_;
	$c->stash(template => 'event/viewentries.tt2');
}

sub view_extras : Chained('event') :PathPart('viewextras') :Args(0) {
	my ($self, $c ) = @_;
	$c->stash(template => 'event/extras.tt2');
}

sub setwebhook : Chained('event') :PathPart('setwebhook') :Args(0) {
	my ($self, $c ) = @_;
	die 'you must be logged in to use this function' unless ($c->user );
	die 'you are not authorised to use this function' unless ($c->user->access_level <= 2 );
	my $response = $c->stash->{event}->set_webhook($c);
	$c->stash({template => 'import/content.tt2'});
	$c->stash({content => $response});
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
