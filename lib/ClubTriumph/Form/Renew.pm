    package ClubTriumph::Form::Renew;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::MemberRepeatableJs';
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
    use namespace::autoclean;
    use utf8;

	has '+item_class' => ( default =>'member' );

	has_field 'title' => (size => 8 , required => 1, label_class => 'form_label');
	has_field 'forename' => (required => 1, label_class => 'form_label');
	has_field 'surname' => (required => 1, label_class => 'form_label');
	has_field 'dob' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Birth if aged between 17 & 24', label_class => 'form_label');
	
	
	has_field 'members'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Joint Members at same address (£2 extra each)',
		num_when_empty => 0); 
	has_field 'members.memno' => ( type => 'PrimaryKey' );

	has_field 'members.title' => (size => 8 , required => 1,fif_from_value => 'true');
	has_field 'members.forename' => (required => 1, fif_from_value => 'true');
	has_field 'members.surname' => (required => 1 );
	has_field 'members.mobile' ;
	has_field 'members.email' => (type => 'Email', label =>'E-mail address');
	has_field 'members.rm_element' => ( type => 'RmElement', value => 'Remove Joint Member',);
	has_field 'add_element' => ( type => 'AddElement', label => 'add joint member', repeatable => 'members',  tags => { controls_div => 1 } ,
	value => 'Click to add Joint Member',
	);

	
	
	
	
    has_field 'address1' => (required => 1, size => 40, label => 'Address line 1', label_class => 'form_label');
    has_field 'address2' => ( size => 40, label => 'Address line 2', label_class => 'form_label');
    has_field 'address3' => ( size => 40, label => 'Address line 3', label_class => 'form_label');
    has_field 'address4' => (label => 'Town',size => 40, label_class => 'form_label');
    has_field 'address5' => (label => 'County', size => 40, label_class => 'form_label');
    has_field 'postcode' => (required => 1, label_class => 'form_label');
    has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select', label_class => 'form_label');
    has_field 'tel' => (required => 1, label => 'Phone number', label_class => 'form_label');
    has_field 'mobile' => ( label => 'Mobile number', label_class => 'form_label');
    has_field 'email' => (type => 'Email', required => 1, label =>'E-mail address', size => 40, label_class => 'form_label');
	has_field 'userid' => (type =>'Hidden',label => '');
    has_field 'club_rules' => (type => 'Checkbox', label =>'I agree to abide by the Club Rules', required => 1,label_class => 'form_label',
		messages => {required => 'You must agree to the Club Rules'});
    
    
    has_field 'submit' => (type => 'Submit', value => 'Next', label_class => 'form_label');

sub options_country {
	my $self = $_[0];
	my @options;
	foreach my $country (code2)
	{
		if (country($country,CNT_F_REGULAR))
		{push (@options,{value =>$country, label => scalar(country($country))})}
	}
	my @sortedoptions = sort {$a->{label} cmp $b->{label}} @options;
	return @sortedoptions;
}

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;
	$self->schema->txn_do( sub {
		$self->$orig(@_);
		$self->item->area_from_country;
		$self->item->young_update;
		unless ($self->item->local_group) {
			$self->item->set_nearest_group }
		});
};



    __PACKAGE__->meta->make_immutable;
    1;
