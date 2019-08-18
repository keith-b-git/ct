    package ClubTriumph::Form::Championship;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::ChampRepeatableJs';
    use namespace::autoclean;

	has '+item_class' => ( default =>'championship' );
	has 'events_rs' =>  ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user' => ( is => 'rw' );
    has_field 'title';
    has_field 'year' ;
    
   	has_field 'events'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Event' ); #num_when_empty => 2,
	has_field 'events.id' => (type => 'Select', fif_from_value => 'true',
		empty_select => 'Select Event', label => 'Event',
		element_class => 'chosen-select',
		);
	#( type => 'PrimaryKey' );

#	has_field 'events.title' => (type => 'Select', fif_from_value => 'true');

	has_field 'events.rm_element' => ( type => 'RmElement', value => 'Remove Event');
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'events',  tags => { controls_div => 1 } ,
	value => 'Add another Event',
	);
    
    
    
    
    has_field 'submit' => (type => 'Submit', Value => 'Save');

   
sub options_events_id {
	my $self = $_[0];
	my @events = $self->events_rs->all;
	my @options;
	foreach my $event (@events) {
		if ($event->challenge_active($self->item)) {
			push (@options, {label => $event->title, value => $event->id});
		}
	}
	return @options;
}


around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;
	my @oldevents = $self->item->events;
	$self->schema->txn_do( sub {
	$self->$orig(@_);
	
	my $championship_root = $self->schema->resultset('Menu')->find({type => 'championshiproot'});
	return unless ($championship_root);
	
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({ championship => $self->item});

	$menu_item->update({
		type => 'championship',
		parent => $championship_root->pid,
		championship => $self->item->id,
		user => $self->user->id,
		manager => $championship_root->manager,
		heading1 => $self->item->title.' championship '.$self->item->year,
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
	$menu_item->make_last;
	});
	foreach my $event ($self->item->events) {
		foreach my $entrant ($self->item->events->related_resultset('entries')->related_resultset('entrants')->search({},{distinct => 1})) {
			if ($entrant->memno) {
				$self->schema->resultset('Champpoint')->find_or_create({championship_pts => $self->item->id, eventpts => $event->id, memberpts => $entrant->memno->memno});
			}
		}
	}

	my @events = $self->item->events->get_column('id')->all;
	foreach my $oldevent ($self->item->champpoints->related_resultset('eventpt')->search({},{distinct => 1})) {
		unless (grep {$_ eq $oldevent->id} @events) {$self->item->champpoints->search({eventpts => $oldevent->id})->delete}
	}

	
#	foreach my $event (@oldevents) {
#		unless ($event->challenge->search($self->item->id)) {
#			$event->search_related('champpoints',{championship_pts => $self->item->id})->delete;
#		}
#	}

};

sub options_access_level {
	my $self = $_[0];
	my @access_options = (
		{value => '2', label => 'Administrator'},
		{value => '4', label => 'Moderator'},
		{value => '8', label => 'Manager'},
#		{value => '16', label => 'Competitions Officer'},
		{value => '16', label => 'Club Officer'},
		{value => '32', label => 'Entrant/Member'},
		{value => '64', label => 'Club Member'}

	);
	return @access_options
}



    __PACKAGE__->meta->make_immutable;
    1;
