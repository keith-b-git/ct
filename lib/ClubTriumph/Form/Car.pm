    package ClubTriumph::Form::Car;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'model' );

	has 'user' => ( is => 'rw' );
    has_field 'triumph' => ( type => 'Select',label_column => 'known_as', element_class => 'chosen-select');
    has_field 'body' => ( type => 'Select', label_column => 'body',  element_class => 'chosen-select');  
    has_field 'first' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy"); 
    has_field 'last' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy"); 
    has_field 'home';
    has_field 'export';
    has_field 'bhp';
    has_field 'torque';
    has_field 'top_speed';
    has_field 'zero-sixty';
    has_field 'cc';
    has_field 'front_susp';
    has_field 'rear_susp';
    has_field 'steering';
    has_field 'engtype';
    has_field 'front_brakes';
    has_field 'rear_brakes';
    has_field 'width';
    has_field 'length';
    has_field 'height';
      
    has_field 'submit' => (type => 'Submit', Value => 'Save');

around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	
	my $cars_root = $self->schema->resultset('Menu')->find({type => 'carsroot'});
	return unless ($cars_root);
	my $parent = $self->schema->resultset('Menu')->search({type => 'mark', heading1 => $item->triumph->model->model.$item->triumph->mark->mark})->first;
	unless ($parent) {$parent = $self->schema->resultset('Menu')->search({type => 'model', heading1 => $item->triumph->model->model})->first}
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({ car => $self->item->id});

	$menu_item->update({
		type => 'car',
		parent => $parent,
		car => $self->item->id,
		user => $self->user->id,
		heading1 => $self->item->fullname,
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
