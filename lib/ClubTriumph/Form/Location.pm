    package ClubTriumph::Form::Location;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
    use namespace::autoclean;

	has '+item_class' => ( default =>'location' );
	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has 'event' => ( isa => 'ClubTriumph::Schema::Result::Event', is => 'rw' );
	has 'event_location' => ( isa => 'DBIx::Class::ResultSet', is => 'rw' );
	has 'groupmeeting' => ( isa => 'ClubTriumph::Schema::Result::GroupMeeting', is => 'rw' );
    has_field 'name' => (required => 1,
       messages => { required => 'Please provide a name for this location' });
    has_field 'address1';
    has_field 'address2';   
	has_field 'town';
    has_field 'county';  
    has_field 'postcode';
    has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select',  default => 'GB');
    has_field 'search' => (type => 'Button', 
		value => 'Locate on Map',
		element_attr => {onClick =>'locate();'});
    has_field 'longitude' =>(element_attr => {onChange =>'show_coords();'}, required => 1,);
    has_field 'latitude' =>(element_attr => {onChange =>'show_coords();'}, required => 1,);
    has_field 'grid_ref' =>(element_attr => {onChange =>'onConvertGridRef();show_coords();'});
    has_field 'submit' => ( type => 'Submit', value => 'Save Location' );
    has_field 'reset' => ( type => 'Reset',
		value => 'Reset',
		element_attr => {onClick =>'showLocation(loc);'} );
 
sub options_country {
	my $self = $_[0];
	my @options;
	foreach my $country (code2)
	{
		if (country($country,CNT_F_REGULAR))
		{push (@options,{value =>$country, label => scalar(country($country))})}
	}
	my @sortedoptions = sort {$a->{label} cmp $b->{label}} @options;
	unshift (@sortedoptions, {value => 'GB',label => 'United Kingdom'});
	return @sortedoptions;
}
 
 
before 'update_model' => sub {
	my $self = shift;
	$self->item->created_by( $self->user_id );

};

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;
	$self->schema->txn_do( sub {
		$self->$orig(@_);
		if (defined($self -> event) && defined($self -> event_location))
			{
			$self -> event_location -> create({'event' => $self -> event,'location' => $self -> item})
			}
		if (defined($self -> groupmeeting))
			{
			$self -> groupmeeting -> update({'location' => $self->item->id})
			}
	my $parent = $self->schema->resultset('Menu')->find({type => 'locationroot'});
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({parent => $parent->pid, location => $self->item->id});

	$menu_item->update({
		type => 'location',
		parent => $parent->pid,
		user => $self->user_id,
		heading1 => $self->item->name,
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
		});
};

    __PACKAGE__->meta->make_immutable;
    1;
