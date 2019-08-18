package ClubTriumph::Form::Champpoints;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
	with 'ClubTriumph::Form::ChampRepeatableJs';

has '+item_class' => ( default => 'Champpoint' );
    has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw',
            trigger => sub { shift->set_resultset(@_) } );
            
	has 'members_rs' => ( is => 'rw' );
	has 'event' =>  (  is => 'rw');
	has 'user' => ( is => 'rw' );
    sub set_resultset {
        my ( $self, $resultset ) = @_;
        $self->schema( $resultset->result_source->schema );
    }
 
    sub init_object {
        my $self = shift;
       my $rows = [$self->resultset->all];
        return { champpoints => $rows };
    }
    
    
  	has_field 'champpoints'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Points', inactive => 0); #num_when_empty => 2,
	has_field 'champpoints.memberpts' => (type => 'Select', label => 'Member', element_class => 'chosen-select'); # fif_from_value => 'true', 
	#( type => 'PrimaryKey' );

	has_field 'champpoints.id' => ( type => 'PrimaryKey' );
	has_field 'champpoints.points';
	has_field 'champpoints.eventpts' => ( type => 'Hidden');
	has_field 'champpoints.rm_element' => ( type => 'RmElement', value => 'Remove Member',);
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'champpoints',  tags => { controls_div => 1 } ,
	value => 'Add another Member',
	);
    
    
    
    
    has_field 'submit' => (type => 'Submit', Value => 'Save');
    
    sub update_model {
        my $self = shift;
        my $values = $self->values->{champpoints};
        my @ids;
        foreach my $row (@$values) {
            delete $row->{id} unless defined $row->{id};
            my $newrow = $self->resultset->update_or_create( $row );
            push (@ids, $newrow->id)
        }
        foreach my $dbrow ($self->resultset->all) {
			unless (grep {$_ eq $dbrow->id} @ids) {$dbrow->delete}
		}
    }
    
sub default_champpoints_eventpts {
	my $self = $_[0];
	return $self->form->event->id;
}
   
sub options_champpoints_memberpts {
	my $self = $_[0];
	my @members = $self->members_rs->all;
	my @options;
	foreach my $member (@members) {
		push (@options, {label => $member->fullname, value => $member->memno});
	}
	return @options;
}
    
	
    
=cut


 

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::ChampRepeatableJs';
    use namespace::autoclean;

	has '+item_class' => ( default =>'championship' );
	has 'event' =>  (  is => 'rw');
	has 'user' => ( is => 'rw' );
	has 'members_rs' => ( is => 'rw' );

    has_field 'eventtitle' => ( type => 'Display');

   	has_field 'champpoints'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'Points', inactive => 0); #num_when_empty => 2,
	has_field 'champpoints.memberpts' => (type => 'Select', fif_from_value => 'true', label => 'Member',  element_class => 'chosen-select');
	#( type => 'PrimaryKey' );

	has_field 'champpoints.id' => ( type => 'PrimaryKey' );
	has_field 'champpoints.points';
	has_field 'champpoints.eventpts';# => ( type => 'Hidden');
	has_field 'champpoints.rm_element' => ( type => 'RmElement', value => 'Remove Member',);
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'champpoints',  tags => { controls_div => 1 } ,
	value => 'Add another Member',
	);
    
    
    
    
    has_field 'submit' => (type => 'Submit', Value => 'Save');
    
    
sub html_eventtitle {
	my $self = $_[0];
	return $self->event->title
}

sub default_champpoints_eventpts {
	my $self = $_[0];
	return $self->form->event->id;
}
   
sub options_champpoints_memberpts {
	my $self = $_[0];
	my @members = $self->members_rs->all;
	my @options;
	foreach my $member (@members) {
		push (@options, {label => $member->fullname, value => $member->memno});
	}
	return @options;
}

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


around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

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

sub update_subfields {
	my $self = $_[0];
	foreach my $field ($self->item->field('champpoints')->fields) {
		if ($field->field('eventpts')->value == $self->event->id) {
			$field->is_active;
		}
	}
}


before 'set_active' => sub {
	my $self = shift;
	$self->active(['champpoints.1']) 
};

=cut

    __PACKAGE__->meta->make_immutable;
    1;
