package ClubTriumph::Controller::member;
use ClubTriumph::Form::Member;
use ClubTriumph::Form::Join;
use ClubTriumph::Form::MemberGroup;
use ClubTriumph::Form::Memberadmin;
use ClubTriumph::Form::BlogFeed;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::member - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub member :Chained('/menu/base') :PathPart('member') :CaptureArgs(0) {
	my ($self, $c, $memno) = @_;
#	$c->stash(member => $c->model('ClubTriumphDB::Member')->find({memno => $memno}));
	$c->stash(member => $c->stash->{menu_item}->user->memno);
	die "Member not found!" if !$c->stash->{member};

	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for member ***");
}

sub memno :Chained('/') :PathPart('memno') :CaptureArgs(1) {
	my ($self, $c, $memno) = @_;
	$c->stash(member => $c->model('ClubTriumphDB::Member')->find({memno => $memno}));
#	$c->stash(member => $c->stash->{menu_item}->user->memno);
	die "Member not found!" if !$c->stash->{member};
	die "not permitted!" unless ($c->user && $c->user->memno && ($c->user->memno->memno == $c->stash->{member}->memno));
	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for member ***");
}


sub profile :Chained('member') :Pathpart('profile') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'member/profile.tt2')
}

sub group_edit : Chained('member') PathPart('group_edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->local_group_form($c, $c->stash->{member},['/menu',$c->stash->{menu_item}->pid, 'view',]);
}



sub local_group_form  {
	my ( $self, $c, $member, $return ) = @_;

	my $form = ClubTriumph::Form::MemberGroup->new;
	$c->stash( template => 'groupmeeting/memberform.tt2', form => $form, formtitle => 'Local Group Form',
	 localgroups => [$c->model('ClubTriumphDB::LocalGroup')->all],
	 member => $member  );
	$form->process( item => $member, params => $c->req->params, name => 'groupform');
	return unless $form->validated;
	$c->response->redirect($c->uri_for(@$return, {mid => $c->set_status_msg("Local Group Updated")}));
	}

sub local_group_admin_form  {
	my ( $self, $c, $member ) = @_;

	my $form = ClubTriumph::Form::MemberGroup->new;
	$c->stash( template => 'groupmeeting/memberform.tt2', form => $form, formtitle => 'Local Group Form',
	 localgroups => [$c->model('ClubTriumphDB::LocalGroup')->all],
	 member => $member  );
	$form->process( item => $member, params => $c->req->params, name => 'groupform');
	return unless $form->validated;
	$c->response->redirect($c->uri_for('/application',$c->stash->{application}->id, 'admin', {mid => $c->set_status_msg("Local Group Updated")}));
	}


sub address_edit : Chained('member') PathPart('address_edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->address_form($c, $c->stash->{member});
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("address edited")}));
}



sub address_form  {
	my ( $self, $c, $member ) = @_;

	my $form = ClubTriumph::Form::Member->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $member );
	$form->process( item => $member, params => $c->req->params);
	return unless $form->validated;
	$c->response->redirect($c->uri_for('/menu',$member->profile->pid,'view'))

	}
	
	
sub blog_feed_edit : Chained('member') PathPart('blog_feed_edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->blog_feed_form($c, $c->stash->{member});
	$c->stash->{member}->update_blogs($c);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'view', {mid => $c->set_status_msg("blog feed edited")}));
}



sub blog_feed_form  {
	my ( $self, $c, $member ) = @_;
	my $form = ClubTriumph::Form::BlogFeed->new;
	$c->stash( template => 'menu/simpleform.tt2', form => $form, $member );
	$form->process( item => $member, params => $c->req->params);
	return unless $form->validated;
	$member->update_blogs($c);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid, 'blog', {mid => $c->set_status_msg("blog feed edited")}));
	}

sub avatar : Chained('member') PathPart('avatar') Args(1) {
	my ($self, $c, $avatar) = @_;
	my $image = $c->model('ClubTriumphDB::Item')->find({id => $avatar});
	$c->stash(template => 'member/avatarconfirm.tt2', image => $image);
}

sub avatarchange : Chained('member') PathPart('avatarchange') Args(1) {
	my ($self, $c, $avatar) = @_;
	my $image = $c->model('ClubTriumphDB::Item')->find({id => $avatar});
	$c->stash->{menu_item}->update({top_pic => $image->id});
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'view'));
}

#membership application actions


sub join :Chained('/') :PathPart('join') :Args(0) {
	my ($self,$c) = @_;
	my $member = $c->model('ClubtriumphDB::Memform')->new_result({country => 'GB', status => 'open'});
	my $user;
	if ($c->user) {$user = $c->user}
	if ($c->session->{registered}) {$user = $c->model('ClubTriumphDB::User')->find({id => $c->session->{registered}})}
	if ($user) {
		$member->email($user->email);
		$member->userid($user->id);
		$member->forename($user->first_name);
		$member->surname($user->last_name)
	}
	if ($user && $user->memno) {
		$member->memno($user->memno);
	}
	return $self->join_form($c, $member);
}

sub join_edit :Chained('application') :PathPart('edit') :Args(0) {
	my ($self,$c) = @_;
	return $self->join_form($c, $c->stash->{application});
	
}

sub join_form  {
	my ( $self, $c, $member ) = @_;
	my @inactive = ('status','admin_email');
	if ($c->user_exists) {push (@inactive,'nocaptcha')}
	my $form = ClubTriumph::Form::Join->new(name => 'join', inactive => \@inactive, ctx => $c);
	$c->stash( template => 'menu/nowrapform.tt2', form => $form, formtitle => 'Application for Membership', title1 => '- Application for Membership' );
	$form->process( item => $member, params => $c->req->params, 
	inactive => ['payment_method', 'payment_reference', 'amount_due', 'amount_paid', 'area']);
	return unless $form->validated;
	$c->session(application => $member);
	$c->response->redirect($c->uri_for('/current_order'));
	}

sub application :Chained('/') :PathPart('application') :CaptureArgs(1) { #base class for application forms
	my ($self,$c,$application_no) = @_;
	unless ($c->session->{application} && ($c->session->{application}->id == $application_no)
		|| $c->user && $c->user->memforms->count({id => $application_no}))
		{ die 'error - no permission'} 
	my $application = $c->model('ClubtriumphDB::Memform')->find($application_no);
	$c->stash(application => $application);
}


sub join_stage_2 :Chained('application') :PathPart('stage2') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'member/stage2.tt2')
}

sub join_stage_3 :Chained('application') :PathPart('stage3') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'member/stage3.tt2')
}

#end of membership application actions

#membership renewal actions

sub renew :Chained('memno') :PathPart('renew') :Args(0) {
	my ($self,$c) = @_;
	my $member = $c->model('ClubTriumphDB::Member')->find({memno => $c->stash->{member}->memno});
	my $memform = $member->renewal_form;
	return $self->member_renew_form($c, $memform);
	
}

sub member_renew_form  {
	my ( $self, $c, $member ) = @_;

	my $form = ClubTriumph::Form::Join->new(inactive => ['status','nocaptcha','admin_email'], ctx=>$c);
	$c->stash( template => 'menu/nowrapform.tt2', form => $form, formtitle => 'Membership Details' );
	$form->process( item => $member, params => $c->req->params, 
	inactive => ['payment_method', 'payment_reference', 'amount_due', 'amount_paid', 'area', 'memno','dob']);
	return unless $form->validated;
	$c->session(application => $member);
	$c->response->redirect($c->uri_for('/current_order'));
	}

sub email_renew :Chained('/') :PathPart('renew') :Args(1) {
	my ($self,$c,$code) = @_;
	my $member = $c->model('ClubTriumphDB::Member')->find({renew_code => $code});
	unless ($member) {$c->error('renewal code not found')};
	my $memform = $member->renewal_form;
	return $self->member_renew_form($c, $memform);
	
}

sub email_code :Chained('/') :PathPart('code') :CaptureArgs(1) {
	my ($self,$c,$code) = @_;
	my $member = $c->model('ClubTriumphDB::Member')->find({renew_code => $code});
	unless ($member) {$c->error('email code not found')};
	$c->stash(member => $member);
}

sub unsubscribe :Chained('email_code') :Args(0) {
	my ($self,$c) = @_;
	$c->stash->{member}->update({email_optout => 1});
	
}

sub email_group_edit : Chained('email_code') PathPart('group_edit') Args(0) {
	my ( $self, $c ) = @_;
	return $self->local_group_form($c, $c->stash->{member},['/code',$c->stash->{member}->generate_renew_code,'email_group_edited']);
}

sub email_group_edited : Chained('email_code') :Args(0) {
	my ($self,$c) = @_;
}

__PACKAGE__->meta->make_immutable ;

1;
