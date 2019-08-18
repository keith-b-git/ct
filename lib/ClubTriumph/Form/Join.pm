    package ClubTriumph::Form::Join;

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
	
	
	has_field 'memforms'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>"Joint Members at same address\n (£2 extra each)",
		num_when_empty => 0, label_class => 'form_label'); 
	has_field 'memforms.id' => ( type => 'PrimaryKey' );

	has_field 'memforms.title' => (size => 8 , required => 1,fif_from_value => 'true');
	has_field 'memforms.forename' => (required => 1, fif_from_value => 'true');
	has_field 'memforms.surname' => (required => 1 );
	has_field 'memforms.memno' => (size => 5, label => 'CT Membership number', label_attr => {title => 'If this person has previously been a member of Club Triumph and know their membership number, enter it here, otherwise leave blank'});
	has_field 'memforms.rm_element' => ( type => 'RmElement', value => 'Remove Joint Member',);
	has_field 'add_element' => ( type => 'AddElement', label => 'add joint member', repeatable => 'memforms',  tags => { controls_div => 1 } ,
	value => 'Click to add Joint Member', label_class => 'form_label'
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
    has_field 'admin_email' => (type => 'Email', accessor => 'email', label =>'E-mail address', size => 40, label_class => 'form_label');
    has_field 'area' => (type => 'Select', label_column => 'desc_cost', empty_select => 'Please Select', sort_column => 'id', active_column => 'active', required => 1, label_class => 'form_label');
    has_field 'amount_due' => (type => 'Money', label_class => 'form_label') ;
    has_field 'amount_paid' => (type => 'Money', label_class => 'form_label');
    has_field 'payment_method' => ( label_class => 'form_label');
    has_field 'payment_reference' => ( label_class => 'form_label');
    has_field 'memno' => (size => 5, label => 'CT Membership number', label_attr => {title => 'If you have previously been a member of Club Triumph and know your membership number, enter it here, otherwise leave blank'} , label_class => 'form_label');
	has_field 'userid' => (type =>'Hidden',label => '');
	has_field 'rules' => (type => 'Display', html => 'You must agree to our <a href = "/static/docs/rules.pdf">Club Rules</a>', label => '', label_class => 'form_label');
	has_field 'status' => (type => 'Select', options => [{label =>'Open',value => 'open'}, {label =>'Processed',value  => 'processed'}],label_class => 'form_label');
    has_field 'club_rules' => (type => 'Checkbox', label =>'I agree to abide by the Club Rules', required => 1,label_class => 'form_label',
		messages => {required => 'You must agree to the Club Rules'});
    has_field 'nocaptcha' => (
        type=>'noCAPTCHA',

);    
    
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

sub validate_tel {
	my ($self,$field) = @_;
	use Phone::Number;
	my $num = new Phone::Number($field->value);
	if ($num) {
		$field->value($num->formatted);
	}
	else {
		$field->add_error('Invalid phone number')
	}
}

sub validate_mobile {
	my ($self,$field) = @_;
	use Phone::Number;
	my $num = new Phone::Number($field->value);
	if ($num) {
		$field->value($num->formatted);
	}
	else {
		$field->add_error('Invalid phone number')
	}
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
		$self->item->result_source->resultset->remove_ophans
		});
	$self->item->update({amount_due => $self->item->total})
};



    __PACKAGE__->meta->make_immutable;
    1;
