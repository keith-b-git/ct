    package ClubTriumph::Form::Event_Series;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event_series' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
    has_field 'title';
    has_field 'description' => (type => 'TextArea');
	has_field 'managed' => (type => 'Checkbox');
    has_field 'submit' => (type => 'Submit', value => 'Save');
#=> (type => 'Select', )
  
 #   before 'update_model' => sub {
#	my $self = shift;
#	my $memno = resultset->search({surname => $self->surname})

#		$self->item->created_by( $self->user_id );
#    };

    __PACKAGE__->meta->make_immutable;
    1;
