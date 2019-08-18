package ClubTriumph::Controller::admin;
use Moose;
use ClubTriumph::Form::UserAdmin;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub auto :Private {
	my ($self,$c) = @_;
	die 'you must be logged in to use this function' unless ($c->user );
	die 'you are not authorised to use this function' unless ($c->user->access_level & 2 );
	
}

sub admin :Chained('/') :PathPart('admin') :CaptureArgs(0) {
	my ($self, $c) = @_;
	$c->stash(title1 => 'Admin');
}

sub history :Chained('admin') :PathPart('history') :CaptureArgs(0) {
	my ($self, $c) = @_;
	$c->stash(template => 'admin/history.tt2');
}

sub user_history :Chained('history') :PathPart('user') :Args(1) {
	my ($self, $c, $usr) = @_;
	my $user = $c->model('ClubTriumphDB::User')->find({ id => $usr});
	$c->stash('history' => [$c->model('ClubTriumphDB::History')->search({user => $usr},{order_by => {-desc => 'id'}, rows => 100})]);
}
	
sub active_users  :Chained('admin') :PathPart('active_users') :Args(0) {
	my ($self, $c) = @_;
	$c->stash(template => 'admin/active_users.tt2', users => [$c->model('ClubTriumphDB::History')->related_resultset('user')->search({},{group_by => 'id'})]);
}

sub recent_users  :Chained('admin') :PathPart('recent_users') :Args(0) {
	my ($self, $c) = @_;
	my $date = DateTime->today;
	my $count = 21;
	my @days;
	my $day = DateTime::Duration->new(days => 1);
	my $dtf = $c->model('ClubTriumphDB::History')->result_source->schema->storage->datetime_parser;
	while ($count) {
		my @history = $c->model('ClubTriumphDB::History')->search({time => {-between => [$dtf->format_datetime($date), $dtf->format_datetime($date->clone->add_duration($day))]}}, {group_by => 'user'});
		push (@days,{date => $date, history => \@history});
		$date = $date->clone->subtract_duration($day);
		$count --;
	}
	$c->stash(template => 'admin/recent_users.tt2', days => \@days);
}

sub statistics :Chained('admin') :PathPart('statistics') :Args(0) {
	my ($self, $c) = @_;
	my $users = $c->model('ClubTriumphDB::User');
	$c->stash(total => $users->count({}), 
		email => $users->count({status => 'EMAIL'}), 
		reval => $users->count({status => 'REVAL'}), 
		active =>$users->count({status => '0'}),
		template => 'admin/statistics.tt2')
}

sub users_by_status :Chained('admin') :PathPart('users_by_status') :Args(1) {
	my ($self, $c, $status) = @_;
	$c->stash(template => 'admin/user_list.tt2', users =>  [$c->model('ClubTriumphDB::User')->search({status => $status})]);
}

sub find_user :Chained('admin') :PathPart('find_user') :Args(1) {
	my ($self, $c, $name) = @_;
	$c->stash(template => 'admin/user_list.tt2', users =>  [$c->model('ClubTriumphDB::User')->search({username => {like =>  '%'.$name.'%'}})]);
}

sub search :Chained('admin') :PathPart('search') :Args(0) {
	my ($self, $c, ) = @_;
	my $name = $c->req->params->{search};
	$c->stash(template => 'admin/user_list.tt2', users =>  [$c->model('ClubTriumphDB::User')->search(
		{-or => [username => {like =>  '%'.$name.'%'},
			first_name => {like =>  '%'.$name.'%'},
			last_name => {like =>  '%'.$name.'%'}],
			})]);
}

sub user :Chained('admin') :PathPart('user') :CaptureArgs(1) {
	my ($self, $c, $userid) = @_;
	$c->stash(title1 => 'user',
	user => $c->model('ClubTriumphDB::User')->find({id => $userid}));
	die 'user not found' if ! $c->stash->{user }
}

sub view :Chained('user') :PathPArt('view') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'admin/user.tt2');
}

sub user_edit :Chained('user') :PathPart('edit') :Args(0) {
	my ($self,$c) = @_;
	return $self->form($c, $c->stash->{user});
}

sub user_delete :Chained('user') :PathPart('delete') :Args(0) {
	my ($self,$c) = @_;
	my $username = $c->stash->{user}->username;
	if ($c->stash->{user}->profile) {$c->stash->{user}->profile->remove}
	$c->stash->{user}->delete;
	$c->response->redirect($c->uri_for('/admin','statistics', {mid => 'user deleted'})); 
}

sub user_delete_content :Chained('user') :PathPart('content_delete') :Args(0) {
	my ($self,$c) = @_;
	my $user = $c->stash->{user};
	foreach my $content ($user->items) {
		$content->remove($c)
	}
	$c->response->redirect($c->uri_for('/admin','user',$user->id, 'view'))
}


sub form  {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::UserAdmin->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form );
	$form->process( item => $user, params => $c->req->params );
	return unless $form->validated;

	$c->response->redirect($c->uri_for('/admin','user',$user->id, 'view'));
	}

sub create_profile :Chained('user') :PathPArt('create_profile') :Args(0) {
	my ($self,$c) = @_;
	$c->stash->{user}->create_profile;
	$c->stash(template => 'admin/user.tt2');
}

sub link_to_member :Chained('user') :PathPart('link_to_member') :Args(0) {
	my ( $self, $c) = @_;
	my $memno = $c->req->params->{memno};
	my $member = $c->model('ClubTriumphDB::Member')->search({memno => $memno})->single;
	if ($member && $member->userid) {
		$c->error("member $memno is already linked to user ".$member->userid->username);
	}
	else {
		$c->stash->{user}->link_to_member($memno)
	}
	$c->response->redirect($c->uri_for('/admin','user',$c->stash->{user}->id, 'view'));
}

sub prune_history  :Chained('admin')  :Args(0) {
	my ( $self, $c) = @_;
	$c->model('ClubTriumphDB::History')->prune;
	$c->model('ClubTriumphDB::Loginout')->prune;
	$c->response->redirect($c->uri_for('/admin','statistics', {mid => $c->set_status_msg('history pruned')})); 
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
