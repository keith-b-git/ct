package ClubTriumph::Controller::profile;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::profile - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::profile in profile.');
}

sub base :Chained('/') :PathPart('profile') :CaptureArgs(1) {
	my ($self, $c, $pid) = @_;
	unless ($pid) {$pid = 1}
	$c->stash(menu_item => $c->model('ClubTriumphDB::User')->find({id => $pid}));  

	$c->stash(title1 => ' - '.$c->stash->{menu_item}->fullname.' User Profile');
#	 $c->detach('/error_404') if !$c->stash->{object};
	die "User $pid not found!" if !$c->stash->{menu_item};
	$c->stash(baseurl => ['/profile',$c->stash->{menu_item}->id]);

	if ($c->user) {
		my $yesterday = time - 24*60*60;
		my $popularity = $c->model('ClubTriumphDB::History')->count({'menu' => $pid, 'time' => {'>' => $yesterday}});
		my $history = $c->model('ClubTriumphDB::History')->create({'menu' => $pid, 'user' => $c->user->id, 'popularity' => $popularity}) 
	}
	if (1) { #message viewable for user to go here
		$c->stash(thread_count => $c->stash->{menu_item}->items->items_bytype_viewable_by($c->user,5)->count({}));
		$c->stash(local_thread_count => $c->stash->{thread_count})
	}
	if (1) {
		$c->stash(image_count => $c->stash->{menu_item}->items->items_bytype_viewable_by($c->user,3)->count({}));
	}

	if ($c->request->params->{gallerypage}) {
		$c->session(gallerypage => {page => $c->request->params->{gallerypage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{gallerypage} && ($c->session->{gallerypage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(gallerypage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{threadpage}) {
		$c->session(threadpage => {page => $c->request->params->{threadpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{threadpage} && ($c->session->{threadpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(threadpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{blogpage}) {
		$c->session(blogpage => {page => $c->request->params->{blogpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{blogpage} && ($c->session->{blogpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(blogpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{pmpage}) {
		$c->session(pmpage => {page => $c->request->params->{pmpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{pmpage} && ($c->session->{pmpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(pmpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{carspage}) {
		$c->session(carspage => {page => $c->request->params->{carspage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{carspage} && ($c->session->{carspage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(carspage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{clubtorquepage}) {
		$c->session(clubtorquepage => {page => $c->request->params->{clubtorquepage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{clubtorquepage} && ($c->session->{clubtorquepage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(clubtorquepage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{shoppage}) {
		$c->session(shoppage => {page => $c->request->params->{shoppage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{shoppage} && ($c->session->{shoppage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(shoppage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{memberpage}) {
		$c->session(memberpage => {page => $c->request->params->{memberpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{memberpage} && ($c->session->{memberpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(memberpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{past_eventpage}) {
		$c->session(past_eventpage => {page => $c->request->params->{past_eventpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{past_eventpage} && ($c->session->{past_eventpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(past_eventpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
	if ($c->request->params->{future_eventpage}) {
		$c->session(future_eventpage => {page => $c->request->params->{future_eventpage}, id => $c->stash->{menu_item}->id})
	}
	if ($c->session->{future_eventpage} && ($c->session->{future_eventpage}{id} != $c->stash->{menu_item}->id)) {
		$c->session(future_eventpage => {page => 1, id => $c->stash->{menu_item}->id})
	}
#	$c->stash(latest => [$c->model('ClubTriumphDB::Item')->latest($c->user, 10)]);
	# Print a message to the debug log
	$c->log->debug('*** INSIDE BASE METHOD ***');
}


sub view  :Chained('base') :PathPart('view') :Args(0){

    my ( $self, $c,  ) = @_;
=cut
	unless ($c->stash->{menu_item}->viewable_by($c->user)) {
		unless ($c->user) {
			$c->stash(template => 'menu/login.tt2');
			return
		}
		$c->response->redirect($c->uri_for( '/'))
	}
=cut
#   $c->stash(template => 'menu/view.tt2');
	$c->stash(template => 'menu/details.tt2');
}


sub threads :Chained('base') :PathPart('threads') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/threads.tt2', title2 => ' - Discussion' );
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
