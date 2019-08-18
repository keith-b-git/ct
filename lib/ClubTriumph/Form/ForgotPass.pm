    package ClubTriumph::Form::ForgotPass;
    use HTML::FormHandler::Moose;
	extends 'HTML::FormHandler';
#	with 'HTML::FormHandler::Render::Table';
#	with 'HTML::FormHandler::TraitFor::Captcha';
    use namespace::autoclean;

#	has '+item_class' => ( default =>'user' );
	has 'users' => ( isa => 'DBIx::Class::ResultSet', is => 'rw' );
	has 'user' => (  is => 'rw' );
	has 'address' => ( is => 'rw');


    has_field 'user_name_or_email' => (required => 1, label_attr => {title => 'Please enter your user name or the e-mail address that you used to register your account'} );

    
    has_field 'submit' => (type => 'Submit', value => 'Continue');


sub validate_user_name_or_email {
	my ( $self, $field ) = @_; 
	my $user = $self->users->find({username => $field->value});
	unless ($user) {$user = $self->users->find({email => $field->value})} 
	if ($user) {
		$self->user($user);
		my $code = $user->generate_confirmation_code($self->address);
		$user->update({forgotpass => $code});
	}
    else {
		$field->add_error( $field->value.' not found' );
	}

}




    __PACKAGE__->meta->make_immutable;
    1;
