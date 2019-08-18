package ClubTriumph::Controller::Login;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index
 
Login logic
 

 
sub index :Path :Args(0) {
    my ($self, $c) = @_;
 
    # Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};
 
    # If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        if ($c->authenticate({ username => $username,
                               password => $password  } )) {
            # If successful, then let them use the application
 #    $c->response->redirect($c->uri_for('/'));
	if ($c->request->referer) {
		$c->response->redirect($c->request->referer) }
		else {$c->response->redirect($c->uri_for('/'))}
 #           $c->response->redirect($c->uri_for( '/member',$c->user->id,'profile'));
            return;
        } else {
            # Set an error message
            $c->stash(error_msg => "Bad username or password.");
        }
    } else {
        # Set an error message
        $c->stash(error_msg => "Empty username or password.")
            unless ($c->user_exists);
    }
 
    # If either of above don't work out, send to the login page
    $c->stash(template => 'login.tt2');
}
=cut
sub index :Path :Args(0) {
    my ($self, $c) = @_;
 
    # Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};
 
    # If the username and password values were found in form
    if ($username && $password) {
		my $loginrecord = $c->model('ClubTriumphDB::LogInOut')->create({username => $username, password => $password, ipaddress =>$c->req->address, type =>'login'});
		my $halfhourago = DateTime->now->clone->subtract(minutes => 30);
		my $dtf = $loginrecord->result_source->schema->storage->datetime_parser;
		if ($loginrecord->result_source->resultset->count({ipaddress => $c->req->address, outcome => {'!=' => 'success'}, time => {'>' => $dtf->format_datetime($halfhourago)}}) > 3) {
			$c->stash(error_msg => "Too many failed login attempts - please wait 30 minutes and try again .");
			$loginrecord->update({outcome => 'time out'});
		}
		elsif ( $c->model('ClubtriumphDB::User')->find({username => $username, password => $password, status => 'REVAL'})) {
			$loginrecord->update({outcome => 'revalidate'});
			$c->flash(user => $c->model('ClubtriumphDB::User')->find({username => $username, password => $password, status => 'REVAL'}));
			$c->response->redirect($c->uri_for('/reval'));
			return;
		}
		elsif ( $c->model('ClubtriumphDB::User')->find({username => $username, status => {'!=' => 0}})) {
			$c->stash(error_msg => "Bad username or password.");
			$loginrecord->update({outcome => 'not found'});
		}
		else {
	        # Attempt to log the user in
	        if ($c->authenticate({ username => $username,
	                               password => $password  } )) {
			$loginrecord->update({outcome => 'success', user => $c->user->id});
			$c->model('ClubtriumphDB::Basket')->login_basket($c);
			$c->session(access_level => undef);
			$c->session(menu_access_level => undef);
			$c->session(order => undef);
			$c->session(access_level => $c->user->access_level);
			if ($c->request()->param('remember')) {
				my %expires;
				%expires = ( expires => '+1y' );
				use Unicode::UTF8 qw[encode_utf8];
				$c->set_authen_cookie(
					value => { user_id => $c->user->id, password => encode_utf8($password) },
					%expires,
				);
			}
			if ($c->request->referer) {
				$c->response->redirect($c->request->referer) }
				else {$c->response->redirect($c->uri_for('/'))}
	 #           $c->response->redirect($c->uri_for( '/member',$c->user->id,'profile'));
	            return;
	        } else {
	            # Set an error message
	            $c->stash(error_msg => "Bad username or password.");
	            $loginrecord->update({outcome => 'failure'});
	        }
		}
    }
    else {
        # Set an error message
        $c->stash(error_msg => "Empty username or password.")
            unless ($c->user_exists);
    }
 
    # If either of above don't work out, send to the login page
#	if ($c->request->referer) {
#		$c->response->redirect($c->request->referer) }
#		else
 {$c->response->redirect($c->uri_for('/menu',1,'view',{mid => $c->set_error_msg($c->stash->{error_msg})}))}
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
