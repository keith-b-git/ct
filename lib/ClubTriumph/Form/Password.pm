    package ClubTriumph::Form::Password;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
    has_field 'password' => (type => 'Password', required => 1, minlength => 8, label_attr => {title => 'Please type your new password'}) ;
    has_field 'confirm_password' => (type => 'PasswordConf', required => 1, label_attr => {title => 're-type your new password'}) ;

	has_field 'submit' => (type => 'Submit');







    __PACKAGE__->meta->make_immutable;
    1;
