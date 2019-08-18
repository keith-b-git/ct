    package ClubTriumph::Form::UserAdmin;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has_field 'username' => ( type => 'Text', required => 1 );
	has_field 'first_name' => ( type => 'Text'  );
	has_field 'last_name' => ( type => 'Text'  );
	has_field 'email' => ( type => 'Text', required => 1 );
	has_field 'password' => ( type => 'Text', required => 1 );
	has_field 'status' => ( type => 'Select', required => 1, options => 
		[{label => 'active', value => '0'},
		{label => 'e-mail', value => 'EMAIL'},
		{label => 'reval', value => 'REVAL'}]
		);
	has_field 'submit' => (type => 'Submit');




    __PACKAGE__->meta->make_immutable;
    1;
