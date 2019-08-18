    package ClubTriumph::Form::EntryFee;

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
	has_field 'car' => ( type => 'Display' );
	has_field 'amount_payable' => ( type => 'Display' );
#	has_field 'paid' ;
	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label',  label => '');
	has_field 'submit' => (type => 'Submit', value => 'Next');


sub html_entrant {
	my ( $self, $field ) = @_;
	return '<div><b>Entrant</b> ' . $self->item->member->fullname . '</div>';
}

sub html_entrants_name {
	my ( $self, $field ) = @_;
	return '<div><b>Team Member</b> ' . $field->value . '</div>';
}

sub html_car {
	my ( $self, $field ) = @_;
	if ($self->item->car) {
		return '<div><b>Car</b> ' . $self->item->car->known_as . '</div>'}
}
sub html_amount_payable {
	my ( $self, $field ) = @_;
	return '<div><b>Amount Due</b> &pound;' . $self->item->amount_payable . '</div>';
}

sub validate_paid {
	my ($self, $field) = @_;
	unless ($field->value == $field->form->item->amount_payable) {$field->add_error('you must pay £'.$field->form->item->amount_payable)}
}

around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	$item->update({'status' => 'submitted'});
	});
};



    __PACKAGE__->meta->make_immutable;
    1;
