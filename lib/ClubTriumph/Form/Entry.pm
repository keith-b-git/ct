    package ClubTriumph::Form::Entry;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
#	has '+widget_wrapper' => ( default => 'TableInline' );
#	with 'HTML::FormHandler::Render::RepeatableJs';
	with 'ClubTriumph::Form::EntryRepeatableJs';
    use namespace::autoclean;

#	has '+widget_wrapper' => ( default => 'Bootstrap' );
	has '+item_class' => ( default =>'entry' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user' => (  is => 'rw' );
	has 'event' => (  is => 'rw' );
	
	has_field 'entrant' => ( type => 'Display' );
	has_field 'member' => ( type => 'Select', empty_select => 'select',
		element_class => 'chosen-select',
		 label_column => 'fullname', label => 'Entrant',
		 element_attr => {onChange =>'update_entrant();'} );
	has_field 'title' => (label =>'Team Title (optional)' ) ;
#	has_field 'car' => ( type => 'Select' );
	has_field 'entrants'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Team Member' ); #num_when_empty => 2,
	has_field 'entrants.id' => ( type => 'PrimaryKey' );
#	has_field 'entrants.user' => (type => 'Select', empty_select => 'select', element_class => 'chosen-select');
#	has_field 'entrants.user' => (type => 'Hidden', fif_from_value => 'true');
	has_field 'entrants.name' => (fif_from_value => 'true');
	has_field 'entrants.memno' => ( fif_from_value => 'true', label => 'CT membership number (if known)', inflate_default_method => \&inflate_memno,);
	has_field 'entrants.user' => (inflate_default_method => \&inflate_user, deflate_value_method => \&deflate_user, label => 'Website user name (if known)');
	has_field 'entrants.mobile' => (fif_from_value => 'true');

#	has_field 'entrants.username';
#	has_field 'entrants.membno';
	has_field 'entrants.rm_element' => ( type => 'RmElement', value => 'Remove Team Member',);
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'entrants',  tags => { controls_div => 1 } ,
	value => 'Add another Team Member',
	);
	has_field 'charity_link' => (type => 'URI::HTTP', inflate => 0, size => 40, label =>'Charity web page link (optional)', label_attr => {title => 'If you are raising money for charity please enter the link here (justgiving etc). Include https:// at the start'} ) ;
	has_field 'submit' => (type => 'Submit', value => 'Next');


sub html_entrant {
	my ( $self, $field ) = @_;
	return '<div><b>Entrant</b><br>' . $self->item->user->fullname . '</div>';
}

sub options_member {
	my $self= shift;
	return unless $self->form->user;
	my @options;
	my @members = $self->item->result_source->schema->resultset('Member')->current_members;
	foreach my $member (@members) {
		push (@options, {value => $member->memno, label => $member->fullname});
	}
	return @options;
}

sub options_car {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->user;
	my @cars = $self->user->memno->registers; 
	my @options; 
	foreach my $car (@cars)
	{
		{push (@options,{value =>$car->id, label => $car->regno })}
	}
	return @options;
}
=l
sub options_entrants_user {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->user;
	return unless $self->schema;
	my @users = $self->schema->resultset('User')->all; 
	my @options;
	foreach my $user (@users) {
		push (@options,{value =>$user->id, label => $user->username });
	}
	return @options;
}
=cut
sub validate_entrants {
	my ($self)=$_[0];
#				$self->field('car')->inactive(0);
	my $entrants = $self->field('entrants');
	my $entrant_count;
	my $mobile_count;
	foreach my $entrant ($self->field('entrants')->fields) {
		my $member;
		if ($entrant->field('memno')->value) {
			if ($entrant->field('memno')->value =~/\d\d\d\d\d/) {

				$member = $self->schema->resultset('Member')->find({memno => $entrant->field('memno')->value});
				unless ($member)  {
					$entrant->field('memno')->add_error('Member '.$entrant->field('memno')->value.' not found!')}
				}
			else {
				$entrant->field('memno')->add_error('Invalid membership number!')}
		}
		if ($entrant->field('user')->value) {
			my $user = $self->schema->resultset('User')->find($entrant->field('user')->value);
			unless ($user)  {$entrant->field('user')->add_error('User '.$entrant->field('user')->value.' not found! ')}
			if ($user && $member && $user->memno) {
				unless ($user->memno->memno == $member->memno) {
					$entrant->field('user')->add_error('User name does not belong to member '.$entrant->field('memno')->value.'!')}
			}
		}
		if ($entrant->field('name')->value || $member) {$entrant_count++}
		if ($entrant->field('mobile')->value ) {$mobile_count++}
	}
	unless ($entrant_count >= $self->item->event->min_team) {
		$entrants->add_error('You must have a team of at least '.$self->item->event->min_team. ' to enter this event!')}
	if ($self->item->event->car && $mobile_count < 1) {
		$entrants->add_error('You must provide at least one mobile telephone number to enter this event!')
	}
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

=c
sub default_entrants_username {
	my ($self,$field,$item) = @_;
	return unless ($item);
	my $id = $field->parent->field('id')->value;
	return unless ($id);
	my $entrant = $item->entrants_rs->find($id);
	if ($entrant && $entrant->user) {return $entrant->user->username}
}
=cut
sub inflate_user {
	my ($self,$value) = @_; 
#	return unless ($item);
	my $id = $self->parent->field('id')->value;
#	return unless ($id);
	my $entrant = $self->form->item->entrants_rs->find($id);
	if ($entrant && $entrant->user) {return $entrant->user->username}
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


=c
before 'update_model' => sub {
	my $self = shift;
	foreach my $entrant ($self->field('entrants')->fields) {
		if ($entrant->field('user')->value && !($entrant->field('memno')->value) && $self->schema->resultset('User')->find($entrant->field('user')->value)) {
			$entrant->field('memno')->value($self->schema->resultset('User')->find($entrant->field('user')->value))
		}
	}
};

=cut

around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	$item->update_merchandise;
	my $entry_list = $self->schema->resultset('Menu')->find({parent => $item->event->menus->single->id, type => 'entrylist'});
	return unless ($entry_list);
=cut
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({parent => $entry_list, entry => $self->item});

	$menu_item->update({
		type => 'entry',
		user => $self->user->id,
		heading1 => $self->item->title,
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
=cut
	});

};

    __PACKAGE__->meta->make_immutable;
    1;
