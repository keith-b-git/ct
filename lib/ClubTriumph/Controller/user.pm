package ClubTriumph::Controller::user;
use ClubTriumph::Form::RegisterUser;
use ClubTriumph::Form::UserOptions;
use ClubTriumph::Form::UserDetails;
use ClubTriumph::Form::ForgotPass;
use ClubTriumph::Form::Password;
use ClubTriumph::Form::UserMember;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
#with 'Catalyst::TraitFor::Controller::reCAPTCHA';

=head1 NAME

ClubTriumph::Controller::user - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub register :Chained('/') :PathPart('register') :Args(0) {
	my ( $self, $c ) = @_;
	my $user = $c->model('ClubtriumphDB::User')->new_result({});
	if ($c->session->{application}) {
		$c->log->debug('application found---------------------');
		my $application = $c->model('ClubTriumphDB::Memform')->find($c->session->{application});
		if ($application) {
			$user->first_name($application->forename);
			$user->last_name($application->surname);
			$user->email($application->email);
		}
	}
	return $self->form($c, $user);
	
}


sub form  {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::RegisterUser->new(ctx=>$c);
	$ENV{REMOTE_ADDR} = $c->req->address;
	$c->stash( template => 'menu/nowrapform.tt2', form => $form);
	$form->process( item => $user, params => $c->req->params, users => $c->model('ClubtriumphDB::User', address => $c->req->address));
	return unless $form->validated;
	&email($c,$user,$c->req->address);
	if ($c->session->{application}) {
		my $application = $c->model->('ClubTriumphDB::Memform')->find({id => $c->session->{application}});
		if ($application) {$application->update({userid=> $user->id})}
	}
	$c->session(registered => $user->id);
	$user->send_email($c,$user->email,'admin@club.triumph.org.uk','New user registered','new_user.tt2'); #email admin
	$c->response->redirect($c->uri_for('/registered', {mid => $c->set_status_msg("user registered")}));
	}


sub registered :Chained('/') :PathPart('registered') :Args(0) {
	my ( $self, $c ) = @_;
	my $user = $c->model('ClubTriumphDB::User')->find({id => $c->session->{registered}});
	$c->stash(template => 'user/registered.tt2', user => $user)
}


sub email {
	my ($c,$user,$address) = @_;

	$c->stash->{email} = {
        to      => $user->email,
        from    => 'admin@club.triumph.org.uk',
        subject => 'Club Triumph Registration Confirmation',
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };

    
	$c->stash(user => $user, mail_template => 'verification.tt2');
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}
	
sub verify :Chained('/') :PathPart('verify') :Args(1) {
	my ($self, $c, $code) =@_;
	my $user = $c->model('ClubtriumphDB::User')->find({validation => $code});
	if ($user) {
		$user->update({validation => '', status => 0});
		
		if ($c->authenticate({ username => $user->username,
	                 password => $user->password  } )) {
			$c->model('ClubtriumphDB::Basket')->login_basket($c);
			$c->session(access_level => undef);
			$c->session(access_level => $c->user->access_level);
			$user->create_profile($c);
	 	}

	}
	else {
		$c->error( 'user verification code not found')
	}
	$c->stash(template => 'user/validate.tt2', user => $user)
}

sub user :Chained('/menu/base') :PathPart('user') :CaptureArgs(0) {
	my ($self,$c) = @_;
#	if (($c->stash->{menu_item}->type eq 'user_profile') && $c->stash->{menu_item}->user) {
#		$c->stash(user => $c->stash->{menu_item}->user);
#	}
#	else {
#		die 'user not found'
#	}
	$c->stash(user => $c->stash->{menu_item}->user);
	$c->error( "User not found!") if !$c->stash->{user};
}

sub reval :Chained('/') :PathPart('reval') :Args(0) {
	my ( $self, $c ) = @_;
	my $user = $c->model('ClubTriumphDB::User')->find({id => $c->flash->{user}->id});
	$c->flash(user => $user);
	return $self->revalform($c, $user);
}


sub revalform  {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::RegisterUser->new(inactive => ['recaptcha', 'username'], ctx => $c);
	$ENV{REMOTE_ADDR} = $c->req->address;
	$c->stash( template => 'menu/nowrapform.tt2', form => $form, , formtitle => 'Welcome to the new Club Triumph website. Before continuing please can you confirm some details');
	$form->process( item => $user, params => $c->req->params, users => $c->model('ClubtriumphDB::User', address => $c->req->address));
	return unless $form->validated;
	&email($c,$user,$c->req->address);
	if ($c->session->{application}) {
		my $application = $c->model('ClubTriumphDB::Memform')->find({id => $c->session->{application}});
		if ($application) {$application->update({userid=> $user->id})}
	}
	$c->session(registered => $user->id);
	$c->response->redirect($c->uri_for('/registered', {mid => $c->set_status_msg("user registered")}));
	}

sub profile :Chained('user') :Pathpart('profile') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'user/profile.tt2')
}

sub edit_options :Chained('user') :PathPart('options') :Args(0) {
	my ($self,$c) = @_;
	unless ($c->user && ($c->stash->{user}->id == $c->user->id)) {$c->error('You do not have permission to do that')}
	return $self->options_form($c, $c->stash->{user});
}

sub options_form {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::UserOptions->new(item => $user);
	$c->stash( template => 'user/optionsform.tt2', form => $form );
	$form->process( item => $user, params => $c->req->params );
	return unless $form->validated;
	$c->persist_user;
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("user options edited")}));
}

sub edit_details :Chained('user') :PathPart('edit_details') :Args(0) {
	my ($self,$c) = @_;
	unless ($c->user && ($c->stash->{user}->id == $c->user->id)) {$c->error('You do not have permission to do that')}
	return $self->details_form($c, $c->stash->{user});
}

sub details_form {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::UserDetails->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form );
	$form->process( item => $user, params => $c->req->params );
	return unless $form->validated;
	$c->persist_user;
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("user details edited")}));
}

sub update_details :Chained('user') :PathPart('update_details') :Args(0) {
	my ($self,$c) = @_;
	unless ($c->user && ($c->stash->{user}->id == $c->user->id)) {$c->error('You do not have permission to do that')}
	$c->stash(formtitle => 'Please update your details before continuing-');
	return $self->details_form($c, $c->stash->{user});
}

sub forgotpass :Chained('/') :PathPart('forgotpass') :Args(0) {
	my ( $self, $c ) = @_;
	return $self->forgotpassform($c);
}

sub forgotpassform {
	my ( $self, $c ) = @_;
	my $form = ClubTriumph::Form::ForgotPass->new;
	$c->stash( template => 'menu/nowrapform.tt2', form => $form );
	$form->process( users => $c->model('ClubTriumphDB::User'), address => $c->req->address, params => $c->req->params );
	return unless $form->validated;
#	die ('#######################'.$form->value->{user_name_or_email}.$form->user->username);
	password_email($c,$form->user);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_start}->pid,'view', {mid => $c->set_status_msg("password reset sent")}));

}

sub password_email {
	my ($c,$user) = @_;
	$c->stash->{email} = {
        to      => $user->email,
        from    => 'admin@club.triumph.org.uk',
        subject => 'Club Triumph Password Reset',
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
#		template => 'forgotpass.tt2',
		content_type => 'multipart/alternative'
    };
	$c->stash(user => $user, mail_template => 'forgotpass.tt2');
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}


sub resetpassword :Chained('/') :PathPart('resetpassword') :Args(1) {
	my ($self, $c, $code) =@_;
	my $user = $c->model('ClubtriumphDB::User')->find({forgotpass => $code});
	unless ($user)  {
		die 'password verification code not found'
	}
	$user->update({status => 0});
	return $self->password_form($c,$user);
}

sub changepassword :Chained('user') :PathPart('change_password') :Args(0) {
	my ($self, $c) =@_;
	unless ($c->user && ($c->stash->{user}->id == $c->user->id)) {$c->error('You do not have permission to do that')}
	return $self->password_form($c,$c->stash->{user});
}


sub password_form {
	my ( $self, $c, $user ) = @_;
	my $form = ClubTriumph::Form::Password->new;
	$c->stash( template => 'menu/nowrapform.tt2', form => $form );
	$form->process( item => $user, params => $c->req->params );
	return unless $form->validated;
	if ($c->authenticate({username => $user->username,
	                 password => $user->password  } )) {
		$c->model('ClubtriumphDB::Basket')->login_basket($c);
		if ($c->user_exists && $c->authen_cookie_value) { # update cookie if present
			my %expires;
			%expires = ( expires => '+1y' );
			$c->set_authen_cookie(
				value => { user_id => $c->user->id, password => $user->password },
				%expires,
				);
			}
	 	}
	$c->response->redirect($c->uri_for('/menu',$user->profile->pid,'user','profile', {mid => $c->set_status_msg("password changed")}));
}

sub private_messages :Chained('user') :PathPart('private_messages') :Args(1) {
	my ($self, $c, $folder) = @_;
	if ($c->req->params->{delete}) {
		$c->model('ClubTriumphDB::Pm')->delete_pms($c,$folder);
	}
	if ($c->req->params->{move}) {
		$c->model('ClubTriumphDB::Pm')->move_pms($c,$folder);
	}
	$c->stash( template => 'item/pms.tt2', folder => $folder );
}


sub memberdetails :Chained('/') :PathPart('memberdetails') :Args() {
	my ($self, $c ) =@_;
	my $user;
	if ($c->user) {$user = $c->user}
	elsif ($c->session->{registered}) {
		my $userid = $c->session->{registered};
		$user = $c->model('ClubTriumphDB::User')->find({id => $userid});
		unless ($user) {$c->error('user not found')}
	}
	else {$c->error('You must register or log in before you can submit membership details')}
	if ($user->member_validations->count({})) {$c->error('Your details have already been submitted and are awaiting validation')}
	my $validation = $c->model('ClubTriumphDB::MemberValidation')->new_result({user => $user->id, country => 'GB', email => $user->email, forename => $user->first_name, surname => $user->last_name});
	return $self->memberdetails_form($c, $validation);
}
	
sub memberdetails_form {
	my ( $self, $c, $validation ) = @_;
	my $form = ClubTriumph::Form::UserMember->new;
	$c->stash( template => 'menu/nowrapform.tt2', form => $form, formtitle => 'If you are a member of Club Triumph and your details are not shown on your profile please enter your details here-' );
	$form->process( item => $validation, params => $c->req->params );
	return unless $form->validated;
	$c->flash(details => $validation->id);
	$c->response->redirect($c->uri_for('/details_response', {mid => $c->set_status_msg("details submitted")}));
}

sub memberdetails_response :Chained('/') :PathPart('details_response') :Args() {
	my ( $self, $c ) = @_;
	my $details = $c->model('ClubTriumphDB::MemberValidation')->find({id => $c->flash->{details}});
	unless ($details) {$c->error('User details not found')}
	my $user = $details->user;
	if ($user) {
		$c->stash(template => 'menu/message.tt2');
		if ($details->check) {
			$user->link_to_member($details->membership_no);
			$c->stash(message => 'You can now access your membership details via your Profile page');
			$c->session(access_level => undef);
			$details->delete;
		}
		else {
			$c->stash(message => 'You details will be confirmed by an administrator and you will receive an e-mail when you can access your membership details');
			my $member = $c->model('ClubTriumphDB::Member')->find({memno => $details->membership_no});
			$c->stash(member => $member);
			$user->send_email($c,$user->email,'admin@club.triumph.org.uk','Member request','member_details.tt2'); #email admin
		}
	}
	else {
		$c->stash(message => 'Error - user  not found');
	}


	
}



=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
