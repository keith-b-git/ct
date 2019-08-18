    package ClubTriumph::Form::Event1;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user' => (  is => 'rw' );
	has 'menu_parent' => (  is => 'rw' );
	has_field 'title' => (required => 1, label_class => 'form_label',
       messages => { required => 'Please provide a name for this event' });
	has_field 'event_type' => (type => 'Select', empty_select => 'Please Select', required => 1, label_class => 'form_label', options => [
		{value => 'non-ct', label => 'event of interest to Triumph enthusiasts'},
		{value => 'ct-rep', label => 'event at which CT will be represented'},
		{value => 'ct-non-man', label => 'CT event - not managed online'},
		{value => 'ct-man', label => 'CT event - managed online'}
	]);
   has_field 'organiser' => (type => 'Select', empty_select => 'Non CT Organiser', element_attr => {onChange =>'showSelected();'},  element_class => 'chosen-select',
		required_when => {event_type => ['ct-non-man', 'ct-man']}, label_class => 'form_label');

#	has_field 'series' => (type => 'Select', label_column => 'title', empty_select => 'None- standalone event',);
#	has_field 'predecessor' => (type => 'Select', label_column => 'title', empty_select => 'New Event', element_class => 'chosen-select',
#				label_attr => {title => 'Select an event to be a template for creating this one'});

#	has_field 'new_series' => ( type => 'Button', value => 'New Series', element_attr => {onClick =>'location.href=\'/event/createseries\';'}, );
    has_field 'submit' => (type => 'Submit', value => 'Next', label_class => 'form_label');

sub options_organiser {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->schema;
	my @options; 
	unless ($self->user->club_officer) {push (@options, {value =>$self->user->memno->memno, label => $self->user->memno->fullname}); return @options}
	my @members = $self->schema->resultset('Member')->current_members; 
	foreach my $member (@members)
	{
		{push (@options,{value =>$member->memno, label => $member->fullname })}
	}
	return @options;
}
=cut
sub options_predecessor {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->schema;
	my @ids = $self->schema->resultset('Event')->past_events_rs->search({id => {'<>' => $current->id}}); 
	my @options; 
	foreach my $id (@ids)
	{
		{push (@options,{value =>$id->id, label => $id->title })}
	}
	return @options;
}
=cut

=cut
sub validate_organiser {
	my ( $self, $field ) = @_;
#	if (!$field->value ){#&& ($self->form->field('event_type')->value eq 'ct-non-man' || $self->form->field('event_type')->value eq 'ct-man')) {
		$field->add_error('You must select an organiser for this event');
		return 0;
#	}
	return 1;
}
=cut



around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;
	my $new = !($self->item->in_storage);
	my $organiser= $self->item->organiser;
	$self->schema->txn_do( sub {
	$self->$orig(@_);
#	if ($new && $self->item->predecessor) {$self->item->update_from_predecessor}
	if ($self->item->organiser) { #set default contact details
		if (($self->item->phone eq undef && $self->item->email eq undef) || !$organiser || $organiser->memno != $self->item->organiser->memno) {
			$self->item->update({email => $self->item->organiser->email, phone => $self->item->organiser->tel})
		}
	}
	my $menu_item = $self->schema->resultset('Menu')->find_or_new({event => $item});
	unless ($menu_item->in_storage) {
		$menu_item->insert;
		my $parent = $self->menu_parent;
		$menu_item->update({
			type => 'event',
			parent => $parent,
			});
		$menu_item->default_permissions;
	}
	if ($self->item->organiser) {
			$menu_item->update({
			user => $self->item->organiser->userid
			})
		}
	else {
		$menu_item->update({
		user => $self->user->id
		})
	}

	if ($item->event_type eq 'ct-man') {
		my $entry_list = $self->schema->resultset('Menu')->find_or_create({parent => $menu_item, type => 'entrylist'});
		$entry_list->update({heading1 => $item->title.' entry list'});
		$entry_list->default_permissions;
	}
	});
};




    __PACKAGE__->meta->make_immutable;
    1;
