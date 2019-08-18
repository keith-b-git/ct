    package ClubTriumph::Form::EntryMer;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';

    use namespace::autoclean;

	has '+item_class' => ( default =>'entry' );
	has 'user' => (  is => 'rw' );
#	has 'entry' => (  is => 'rw' );

	has_field 'entrant' => ( type => 'Display' );
	has_field 'entrants'  => ( type => 'Repeatable',  do_wrapper => 1, tags => { controls_div => 1 });
	has_field 'entrants.id' => ( type => 'PrimaryKey', fif_from_value => 1);
	has_field 'entrants.name' => (type => 'Display');
	has_field 'car' => ( type => 'Display' );


	has_field 'entry_merchandises'  => ( type => 'Repeatable',   do_wrapper => 1, tags => { controls_div => 1 }, label =>'merchandise item' );
	has_field 'entry_merchandises.id' => ( type => 'PrimaryKey' );
	has_field 'entry_merchandises.merchandise' => (type => 'Display');
	has_field 'entry_merchandises.entrant' => (type => 'Display');
	has_field 'entry_merchandises.description' => (type => 'Display');
	has_field 'entry_merchandises.moption' => (type => 'Select', empty_select => 'Select',   required => 1, label => 'Option', widget => 'RadioGroup', 
	do_not_reload => 1
	 );



	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label',  label => '');
	has_field 'submit' => (type => 'Submit', value => 'Next');


sub html_entrant {
	my ( $self, $field ) = @_;
	return '<div><b>Entrant</b> ' . $self->item->user->fullname . '</div>';
}

sub html_entrants_name {
	my ( $self, $field ) = @_;
	return unless $field->parent->field('id')->value;
	return '<div><b>Team Member</b> ' . $self->item->entrants->find({id => $field->parent->field('id')->value})->name . '</div>';
}

sub html_car {
	my ( $self, $field ) = @_;
	if ($self->item->car) {
		return '<div><b>Car</b> ' . $self->item->car->known_as . '</div>'}
}
=cut
sub html_amount_payable {
	my ( $self, $field ) = @_;
	return '<div><b>Amount Due</b> ' . $self->item->amount_payable . '</div>';
}
=cut
sub html_entry_merchandises_merchandise {
		my ( $self, $field ) = @_; 
		return $self->item->entry_merchandises->find({id => $field->parent->field('id')->value})->merchandise->title
}

sub html_entry_merchandises_description {
		my ( $self, $field ) = @_; 
		return '<br>'.$self->item->entry_merchandises->find({id => $field->parent->field('id')->value})->merchandise->description
}

sub html_entry_merchandises_entrant {
		my ( $self, $field ) = @_;
		my $entrant = $self->item->entrants->find({id => $self->item->entry_merchandises->find({id => $field->parent->field('id')->value})->entrant});
		if ($entrant) {return '<br>'.$entrant->name}
}

sub options_entry_merchandises_moption {
	my ($self,$field)= @_;
#	return unless ($field->parent->field('id')->value);
	my ($name,$index) = split(/\./,$field->parent->full_name);
	$index++;
	my @options;
	foreach my $option (split( /\n/,$self->item->entry_merchandises->search({},{rows => 1, page => $index})->single->merchandise->moptions)) {
		$option =~ s/[\000-\037]//g;
		push(@options, {value => $option, label => $option})
	}
	$field->value($field->fif);
	return @options
}
=cut
sub deflate_entry_merchandises_moption {
	my ($self,$field)= @_;
	return 'small';
	}

=cut
=cut
sub validate_entry_merchandises_moption {
	my ($self,$field)= @_;
	$self->form->update_subfields;
#	$field->parent->field('moption')->options([{'medium','medium'}]);
	{$field->add_error($field->parent->field('moption')->value.'You must select an option')};
}
=cut
=cut
sub xxvalidate {
	my ($self, ) = @_;
	$self->field('entry_merchandises.0.option')->add_error($self->field('entry_merchandises.0.id')->value);
	return 1;
	
#	unless ($field->value == $field->form->item->amount_payable) {$field->add_error('you must pay £'.$field->form->item->amount_payable)}
}
=cut
=cut
around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;
#	$self->xxvalidate;
	$self->schema->txn_do( sub {
	$self->$orig(@_);
	$item->update({'status' => 'submitted'});
	});
};

=cut

    __PACKAGE__->meta->make_immutable;
    1;
