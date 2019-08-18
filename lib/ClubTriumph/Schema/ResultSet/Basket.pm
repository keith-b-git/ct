package ClubTriumph::Schema::ResultSet::Basket;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';


sub update_basket  {
	my ($self, $c, $item, $size, $quantity) = @_;

		if ($c->user) {
			my $purchase = $self->find_or_create({item => $item, user => $c->user->id, item_size => $size});
		    $quantity += $purchase->quantity;
		    $purchase->update({quantity => $quantity });
		}
		else {
			my @newbasket;
			my $found = 0;
			my $id = 0;
			if ($c->session->{purchases}) {
				my @basket = @{$c->session->{purchases}};
				foreach my $purchase (@basket) {
					if (($$purchase{item}->id == $item) && ($$purchase{item_size} eq $size)) {
						push (@newbasket,{item => $$purchase{item}, item_size => $$purchase{item_size}, quantity => $$purchase{quantity} + $quantity, id => $id}) ;
						$id++;
						$found = 1;
					}
					else {
						push (@newbasket,{item => $$purchase{item}, item_size => $$purchase{item_size}, quantity => $$purchase{quantity}, id => $id}); $id++
					}
				}
			}
			unless ($found) {
				push (@newbasket,{item => $c->model('ClubTriumphDB::Item')->find($item), item_size => $size, quantity => $quantity, id => $id}); $id++
			}
				
			$c->session(purchases => [@newbasket]);
		}
	

}

sub basket_total {
	my ($self,$c) = @_;
	my $total = 0;
	if ($c->user) {
		foreach my $purchase ($c->user->baskets) {
			$total += ($purchase->price * $purchase->quantity);
		}
	}
	else {
		foreach my $item (@{$c->session->{purchases}}) { 
#			my %shopitem = [$$item{item}];
			my $price = $$item{item}->price;
			$total += $$item{quantity} * $price
		}
		return $total
	}
	return $total;
}

sub basket_items {
	my ($self,$c) = @_;
	if ($c->user) {
		return $c->user->baskets->get_column('quantity')->sum
	}
	else {
		my $total = 0;
		if ($c->session->{purchases}) {
			foreach my $item (@{$c->session->{purchases}}) { 
				$total += $$item{quantity}
			}
		}
		return $total
	}
}

sub all_items {
	my ($self,$c) = @_;
	if ($c->user) {
		return [$c->user->baskets->all]		
	}
	else {
		return $c->session->{purchases}
	}
}


sub update_quantity {
	my ($self, $c, $item, $quantity) = @_;
	if ($c->user) {
		my $purchase;
		if ($purchase = $c->user->baskets->find({id => $item})) {
			$purchase->update({quantity => $quantity})
		}
	}
	else {
		my @newbasket;
		if ($c->session->{purchases}) {
			my @basket = @{$c->session->{purchases}};
			foreach my $purchase (@basket) {
				if ($$purchase{id} == $item) {
					push (@newbasket,{item => $$purchase{item}, item_size => $$purchase{item_size}, quantity => $quantity, id => $$purchase{id}}) ;
				}
				else {
					push (@newbasket,$purchase)
				}
			}
		$c->session(purchases => [@newbasket]);
		}
	}
}

sub remove {
	my ($self, $c, $item) = @_;
	if ($c->user) {
		my $purchase;
		if ($purchase = $c->user->baskets->find({id => $item})) {
			$purchase->delete
		}
	}
	else {
		my @newbasket;
		if ($c->session->{purchases}) {
			my @basket = @{$c->session->{purchases}};
			foreach my $purchase (@basket) {
				unless ($$purchase{id} == $item) {
					push (@newbasket,$purchase)
				}
			}
		$c->session(purchases => [@newbasket]);
		}
	}
}

sub login_basket {
my ($self, $c) = @_;
if ($c->session->{purchases}) {
	my @basket = @{$c->session->{purchases}};
	foreach my $session_basket (@basket) {
		my $purchase = $self->find_or_create({item => $$session_basket{item}->id, user => $c->user->id, item_size => $$session_basket{item_size}});
		$purchase->update({quantity => $$session_basket{quantity} });
		}
		$c->session(purchases => []);
	}
}



1;
 
