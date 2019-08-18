package ClubTriumph::Controller::orphans;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::orphans - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::orphans in orphans.');
}


sub menu_items : Local {
	my ( $self, $c ) = @_;
	my $rs = $c->model('ClubTriumphDB::Menu');
	my $response;
	my @results = $rs->search({
		event => undef,
		type => 'event'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		local_group => undef,
		type => 'localgroup'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		register => undef,
		type => 'register'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		car => undef,
		type => 'car'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		club_role => undef,
		type => 'club_role'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		entry => undef,
		type => 'entry'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		location => undef,
		type => 'location'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		championship => undef,
		type => 'championship'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	@results = $rs->search({
		user => undef,
		type => 'profile'
		});

	foreach my $menu_item (@results) {
		$response .= $menu_item->title." ".$menu_item->type." \n";
	}
	
	$c->response->body($response);
	$c->stash({template => 'import/content.tt2'});
	$c->stash({content => $response});
}

sub register : Local {
	my ( $self, $c ) = @_;
	my $rs = $c->model('ClubTriumphDB::Register');
	my $response;
	foreach my $register ($rs->all) {
		unless ($register->menus && $register->menus->first && ($register->menus->first->type eq 'register')) {
			$response .= $register->known_as."- \n";
			if ($register->known_as && $register->id) {
			$c->model('ClubTriumphDB::Menu')->find_or_create({
				register => $register->id,
			});
			$c->model('ClubTriumphDB::Menu')->update({
				type => 'register',
				heading1 => $register->known_as,
				register => $register->id,
				parent => $register->triumph->menus->first->pid,
				view => 64,
				edit => 8,
				anchor => 1,
				add_blog => 64,
				view_blogs => 64,
				add_image => 64,
				view_images => 64,
				add_message => 64,
				view_messages => 64});
			}
		}
	}
		
	$c->response->body($response);
	$c->stash({template => 'import/content.tt2'});
	$c->stash({content => $response});
}


=encoding utf8
		local_group => undef,
		register => undef,
		car => undef,
		club_role => undef,
		entry => undef,
		location  => undef,
		championship  => undef,
		user
=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
