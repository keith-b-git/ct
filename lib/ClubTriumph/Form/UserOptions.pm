    package ClubTriumph::Form::UserOptions;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has_field 'threads_per_page' => ( type => 'IntRange',
               range_start => 0, range_end => 100 );
	has_field 'replies_per_page' => ( type => 'IntRange',
               range_start => 0, range_end => 100 );
	has_field 'images_per_page' => ( type => 'IntRange',
               range_start => 0, range_end => 100 );
	has_field 'blogs_per_page' => ( type => 'IntRange',
               range_start => 0, range_end => 100 );
	has_field 'location_info' => (type => 'Display', html => 'Allow the website access your location and link it to content that you upload');
	has_field 'location_tag' => (type =>'Select', widget => 'RadioGroup', options => [{label => 'no', value => 0},{label => 'yes', value => 1}],
		label_attr => {title => 'Allow the website to access your location when you create items'});
	has_field 'profile_view'=> (type => 'Select',   widget => 'RadioGroup', 
	label => 'Profile visibility',
		label_attr => {title => 'Allow your profile to be visible to other users'}
		);
	has_field 'contact_view'=> (type => 'Select',   widget => 'RadioGroup', 
	label => 'Privacy',
		label_attr => {title => 'Allow your e-mail address to be visible to other users'}
		);
		has_field 'licence' => (type => 'Select', label => 'Licence- ', widget => 'RadioGroup', tags => {radio_br_after => 1}); #, widget => 'RadioGroup',
    has_field 'sig' => ( type => 'TextArea', rows => 5, cols => 75, id => 'elm1', label => 'Message Signature') ;
    has_field 'email_optout' => (type =>'Select', widget => 'RadioGroup', options => [{label => 'only essential emails about membership', value => 1},{label => 'include news about events, local groups etc.', value => 0}]);
	has_field 'submit' => (type => 'Submit');

sub default_profile_view {
	my ($self) = shift; 
	my $profile = $self->item->profile;
	return $profile->view;
#	return unless ($item);
#	my $id = $self->parent->field('id')->value;
#	return unless ($id);
#	my $entrant = $self->form->item->entrants_rs->find($id);
#	if ($entrant && $entrant->user) {return $entrant->user->username}
}


sub options_profile_view {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->profile->parent) {$view = $self->item->profile->parent->view} 
	return $self->item->profile->access_options($self->item,448, $view)
}

sub options_contact_view {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->profile->parent) {$view = $self->item->profile->parent->view} 
	return $self->item->profile->access_options($self->item,192, $view)
}

sub inflate_perms {
	my ($self,$value) = @_; 
	my @values = (0);
	if ($value) {
		my $testvalue = 512;
		while ($testvalue >= 1) {
			if ($value & $testvalue ) {
				push ( @values, $testvalue);
			} 
		$testvalue = $testvalue >> 1;
		}
	return @values;
	}
	
}

sub deflate_perms {
	my ($self, $values) = @_;
	my $result = 0;
	foreach my $value (@$values) {
		$result += $value
	}
	return $result;
}


sub default_email_optout {
	my ($self) = shift; 
	if ($self->item->memno) {
		return $self->item->memno->email_optout
	}
}

sub options_licence {
	my $self = shift;
	return [
		{label => 'Attribution', value => 'CC BY'},
		{label => 'Attribution ShareAlike', value => 'CC BY-SA'},
		{label => 'Attribution-NoDerivs', value => 'CC BY-ND'},
		{label => 'Attribution-NonCommercial', value => 'CC BY-NC'},
		{label => 'Attribution-NonCommercial-ShareAlike', value => 'CC BY-NC-SA'},
		{label => 'Attribution-NonCommercial-NoDerivs', value => 'CC BY-NC-ND'},
		{label => 'All Rights Reserved', value => 'reserved'},
		{label => 'Public Domain', value => 'public'},
		{label => 'Other', value => 'other'},
		]
}

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;
	$self->schema->txn_do( sub {
		$self->$orig(@_);
		$self->item->profile->update({view => $self->field('profile_view')->value});
		if ($self->item->memno) {
			$self->item->memno->update({email_optout => $self->field('email_optout')->value});
		}
		});
};



    __PACKAGE__->meta->make_immutable;
    1;
