    package ClubTriumph::Form::Mark;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'triumph' );

	has 'user' => ( is => 'rw' );
    has_field 'model' => (type => 'Select', label_column => 'model');
    has_field 'mark' => (type => 'Select', label_column => 'mark');
    has_field 'create_menu_item' => (type => 'Checkbox');
    has_field 'submit' => (type => 'Submit', Value => 'Save');

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	return unless ($self->field('create_menu_item')->value);
	my $model = $self->schema->resultset('Menu')->find({type => 'model', heading1 => $item->model->model});
	return unless ($model);
	
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({ 'parent' => $model->id, heading1 => $item->model->model.$item->mark->mark});

	$menu_item->update({
		type => 'mark',
#		parent => $cars_root->pid,
#		model => $self->item->id,
		user => $self->user->id,
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
	$menu_item->make_last;
	});

};

sub options_access_level {
	my $self = $_[0];
	my @access_options = (
		{value => '2', label => 'Administrator'},
		{value => '4', label => 'Moderator'},
		{value => '8', label => 'Club Officer'},
#		{value => '16', label => 'Competitions Officer'},
		{value => '16', label => 'Asst Event Organiser'},
		{value => '32', label => 'Entrant/Member'},
		{value => '64', label => 'Club Member'}

	);
	return @access_options
}



    __PACKAGE__->meta->make_immutable;
    1;
