package ClubTriumph::Controller::cars;
use Moose;
use ClubTriumph::Form::Car;
use ClubTriumph::Form::Model;
use ClubTriumph::Form::Mark;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::cars - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub list : Local
{
	 my ($self, $c) = @_;
	$c->stash(cars => [$c->model('ClubTriumphDB::Triumphsall')->all]);
	$c->stash(template => 'cars/list.tt2');
}

sub car :Chained('/menu/base') :PathPart('car') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;

	$c->stash(car => $c->stash->{menu_item}->car);
	die "Car $id not found!" if !$c->stash->{car};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for Triumph Car ***");
}


sub create :  Chained('/menu/base') PathPart('new_car') Args(0)  {
	my ($self, $c ) = @_;
	my $cars_root = $c->model('ClubTriumphDB::Menu')->find({type => 'carsroot'});
	die "Not allowed" unless ($cars_root->editable_by($c->user));
	my $car = $c->model('ClubTriumphDB::Triumphsall')->new_result({ });
	return $self->form($c, $car);
	}

sub edit : Chained('car') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	my $cars_root = $c->model('ClubTriumphDB::Menu')->find({type => 'carsroot'});
	die "Not allowed" unless ($cars_root->editable_by($c->user));
	return $self->form($c, $c->stash->{car});
}



sub form  {
	my ( $self, $c, $car ) = @_;

	my $form = ClubTriumph::Form::Car->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $car );
	$form->process( item => $car, params => $c->req->params, user => $c->user );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("model edited")}));
	}

sub model :Chained('/menu/base') :PathPart('model') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;
	my $cars_root = $c->model('ClubTriumphDB::Menu')->find({type => 'carsroot'});
	die "Not allowed" unless ($cars_root->editable_by($c->user));
	$c->stash(model => $c->stash->{menu_item}->model);
	die "Model $id not found!" if !$c->stash->{model};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for Triumph Model ".$c->stash->{model}->model."***");
}

sub create_model :  Chained('/menu/base') PathPart('new_model') Args(0)  {
	my ($self, $c ) = @_;
	my $cars_root = $c->model('ClubTriumphDB::Menu')->find({type => 'carsroot'});
	die "Not allowed" unless ($cars_root->editable_by($c->user));
	my $model = $c->model('ClubTriumphDB::Model')->new_result({});
	return $self->model_form($c, $model);
	}

sub edit_model : Chained('model') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	my $cars_root = $c->model('ClubTriumphDB::Menu')->find({type => 'carsroot'});
	die "Not allowed" unless ($cars_root->editable_by($c->user));
	return $self->model_form($c, $c->stash->{model});
}



sub model_form  {
	my ( $self, $c, $model ) = @_;

	my $form = ClubTriumph::Form::Model->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form);
	$form->process( item => $model, params => $c->req->params, user => $c->user );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("model edited")}));
	}

sub mark :Chained('model') :PathPart('mark') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;

	$c->stash(mark => $c->stash->{menu_item}->mark);
	die "Mark $id not found!" if !$c->stash->{mark};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for Triumph Mark ".$c->stash->{mark}->mark."***");
}

sub create_mark :  Chained('model') PathPart('new_mark') Args(0)  {
	my ($self, $c ) = @_;

	my $mark = $c->model('ClubTriumphDB::Triumph')->new_result({model => $c->stash->{model}->id});
	return $self->mark_form($c, $mark);
	}

sub edit_mark : Chained('mark') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->mark_form($c, $c->stash->{mark});
}



sub mark_form  {
	my ( $self, $c, $model ) = @_;

	my $form = ClubTriumph::Form::Mark->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form);
	$form->process( item => $model, params => $c->req->params, user => $c->user );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("mark edited")}));
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
