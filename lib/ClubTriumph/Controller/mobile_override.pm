package ClubTriumph::Controller::mobile_override;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::mobile_override - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->session->{mobile_override}) { $c->session(mobile_override => 0)}
		else { $c->session(mobile_override => 1)}
	if ($c->request->referer) {
		$c->response->redirect($c->request->referer) }
		else {$c->response->redirect($c->uri_for('/'))
	}
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
