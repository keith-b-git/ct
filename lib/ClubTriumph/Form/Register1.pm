    package ClubTriumph::Form::Register;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user' => (  is => 'rw' );
	has 'parent' => (  is => 'rw' );
#	has_field 'title' => (required => 1,
 #      messages => { required => 'Please provide a name for this event' });
 #   has_field 'organiser' => (type => 'Select', , empty_select => 'Please Select', element_attr => {onChange =>'showSelected();'},  element_class => 'chosen-select');
#	has_field 'series' => (type => 'Select', label_column => 'title', empty_select => 'None- standalone event',);
#	has_field 'predecessor' => (type => 'Select', label_column => 'title', empty_select => 'New Event',);

#	has_field 'new_series' => ( type => 'Button', value => 'New Series', element_attr => {onClick =>'location.href=\'/event/createseries\';'}, );
	has_field 'regno' => (
		label => 'Registration Number',
		required => 1,
		messages => { required => 'Please enter the registration number of this vehicle' });
	has_field 'triumph' => (type => 'Select',
		label => 'Model',
		empty_select => 'Please Select',
		element_attr => {onChange =>'showSelected();'},
		element_class => 'chosen-select',
			label_column => 'fullname');
	has_field 'tx' => (type => 'Select', options =>
		[
		{value => 'manual', label => 'Manual'},
		{value => 'man o/d', label => 'Manual with Overdrive'},
		{value => 'auto', label => 'Automatic'},
		],
		label => 'Transmission type');
	has_field 'commno' => ( label => 'Commission Number');
	has_field 'colour' => ( label => 'Colour');
	has_field 'trim' => ( label => 'Interior Trim Colour');
	has_field 'regdate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Registration');
	has_field 'mandate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Manufacture');

    has_field 'submit' => (type => 'Submit', value => 'Submit);




around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({register => $item});
	my $parent = $self->item->triumph->menus->first;

#	foreach my $menitem ($self->item->menus->single->menus) {
#			$menitem->update({parent => $parent})
#		}
	$menu_item->update({
		type => 'register',
		parent => $parent,
		user => $self->item->memno->userid
		});
	unless ($menu_item->view) {
		$menu_item->update({
			view => 256,
			edit => 8,
			anchor => 0,
			add_blog => 64,
			view_blogs => 256,
			add_image => 64,
			view_images => 256,
			add_message => 128,
			view_messages => 256});
	}
	
	});
};




    __PACKAGE__->meta->make_immutable;
    1;
