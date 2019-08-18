    package ClubTriumph::Form::Club_Role;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'club_role' );

	has 'user' => ( is => 'rw' );
    has_field 'club_role';
    has_field 'description' ;
    has_field 'public_email' => (type => 'Email');
    has_field 'club_email' => (type => 'Email');
    has_field 'public_tel';
    has_field 'club_tel';
	has_field 'access_level' => (type => 'Select');
	has_field 'club_officer' => (type => 'Boolean');
    has_field 'submit' => (type => 'Submit', Value => 'Save');

around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	
	my $club_role_root = $self->schema->resultset('Menu')->find({type => 'clubroleroot'});
	return unless ($club_role_root);
	
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({ club_role => $self->item});

	$menu_item->update({
		type => 'club_role',
		parent => $club_role_root->pid,
		club_role => $self->item->id,
		manager => $self->item->id,
		user => $self->user->id,
		heading1 => $self->item->description,
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
	unless ($menu_item->menu_order) {$menu_item->make_last}
	});

};

sub options_access_level {
	my $self = $_[0];
	my @access_options = (
		{value => '2', label => 'Administrator'},
		{value => '4', label => 'Moderator'},
		{value => '8', label => 'Manager'},
#		{value => '16', label => 'Competitions Officer'},
		{value => '16', label => 'Club Officer'},
		{value => '32', label => 'Entrant/Member'},
		{value => '64', label => 'Club Member'}

	);
	return @access_options
}



    __PACKAGE__->meta->make_immutable;
    1;
