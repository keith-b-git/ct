    package ClubTriumph::Form::EntryCar;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';

    use namespace::autoclean;

	has '+item_class' => ( default =>'entry' );
	has 'user' => (  is => 'rw' );
	has 'entry' => (  is => 'rw' );
	has_field 'entrant' => ( type => 'Display' );
	has_field 'entrants'  => ( type => 'Repeatable',  do_wrapper => 1, tags => { controls_div => 1 });
	has_field 'entrants.id' => ( type => 'PrimaryKey' );
	has_field 'entrants.name' => (type => 'Display');
	has_field 'car' => ( type => 'Select', required => 1 );
	has_field 'new_car' => ( type => 'Button', value => 'Add New Car to Register', element_attr => {onClick =>'document.location.href=document.location.href+\'new\';'}, ); 
	has_field 'other_car' => (label => 'Car make/model', required => 1);
	has_field 'regno' => (label => 'Car registration number', required => 1);
	has_field 'engine_size' => (label => 'Engine size (cc)', required => 1);
	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label',  label => '');
	has_field 'submit' => (type => 'Submit', value => 'Next');


sub html_entrant {
	my ( $self, $field ) = @_;
	if ($self->item->user) {
		return '<div><b>Entrant</b> ' . $self->item->user->fullname . '</div>';
	}
}

sub html_entrants_name {
	my ( $self, $field ) = @_;
	return '<div><b>Team Member</b> ' . $field->value . '</div>';
}

sub options_car {
	my $self = $_[0];
	my @entrants = $self->form->item->entrants;
	my @options; 
	foreach my $entrant (@entrants) {
		my $memno;
		if ($entrant->user) {$memno = $entrant->user->memno}
		if ($entrant->memno) {$memno = $entrant->memno}
		if ($memno && $memno->cars_owned) {
				my @cars = $memno->cars_owned; 
				foreach my $car (@cars) {
					push (@options,{value =>$car->id, label => $car->known_as })
				}
			}
		}

	return @options;
}






    __PACKAGE__->meta->make_immutable;
    1;
