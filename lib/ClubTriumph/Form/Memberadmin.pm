    package ClubTriumph::Form::Memberadmin;

  use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::MemberRepeatableJs';
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
    use namespace::autoclean;
    use utf8;

	has '+item_class' => ( default =>'member' );
#	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'title' => (size => 8 , required => 1);
	has_field 'forename' => (required => 1);
	has_field 'surname' => (required => 1);
	has_field 'dob' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Birth if aged between 17 & 24');
	
	
	has_field 'members'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Joint Members at same address (£2 extra each)',
		num_when_empty => 0); 
	has_field 'members.memno' => ( type => 'PrimaryKey' );

	has_field 'members.title' => (size => 8 , required => 1,fif_from_value => 'true');
	has_field 'members.forename' => (required => 1, fif_from_value => 'true');
	has_field 'members.surname' => (required => 1 );
	has_field 'members.mobile' ;
	has_field 'members.email' => (type => 'Email', label =>'E-mail address');
    has_field 'members.userid' => ( deflate_method => \&deflate_members_user);
	has_field 'members.rm_element' => ( type => 'RmElement', value => 'Remove Joint Member',);
	has_field 'add_element' => ( type => 'AddElement', label => 'add joint member', repeatable => 'members',  tags => { controls_div => 1 } ,
	value => 'Click to add Joint Member',
	);

	
	
	
	
    has_field 'address1' => (required => 1, size => 40);
    has_field 'address2' => ( size => 40);
    has_field 'address3' => ( size => 40);
    has_field 'address4' => (label => 'Town',size => 40);
    has_field 'address5' => (label => 'County', size => 40);
    has_field 'postcode' => (required => 1);
    has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select');
    has_field 'tel' => (required => 1, label => 'Phone number');
    has_field 'mobile' => ( label => 'Mobile number');
    has_field 'email' => (type => 'Email', required => 0, label =>'E-mail address');
    has_field 'userid' => ( deflate_method => \&deflate_user);
    has_field 'joindate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Date of Joining'); 
    has_field 'expdate' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label => 'Expiry Date'); 
    has_field 'class' => (type => 'Select', options => [{label =>'Ordinary',value => 'ORD'}, {label =>'Associate',value  => 'ASS'},{label =>'Honorary',value =>'HON'}]);
    has_field 'magazine' => (type => 'Checkbox');
    has_field 'dd' => (type => 'Checkbox', label => 'Direct Debit');
    has_field 'secnotes' => (type => 'Checkbox', label => "Secretary's Notes");
    has_field 'area' => (type => 'Select', label_column => 'desc_cost', empty_select => 'Please Select', sort_column => 'id', active_column => 'active');#, required => 1)
	has_field 'comments' => (type => 'TextArea', cols => 100, rows => 10);
    
    
    
    
    has_field 'submit' => (type => 'Submit', Value => 'Save');

sub options_country {
	my $self = $_[0];
	my @options;
	foreach my $country (code2)
	{
		if (country($country,CNT_F_REGULAR))
		{push (@options,{value =>$country, label => scalar(country($country))})}
	}
	return @options;
}


around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;
	$self->schema->txn_do( sub {
		$self->$orig(@_);
#		$self->item->area_from_country;
#		$self->item->young_update;
		unless ($self->item->local_group) {
		$self->item->set_nearest_group }
		$self->item->joint_addresses;
		$self->item->joint_expdate;
		if ($self->item->userid) {
			$self->item->userid->link_to_member($self->item->memno)
		}
		});

};

sub validate_userid {
	my ($self,$field) = @_;
	my $user = $self->item->result_source->schema->resultset('User')->find({username => $field->value});
	unless ($user) {$field->add_error('User '.$field->value.' not found'); return 0}
	if ($user->members->count({}) && ($user->members->single->memno != $self->item->memno)) {
		$field->add_error('Username '.$field->value.' belongs to member '.$user->members->single->fullname);
		return 0
	}
	$field->value($user->id)
}

sub validate_members_userid {
	my ($self,$field) = @_;
	my $user = $self->item->result_source->schema->resultset('User')->find({username => $field->value});
	unless ($user) {$field->add_error('User '.$field->value.' not found'); return 0}
	if ($user->members->count({}) && ($user->members->single->memno != $field->parent->field('memno')->value)) {
		$field->add_error('Username '.$field->value.' belongs to member '.$user->members->single->fullname);
		return 0
	}
	$field->value($user->id)
}


sub deflate_user {
	my ($self,$value) = @_;
	return unless ($self->form->item->userid);
	return $self->form->item->userid->username;
}

sub deflate_members_user {
	my ($self,$value) = @_;
	my $user = $self->form->item->result_source->schema->resultset('User')->find($value);
	if ($user) { 
		return $user->username
	}
}

    __PACKAGE__->meta->make_immutable;
    1;
