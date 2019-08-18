    package ClubTriumph::Form::EventMan;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'fee_per_entry' => (type => 'Money');
	has_field 'fee_per_entrant' => (type => 'Money');
 
    has_field 'submit' => (type => 'Submit', Value => 'Next - edit web page content');



    __PACKAGE__->meta->make_immutable;
    1;
