    package ClubTriumph::Form::RegisterUser;
	use HTML::FormHandlerX::Field::reCAPTCHA;
    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
#	with 'HTML::FormHandler::TraitFor::Captcha';
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
	has 'users' => ( isa => 'DBIx::Class::ResultSet', is => 'rw' );
	has 'status' => ( isa => 'Text', is => 'rw');
	has 'address' => (isa => 'Text', is => 'rw');
	has 'validation' => (isa => 'Text', is => 'rw');
    has_field 'first_name' => (required => 1);
    has_field 'last_name' => (required => 1);
    has_field 'username' => (required => 1);
    has_field 'passwordinf' => (type => 'Display', html => 'Please create a password of at least 8 characters', label => '');
    has_field 'password' => (type => 'Password', required => 1, minlength => 6) ;
    has_field 'confirm_password' => (type => 'PasswordConf', required => 1) ;
    has_field 'email' => (required => 1);
     
    has_field 'nocaptcha' => (type=>'noCAPTCHA');
    has_field 'reg_agreement' => (type => 'Display', html => 'You must agree to our <a href = "/static/docs/reg_agreement.pdf">Registration Agreement</a>', label => '');
    has_field 'user_agreement' => (type => 'Checkbox', required => 1 );
    has_field 'submit' => (type => 'Submit', Value => 'Next');


sub validate_password {
	my ( $self, $field ) = @_; 
    unless ( length($field->value) >7 ) {
            $field->add_error( 'password must be at least 8 characters long' );
        }
}

sub validate_username {
	my ( $self, $field ) = @_; 
     if ( $self->users->count({username => $field->value})) {
            $field->add_error( 'username '.$field->value.' is not available' );
        }
}

sub validate_email {
	my ( $self, $field ) = @_; 
	return if $self->users->count({username => $self->item->username, email => $field->value});
     if ( $self->users->count({email => $field->value})) {
            $field->add_error( 'e-mail address '.$field->value.' is already registered' );
        }
}

before 'update_model' => sub {
	my $self = shift;
	$self->item->status('EMAIL');
	my $code = $self->item->generate_confirmation_code($self->address);
	$self->item->validation($code);

};

    __PACKAGE__->meta->make_immutable;
    1;
