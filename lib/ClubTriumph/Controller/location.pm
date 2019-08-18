package ClubTriumph::Controller::location;
use Moose;
use ClubTriumph::Form::Location;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::location - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::location in location.');
}

=head2 base
    
    Can place common logic to start chained dispatch here
    
=cut
    
sub location :Chained('/menu/base') :PathPart('location') :CaptureArgs(0) {
	my ($self, $c) = @_;
    if ($c->stash->{menu_item}->location) {
		$c->stash(location => $c->stash->{menu_item}->location);    
	}
	$c->load_status_msgs;
	# Print a message to the debug log
	$c->log->debug('*** INSIDE LOCATION BASE METHOD ***');
}
	
sub id :Chained('location') :PathPart('id') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
	$c->stash(location => $c->stash->{resultset}->find($id));  
	$c->detach('/error_404') if !$c->stash->{location};
	die "Location $id not found!" if !$c->stash->{location};
}

 sub create :  Chained('location') PathPart('create') Args(0)  {
	my ($self, $c ) = @_;
	$c->stash(formtitle => 'Creating New Location');
	my $location = $c->model('ClubTriumphDB::Location')->new_result({country => 'GB'});
	return $self->form($c, $location);
	}
	
sub edit : Chained('location') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(formtitle => 'Editing '.$c->stash->{location}->name);
	return $self->form($c, $c->stash->{location});
}

sub form  {
	my ( $self, $c, $location ) = @_;

	my $form = ClubTriumph::Form::Location->new;
	# Set the template

	$c->stash( template => 'location/edit.tt2', form => $form );
	$form->process( name => 'locationform', item => $location, params => $c->req->params, user_id => $c->user->id );
	return unless $form->validated;
	if ($location->menus) {
		$location->menus->single->spider($c)
	}
	{
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("location edited")}));
	}
	}
=cut
sub list :Chained('base') Pathpart('list') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(locations => [$c->stash->{resultset}->all]);
	$c->stash( template => 'location/list.tt2')
}
=cut
sub delete :Chained('id') :PathPart('delete') :Args(0) {
	my ( $self, $c) = @_;
	$c->stash->{location}->delete;
	$c->response->redirect($c->uri_for($self->action_for('list')));
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
