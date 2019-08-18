package ClubTriumph::Controller::register;
use Moose;
use namespace::autoclean;
use ClubTriumph::Form::Register;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub list : Local
{
	 my ($self, $c) = @_;
	$c->stash(cars => [$c->model('ClubTriumphDB::Register')->all]);
	$c->stash(template => 'register/list.tt2');
}

sub register :Chained('/menu/base') :PathPart('register') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;
	
	# Store the ResultSet in stash so it's available for other methods
	$c->stash(register => $c->stash->{menu_item}->register);  
	
#	 $c->detach('/error_404') if !$c->stash->{object};
	die "Register Entry $id not found!" if !$c->stash->{register};
	 
	# Print a message to the debug log
#	$c->log->debug('*** INSIDE BASE METHOD ***');
}
=cut
sub view  :Chained('base') :PathPart('view') :Args(0){

    my ( $self, $c,  ) = @_;
 #   my $blogs =[$c->model('ClubTriumphDB::Item')->search({registers => $c->stash->{register}})];
#	$c->flash(tags => [{register => $c->stash->{register}}]);
	$c->session(last_visited => {tag => 'register', 'tagid' => $c->stash->{register}->id});
    $c->stash(template => 'register/view.tt2');
}
=cut
sub create :Chained('/menu/base') :PathPart('new_register') :Args(0) {
	my ( $self, $c,  ) = @_;
	my $car = $c->model('ClubTriumphDB::Register')->new_result({memno => $c->user->memno});
    return $self->register_form1($c, $car);
}

sub edit :Chained('register') :PathPart('edit') :Args(0) {
	my ( $self, $c,  ) = @_;
	my $car = $c->stash->{register};
    return $self->register_form1($c, $car);
}

sub register_form1 {
	my ( $self, $c, $register ) = @_;
	my $form = ClubTriumph::Form::Register->new( user => $c->user, inactive => ['owner'] );
	$c->stash( template => 'menu/simpleform.tt2', form => $form, item=> $register );
	$form->process( item => $register, params => $c->req->params, user => $c->user  );
	return unless $form->validated;
	if ($register->is_sold) {
		$c->response->redirect($c->uri_for( '/menu',$c->user->profile->pid,'view'));
	}
	else {
		$c->response->redirect($c->uri_for( '/menu',$register->menus->first->pid,'contentedit')); 
	}
}

sub all_cars :Chained('/menu/base') :Pathpart('all_cars') {
	my ( $self, $c ) = @_;
	$c->stash(template=>'cars/all_cars.tt2', car_count => $c->stash->{menu_item}->all_cars_count($c->user),
	 cars => [$c->stash->{menu_item}->all_cars($c->user,20,$c->request->params->{carspage})]);
}

sub club_cars :Chained('/menu/base') :Pathpart('all_cars') {
	my ( $self, $c ) = @_;
	$c->stash(template=>'cars/all_cars.tt2', car_count => $c->stash->{menu_item}->club_cars_count($c->user),
	cars => [$c->stash->{menu_item}->club_cars($c->user,20,$c->request->params->{carspage})]);
}

sub car_map :Chained('/menu/base') :Pathpart('car_map') {
	my ( $self, $c ) = @_;
	$c->stash(template=>'cars/car_map.tt2', car_count => $c->stash->{menu_item}->club_cars_count($c->user),
	cars => [$c->stash->{menu_item}->club_cars($c->user,2000,1)]);
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
