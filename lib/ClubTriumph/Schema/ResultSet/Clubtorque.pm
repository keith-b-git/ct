package ClubTriumph::Schema::ResultSet::Clubtorque;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub display_order {
	my ($self,$rows,$page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->search({},{order_by => {'-desc' => 'edition'},rows => $rows, page => $page});
}

sub count_all {
	my $self = $_[0];
	return $self->count({});
}

sub order_menu {
	my $self = $_[0];
	my $order = 1;
	foreach my $edition ($self->search({},{order_by =>{-desc => 'edition'}})) {
		if ($edition->menus->count({})) {$edition->menus->first->update({menu_order => $order})}
		$order++;
	}
}
1;
