    package ClubTriumph::Form::UserDetails;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
#	has_field 'username' => ( type => 'Text', required => 1 );
	has_field 'first_name' => ( type => 'Text', required => 1  );
	has_field 'last_name' => ( type => 'Text', required => 1 );
	has_field 'email' => ( type => 'Text', required => 1 );
	has_field 'submit' => (type => 'Submit');




    __PACKAGE__->meta->make_immutable;
    1;
