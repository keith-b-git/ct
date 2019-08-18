package ClubTriumph::Controller::order;
use Moose;
use ClubTriumph::Form::Order;
use ClubTriumph::Form::Card;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::order - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub view :Chained('/menu/base') :PathPart('checkout2') :Args(0) {
    my ( $self, $c ) = @_;

	$c->stash( template => 'order/checkout2.tt2' );
	}
	
	
	
sub create :  Chained('/') PathPart('new_order') Args(0)  {
	my ($self, $c ) = @_;
	my $user;
	if ($c->user_exists) {$user = $c->user->id}
	my $order;
	if ($c->user && $c->user->memno) {
		$order = $c->model('ClubTriumphDB::Order')->new_result({
			title => $c->user->memno->title,
			forename => $c->user->memno->forename,
			surname => $c->user->memno->surname,
			address1 => $c->user->memno->address1,
			address2 => $c->user->memno->address2,
			address3 => $c->user->memno->address3,
			address4 => $c->user->memno->address4,
			address5 => $c->user->memno->address5,
			postcode => $c->user->memno->postcode,
			country => $c->user->memno->country,
			tel => $c->user->memno->tel,
			email => $c->user->memno->email,
			user => $user,
			ct_status => 'draft'
		});
	}
	elsif ($c->session->{application}) {
		my $application = $c->model('ClubTriumphDB::Memform')->find({id => $c->session->{application}->id});
		$order = $c->model('ClubTriumphDB::Order')->new_result({
			title => $application->title,
			forename => $application->forename,
			surname => $application->surname,
			address1 => $application->address1,
			address2 => $application->address2,
			address3 => $application->address3,
			address4 => $application->address4,
			address5 => $application->address5,
			postcode => $application->postcode,
			country => $application->country,
			tel => $application->tel,
			email => $application->email,
			user => $user,
			ct_status => 'draft'
		})
	}
	else {
		$order = $c->model('ClubTriumphDB::Order')->new_result({
		country => 'GB',
		ct_status => 'draft',
		user => $user,
		});
	}
	$order->total_up($c);
	return $self->form($c, $order);
	}

sub order :Chained('/') :PathPart('order') :CaptureArgs(0) { #order base action
	my ($self,$c) = @_;
	unless ($c->session->{order} && $c->session->{order}->id) {$c->error('order not found')};
	my $order = $c->model('ClubTriumphDB::Order')->find({id => $c->session->{order}->id});
	unless ($order) {$c->error('order not found')};
	$c->stash(title1 => 'Order', order => $order);
}

sub orders :Chained('/') :PathPart('orders') :CaptureArgs(1) { #order base action
	my ($self,$c, $orderid) = @_;

	my $order = $c->model('ClubTriumphDB::Order')->find({id => $orderid});
	unless ($order) {$c->error('order not found')};
	$c->stash(title1 => 'Order', order => $order);
}


sub edit : Chained('order') PathPart('edit_order') Args(0) {
	my ( $self, $c ) = @_;
	my $order = $c->stash->{order};
	$order->total_up($c);
	return $self->form($c, $order);
}

sub confirm_order : Chained('order') PathPart('confirm_order') Args(0) {
	my ( $self, $c ) = @_;
	my $order = $c->stash->{order};
	$c->error('Order total is zero!') unless ($order->total_up($c) > 0);
	my $form = ClubTriumph::Form::Card->new;
	$c->stash(template => 'orders/confirm_order.tt2', order => $order, form =>$form);
	$form->process(params => $c->req->params,  );
	return unless $form->validated;
	$c->flash(
		cardnumber => $c->req->params->{card_number},
		expmonth => $c->req->params->{expiry_month},
		expyear => $c->req->params->{expiry_year},
		cvm => $c->req->params->{cvm}
	);
	$c->response->redirect($c->uri_for('/order', 'place_order', ));
}

sub form  {
	my ( $self, $c, $order ) = @_;

	my $form = ClubTriumph::Form::Order->new;
	if ($c->session->{application}) {
		$c->stash(application => $c->model('ClubTriumphDB::Memform')->find({id => $c->session->{application}->id}))
	}
	$c->stash( template => 'orders/checkout.tt2', form => $form, order => $order );
	$form->process( item => $order, params => $c->req->params,  );
	return unless $form->validated;
	$c->session(order => $order);
	$c->response->redirect($c->uri_for('/order', 'confirm_order', ));
	}

sub place_order : Chained('order') PathPart('place_order') Args(0) {
	my ( $self, $c ) = @_;
	my $order = $c->stash->{order};
	if ($c->user) { #if logged in
		foreach my $item ($c->user->baskets) { #attach items to order 
			$item->update({orderno => $order->id});
		}
	}
	else {
		$order->baskets->delete;
		foreach my $purchase (@{$c->session->{purchases}}) {
			my $basket = $c->model('ClubTriumphDB::Basket')->new_result({
				item => $$purchase{item},
				item_size => $$purchase{item_size},
				quantity => $$purchase{quantity},
				orderno => $order->id
			});
			$basket->insert;
		}

#		$c->session(purchases => undef);
#		$c->session(application => undef);
#		$c->session(order => undef);
	}
	if ($c->session->{application}) {
		$order->memform($c->session->{application}->id)
	}
	if ($c->user && $c->user->memno) { #set draft entries to 'in payment' temporarily
		foreach my $entry ($c->user->memno->draft_entries) {
			$entry->update({old_status => $entry->status});
			$entry->update({status => 'in_payment', orderno => $order->id})
		}
	}
	elsif ($c->user) { #set draft entries to 'in payment' temporarily
		foreach my $entry ($c->user->draft_entries) {
			$entry->update({old_status => $entry->status});
			$entry->update({status => 'in_payment', orderno => $order->id})
		}
	}
	my $total = $order->total;
	if ($total != $order->total_up($c)) {
		$c->response->redirect($c->uri_for('/order', 'confirm_order', ));
	}
	if ($c->flash->{cardnumber} =~ /(\d\d\d\d)$/) {
		$order->update({last_four => $1})
	}
	$order->update({time_date => DateTime->now});
	$c->stash(template => 'orders/place_order.tt2', 
		shared_secret => $c->config->{'Model::Order'}->{'shared_secret'},
		storename => $c->config->{'Model::Order'}->{'storename'},
		interface_url => $c->config->{'Model::Order'}->{'interface_url'});
}

sub current_order:  Chained('/') PathPart('current_order') Args(0)  {
	my ($self,$c) = @_;
	if ($c->session->{order} && $c->session->{order}->id) {
		$c->response->redirect($c->uri_for( '/order','edit_order'))
	}
	else {
		$c->response->redirect($c->uri_for( '/new_order'))
	}
}

sub response_success:  Chained('/') PathPart('response_success') Args(0)  {
	my ($self,$c) = @_;
	my $oid = $c->req->params->{ctorder};
	my $order = $c->model('ClubTriumphDB::Order')->find({id => $oid});
	unless ($order) { $c->error('order not found')}
	if ($order->status eq 'APPROVED') { $c->error('this order has already been processed'); return}
	$order->process_payment($c);
	if ($c->user) { #if logged in
		foreach my $item ($c->user->baskets) { # remove from basket
			$item->update({user => undef});
		}
	}
	foreach my $entry ($order->entries->search({status => 'in_payment'})) {
			$entry->update({status => 'submitted', paid =>  $entry->amount_payable});
			$entry->create_menu_item;
	}
	if ($order->application) {$order->application->update({amount_paid => $order->application->total})}
	$c->session(purchases => undef);
	$c->session(application => undef);
	$c->session(order => undef);
	$order->email_customer($c,'','Club Triumph Order Confirmation', 'orders@club.triumph.org.uk','order_confirmation.tt2');
#	$order->email_treasurer($c,'payments@club.triumph.org.uk');
	$order->email_notifications($c);
	$c->stash(template =>'orders/response_success.tt2');
}

sub response_fail:  Chained('/') PathPart('response_fail') Args(0)  {
	my ($self,$c) = @_;
	my $oid = $c->req->params->{ctorder};
	my $order = $c->model('ClubTriumphDB::Order')->find({id => $oid});
	unless ($order) { $c->error('order not found')}
	if ($order->status eq 'APPROVED') { $c->error('this order has already been processed'); return}
	$order->process_payment($c);
#	$order->baskets->delete;
	foreach my $entry ($order->entries->search({status => 'in_payment'})) {
			$entry->update({status => $entry->old_status})
	}
	$c->flash(fail_reason => $c->req->params->{fail_reason}, fail_reason_details => $c->req->params->{fail_reason_details});
	$c->response->redirect($c->uri_for('/order', 'confirm_order', ));
	$c->stash(template =>'orders/response_fail.tt2');
}
 sub order_view: Chained('orders') PathPart('order_view') Args(0) {
	my ($self,$c) = @_; 
	$c->stash(template => 'orders/order_view.tt2', order => $c->stash->{order})
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
