    package ClubTriumph::Form::Register;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'register' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user' => (  is => 'rw' );
#	has 'parent' => (  is => 'rw' );
	has 'entry' => (  is => 'rw' );
#	has 'privacy' => ( is => 'rw');
#	has_field 'title' => (required => 1,
 #      messages => { required => 'Please provide a name for this event' });
 #   has_field 'organiser' => (type => 'Select', , empty_select => 'Please Select', element_attr => {onChange =>'showSelected();'},  element_class => 'chosen-select');
#	has_field 'series' => (type => 'Select', label_column => 'title', empty_select => 'None- standalone event',);
#	has_field 'predecessor' => (type => 'Select', label_column => 'title', empty_select => 'New Event',);

#	has_field 'new_series' => ( type => 'Button', value => 'New Series', element_attr => {onClick =>'location.href=\'/event/createseries\';'}, );
	has_field 'owner' =>type => ('Select', empty_select => 'non-CT car', accessor => 'memno');
	has_field 'regno' => (
		label => 'Registration Number (required)',
		required => 1,
		inflate_method => \&inflate_regno,
		messages => { required => 'Please enter the registration number of this vehicle' });
	has_field 'triumph' => (type => 'Select',
		label => 'Model (required)',
		empty_select => 'Please Select',
		element_attr => {onChange =>'showSelected();'},
		element_class => 'chosen-select',
		required => 1,
		messages => { required => 'Please select the model of this vehicle' },
		label_column => 'fullname');
	has_field 'tx' => (type => 'Select', options =>
		[
		{value => 'manual', label => 'Manual'},
		{value => 'man o/d', label => 'Manual with Overdrive'},
		{value => 'auto', label => 'Automatic'},
		],
		label => 'Transmission type');
	has_field 'commno' => ( label => 'Commission Number');
	has_field 'engno' => ( label => 'Engine Number');
	has_field 'engsize' => ( label => 'Engine Size (cc)');
	has_field 'colour' => ( label => 'Colour');
	has_field 'trim' => ( label => 'Interior Trim Colour');
	has_field 'regdate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Registration (dd/mm/yy)');
	has_field 'mandate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Manufacture (dd/mm/yy)');
	has_field 'acquired' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date vehicle acquired (dd/mm/yy)');
	has_field 'sold' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date vehicle sold (if applicaple) (dd/mm/yy)');
	has_field 'privacy' => (type => 'Select', required => 1, widget => 'RadioGroup', options => [
		{label => 'All', value => 256},
		{label => 'Registered Users', value => 128},
		{label => 'Club Members', value => 64},
		{label => 'None', value => 2}
		]);
		
    has_field 'submit' => (type => 'Submit', value => 'Next');


sub default_privacy {
	my ($self, $field, $item) = @_;
	return 128 unless defined $item;
	return 128 unless $item->menus;
	return 128 unless $item->menus->first;
	return $item->menus->first->view
}

sub inflate_regno {
	my ($self, $regno) = @_;
	return uc($regno)
}

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
	my $user;
	if ($item->memno && $item->memno->userid) {$user = $item->memno->userid}
		if ($item->sold) {
		if ($item->sold < DateTime->now) {
			$user = undef
		}
	}
	$menu_item->update({
		type => 'register',
		parent => $parent,
		user => $user,
		});
	$menu_item->default_permissions;
	$menu_item->update({
		view => $self->form->field('privacy')->value,
		view_blogs => $self->form->field('privacy')->value,
		view_images => $self->form->field('privacy')->value,
		view_messages => $self->form->field('privacy')->value
		});

	
	});
};


sub options_owner {
	my $self = $_[0];
	my @options;
	foreach my $member ($self->entry->entrants) {
		if ($member->memno) {
			push (@options,{value => $member->memno->memno, label => $member->memno->fullname});
		}
	}
	return @options;
}


    __PACKAGE__->meta->make_immutable;
    1;
