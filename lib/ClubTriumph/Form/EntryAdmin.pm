    package ClubTriumph::Form::EntryAdmin;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::EntryRepeatableJs';
    use namespace::autoclean;

	has '+item_class' => ( default =>'entry' );
	has 'user' => (  is => 'rw' );
	has 'entry' => (  is => 'rw' );
	has_field 'entry_no' ;
	has_field 'title' => (label =>'Team Title (optional)' ) ;
	has_field 'member' => (type => 'Select', empty_select => 'Please Select', element_attr => {onChange =>'showSelected();'},  element_class => 'chosen-select', label => 'Entrant',
		label_column => 'formalname_memno', sort_column => 'surname', required => 1);
	has_field 'user' => (inflate_default_method => \&inflate_userid, deflate_value_method => \&deflate_user, label => 'Website user name (if known)');
	has_field 'status' => (type => 'Select');
	has_field 'entrants'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, 
		label =>'Team Member');
	has_field 'entrants.id' => ( type => 'PrimaryKey' );
	has_field 'entrants.name' => (fif_from_value => 'true');
	has_field 'entrants.memno' => (type => 'Select', empty_select => 'non -member', element_attr => {onChange =>'update_entrant(this);'},
		element_class => 'chosen-select1', label => 'Membership no',
		label_column => 'formalname_memno', sort_column => 'surname');
	has_field 'entrants.user' => (inflate_default_method => \&inflate_user, deflate_value_method => \&deflate_user, label => 'Website user name (if known)');
	has_field 'entrants.mobile' => (fif_from_value => 'true');
	has_field 'entrants.rm_element' => ( type => 'RmElement', value => 'Remove Team Member',);
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'entrants',  tags => { controls_div => 1 } ,
	value => 'Add another Team Member',
	);
	has_field 'charity_link' => (type => 'URI::HTTP', inflate => 0, size => 40, label =>'Charity web page link (optional)', label_attr => {title => 'If raising money for charity please enter the link here (justgiving etc). Include https:// at the start'} ) ;
	has_field 'amount_payable' => ( type => 'Display' );
	has_field 'paid' => (type => 'Money');
	has_field 'comments' => (type => 'TextArea', rows => 10, cols => 50);
	has_field 'submit' => (type => 'Submit', value => 'Next');


sub html_entrant {
	my ( $self, $field ) = @_;
	if ($self->item->member) {
		return '<div><b>Entrant</b> ' . $self->item->member->fullname .' '.$self->item->member->status.' member, expires '.$self->item->member->expdate. '</div>';
	}
}

sub html_entrants_name {
	my ( $self, $field ) = @_;
	return '<div><b>Team Member</b> ' . $field->value . '</div>';
}



sub html_amount_payable {
	my ( $self, $field ) = @_;
	return '<div><b>Amount Due</b> ' . $self->item->amount_payable . '</div>';
}
sub inflate_user {
	my ($self,$value) = @_; 
#	return unless ($item);
	my $id = $self->parent->field('id')->value;
#	return unless ($id);
	my $entrant = $self->form->item->entrants_rs->find($id);
	if ($entrant && $entrant->user) {return $entrant->user->username}
}

sub inflate_userid {
	my ($self,$value) = @_; 
#	return unless ($item);

	if ($value) {
		return $value->username}
}


sub deflate_user {
	my ($self,$value) = @_; 
	return unless $value;
	my $user = $self->form->schema->resultset('User')->find({username => $value});
	unless ($user)  {$self->add_error('User '.$value.' not found! '); return $value}
	return $user->id;
}

sub inflate_memno {
	my ($self,$value) = @_; #return $value;
	if ($value) {
		return sprintf ("%05d", $value->memno);
	}

}

sub options_status {
	my $self = shift;
	return [
			{label =>'draft', value =>'draft'},
			{label =>'in_payment', value =>'in_payment'},
			{label =>'submitted', value =>'submitted'},
			{label =>'live', value =>'live'},
			{label =>'running', value =>'running'},
			{label =>'withdrawn', value =>'withdrawn'},
			{label =>'reserve', value =>'reserve'},
			{label =>'resubmit', value =>'resubmit'},
			{label =>'complimentary', value =>'complimentary'},
			{label =>'late', value =>'late'},
			{label =>'retired', value =>'retired'},
			{label =>'finished', value =>'finished'},
			]
}

sub validate_entrants {
	my ($self)=$_[0];
#				$self->field('car')->inactive(0);
	my $entrants = $self->field('entrants');
	my $entrant_count;
	foreach my $entrant ($self->field('entrants')->fields) {
		my $member;
		if ($entrant->field('memno')->value) {
#			if ($entrant->field('memno')->value =~/\d?\d\d\d\d/) {

				$member = $self->schema->resultset('Member')->find({memno => $entrant->field('memno')->value});
				unless ($member)  {
					$entrant->field('memno')->add_error('Member '.$entrant->field('memno')->value.' not found!')}
				}
#			else {
#				$entrant->field('memno')->add_error('Invalid membership number!')}
#		}
		if ($entrant->field('user')->value) {
			my $user = $self->schema->resultset('User')->find($entrant->field('user')->value);
			unless ($user)  {$entrant->field('user')->add_error('User '.$entrant->field('user')->value.' not found! ')}
			if ($user && $user->memno && $member) {
				unless ($user->memno->memno == $member->memno) {
					$entrant->field('user')->add_error('User name does not belong to member '.$entrant->field('memno')->value.'!')}
			}
		}
		if ($entrant->field('name')->value || $member) {$entrant_count++}
	}
	unless ($entrant_count >= $self->item->event->min_team) {
		$entrants->add_error('You must have a team of at least '.$self->item->event->min_team. ' to enter this event!')}
	return 1;
}

sub validate_entrants_mobile {
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
		if ($item->member) {
			if ($item->member->userid) {
				$item->user($item->member->userid);
				$item->update;
			}
		}
		foreach my $entrant ($item->entrants) {
			if ($entrant->memno) {
				$entrant->name($entrant->memno->fullname);
				if ($entrant->memno->userid) {
					$entrant->user($entrant->memno->userid)
				}
			$entrant->update;
			}
		}
		
	});
};

    __PACKAGE__->meta->make_immutable;
    1;
