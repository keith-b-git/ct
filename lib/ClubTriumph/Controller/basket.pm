package ClubTriumph::Controller::basket;
use Moose;
use namespace::autoclean;


BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::basket - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::basket in basket.');
}

sub add_to_basket :Chained('/menu/base') :PathPart('add_to_basket') :Args(1) {
	my ($self, $c, $item) = @_;
	my $quantity = $c->req->params->{quantity};
	my $size = $c->req->params->{size};
	if ($size eq 'select') {        $c->stash(error_msg => "You must select a size.")}
	else {
		$c->model('ClubTriumphDB::basket')->update_basket($c, $item, $size, $quantity);
=cut
		if ($c->user) {
			my $purchase = $c->model('ClubTriumphDB::basket')->find_or_create({item => $item, user => $c->user->id, item_size => $size});
		    $quantity += $purchase->quantity;
		    $purchase->update({quantity => $quantity });
		}
		else {
			$c->session(purchases => [{item => $c->model('ClubTriumphDB::Item')->find($item), item_size => $size, quantity => $quantity}]);
			$c->session(basket => 2);
			$c->session(basket_total => 20 );
		}
=cut
	}
#	$c->response->redirect($c->uri_for( '/menu',$c->stash->{menu_item}->pid,'basket', ));
	$c->response->redirect($c->request->referer)
}

sub view :Chained('/menu/base') :PathPart('checkout') :Args(0) {
    my ( $self, $c ) = @_;
	my $user = $c->user;
	foreach my $param (keys %{$c->req->params}) {
		if ($param =~ /^quantity_(\d*)/) {
			my $id = $1;
			$c->model('ClubTriumphDB::basket')->update_quantity($c,$id,$c->req->params->{$param});
		}
		if ($param =~ /^remove_(\d*)/) {
			my $id = $1;
			$c->model('ClubTriumphDB::basket')->remove($c,$id);
		}
	}
	$c->stash(purchases => [$c->model('ClubTriumphDB::basket')->all_items($c)]);				
#	$c->stash(purchases => [$c->user->baskets]);
	$c->stash( template => 'basket/checkout.tt2' );
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
