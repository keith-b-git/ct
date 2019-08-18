    package ClubTriumph::Form::Event_Location;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event_location' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
    has_field 'location'  => (type => 'Select', 
    empty_select => '---Select---', 
    label_column => 'name_town', label_column => 'name',
    element_attr => {onChange =>'showSelected();'},  element_class => 'chosen-select');
    has_field 'context';
    has_field 'submit' => (type => 'Submit', value => 'Add Selected Location');
#	has_field 'new_location' => ( type => 'Button', value => 'Add New Location', element_attr => {onClick =>'document.location.href=\'/menu/id/newlocation\';'}, );
 
#=> (type => 'Select', )
  
 #   before 'update_model' => sub {
#	my $self = shift;
#	my $memno = resultset->search({surname => $self->surname})

#		$self->item->created_by( $self->user_id );
#    };




has 'event' => ( isa => 'ClubTriumph::Schema::Result::Event', is => 'rw' );

before 'update_model' => sub {
	my $self = shift;
	$self->item->event( $self->event );
};

sub update_fields {
	my $self = shift;
	my $id = $self->event->id;
#	$self->field('new_location')->element_attr({onClick =>"document.location.href=\'/event/id/$id/newlocation\';"});

}


    __PACKAGE__->meta->make_immutable;
    1;
