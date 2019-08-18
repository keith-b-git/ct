package ClubTriumph::Controller::group_meeting;
use Moose;
use ClubTriumph::Form::GroupMeeting;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::group_meeting - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::group_meeting in group_meeting.');
}

sub base :Chained('/') :PathPart('group_meeting') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
    
	$c->stash(resultset => $c->model('ClubTriumphDB::GroupMeeting'));
	unless ($id eq 'new')
	{
		$c->stash(groupmeeting => $c->stash->{resultset}->find($id));  
        
		$c->detach('/error_404') if !$c->stash->{groupmeeting};
		die "Group $id not found!" if !$c->stash->{groupmeeting};
	}
	$c->stash(locations => $c->model('ClubTriumphDB::Location')->all);
	# Print a message to the debug log
	$c->log->debug('*** INSIDE LOCATION BASE METHOD ***');
	}

 sub create :  Chained('base') PathPart('create') Args(0)  {
	my ($self, $c ) = @_;

	my $groupmeeting = $c->model('ClubTriumphDB::GroupMeeting')->new_result({});
	return $self->form($c, $groupmeeting);
	}
	
sub edit : Chained('base') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
 
	return $self->form($c, $c->stash->{groupmeeting});
}

sub form  {
	my ( $self, $c, $groupmeeting ) = @_;

	my $form = ClubTriumph::Form::GroupMeeting->new;
	# Set the template
# resultset => $c->model('ClubTriumphDB::Member')
	$c->stash( template => 'groupmeeting/form.tt2', form => $form, $groupmeeting );
	$form->process( item => $groupmeeting, params => $c->req->params);
	return unless $form->validated;
	$c->response->redirect($c->uri_for( $groupmeeting->id, 'edit')); # {mid => $c->set_status_msg("Book created")}
 #        {mid => $c->set_status_msg("content created")}));
	}
	
sub view : Chained('base') PathPart('view') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash ( template => 'groupmeetings/view.tt2' );
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
