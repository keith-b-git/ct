package ClubTriumph::Controller::Logout;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index
 
Logout logic
 
=cut
 
sub index :Path :Args(0) {
    my ($self, $c) = @_;
    if ($c->user_exists) {
	 	my $loginrecord = $c->model('ClubTriumphDB::LogInOut')->create({ipaddress =>$c->req->address, type =>'logout', user => $c->user->id, outcome => 'success'});
	    # Clear the user's state
	#    $c->session(menu_status => {user => 0, level => 256});
	    $c->session(access_level => 256);
	    $c->session(menu_access_level => undef);
		$c->unset_authen_cookie();
	    $c->logout;
	 }
    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
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
