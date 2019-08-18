package ClubTriumph::Controller::club_role;
use Moose;
use ClubTriumph::Form::Club_Role;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::club_role - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub club_role :Chained('/menu/base') :PathPart('club_role') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;
	die 'you are not authorised to use this function' unless ($c->user->access_level & 2);
	$c->stash(club_role => $c->stash->{menu_item}->club_role);
	die "Club Role $id not found!" if !$c->stash->{club_role};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for Club Role ***");
}

 sub create :  Chained('/menu/base') PathPart('new_club_role') Args(0)  {
	my ($self, $c ) = @_;

	my $club_role = $c->model('ClubTriumphDB::ClubRole')->new_result({club_officer => 1, access_level => 16});
	return $self->form($c, $club_role);
	}

sub edit : Chained('club_role') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->form($c, $c->stash->{club_role});
}



sub form  {
	my ( $self, $c, $club_role ) = @_;

	my $form = ClubTriumph::Form::Club_Role->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $club_role );
	$form->process( item => $club_role, params => $c->req->params, user => $c->user );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$club_role->menus->first->pid, 'view', {mid => $c->set_status_msg("club_role edited")}));
	}

sub incumbents : Chained('club_role') PathPart('incumbents') Args(0) {
	my ($self, $c) = @_;
	if ($c->req->params->{member}) {
		$c->model('ClubTriumphDB::MemberClubRole')->find_or_create({member => $c->req->params->{member}, club_role => $c->stash->{club_role}->id})
	}
	
	$c->stash(template => 'club_role/incumbents.tt2', clubmembers => [$c->model('ClubTriumphDB::Member')->all]);
	
}

sub remove_incumbents : Chained('club_role') PathPart('remove') Args(0) {
	my ($self, $c) = @_;
	if ($c->req->params->{member}) {
		my $member = $c->model('ClubTriumphDB::MemberClubRole')->find({member => $c->req->params->{member}, club_role => $c->stash->{club_role}->id});
		if ($member) {$member->delete}
	}
	
	$c->stash(template => 'club_role/incumbents.tt2', clubmembers => [$c->model('ClubTriumphDB::Member')->all]);
	
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
