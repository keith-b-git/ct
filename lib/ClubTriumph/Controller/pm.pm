package ClubTriumph::Controller::pm;
use ClubTriumph::Form::Item;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::pm - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::pm in pm.');
}

sub create :Chained('/menu/base') :PathPart('new_pm') :Args(0) {
	my ( $self, $c ) = @_;
	$c->session(pmpage => {page => 1, pid => $c->stash->{menu_item}->pid});
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '7', author => $c->user->id, reply => '128', view => '1'});
	$c->stash(item => $item);
	return $self->form($c, $item);
}

sub pm_to :Chained('/menu/base') :PathPart('pm_to') :Args(1) {
	my ( $self, $c, $recipient ) = @_;
	$c->session(pmpage => {page => 1, pid => $c->stash->{menu_item}->pid});
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '7', author => $c->user->id, reply => '128', view => '1'});
	$c->stash(item => $item);
	return $self->form($c, $item, $recipient);
}

sub form  {
	my ( $self, $c, $item, $recipient ) = @_;
	my $recipname;
	if (my $recip = $c->model('ClubTriumphDB::User')->find({id => $recipient})) {
		$recipname = $recip->username
	}
	
	my $form = ClubTriumph::Form::Item->new(
	item => $item
#		user_id => $c->user->memno->memno, 
		, c => $c,
		user => $c->user,
#		use_fields_for_input_without_param => 1,
		inactive => ['photo','view','reply','menu_items','more_tags'],
		recipients => $recipname
		 );
        $c->stash( template => 'item/itemform.tt2', form => $form, );
        $form->process( item => $item, params => $c->req->params,);
        return unless $form->validated;
		$c->response->redirect($c->uri_for( '/menu',$c->user->profile->pid, 'user','private_messages','inbox', {pmpage => 1, mid => $c->set_status_msg("Item edited")})); 

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
