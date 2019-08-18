package ClubTriumph::Controller::local_groups;
use Moose;
use ClubTriumph::Form::LocalGroup;
use ClubTriumph::Form::GroupMeeting;
use ClubTriumph::Form::EntryEmail;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::local_groups - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub base :Chained('/menu/base') :PathPart('localgroup') :CaptureArgs(0) {
	my ($self, $c, $id) = @_;
    
	$c->stash(resultset => $c->model('ClubTriumphDB::LocalGroup'));
#	unless ($id eq 'new')
#	{
		$c->stash(localgroup => $c->stash->{resultset}->find($id));  
   	$c->stash(localgroup => $c->stash->{menu_item}->local_group);    
		$c->detach('/error_404') if !$c->stash->{localgroup};
		die "Group $id not found!" if !$c->stash->{localgroup};
#	}
	# Print a message to the debug log
	$c->log->debug('*** INSIDE LOCATION BASE METHOD ***');
	}

 sub create :  Chained('/menu/base') PathPart('create_local_group') Args(0)  {
	my ($self, $c ) = @_;

	my $localgroup = $c->model('ClubTriumphDB::LocalGroup')->new_result({});
	return $self->form($c, $localgroup);
	}
	
sub edit : Chained('base') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
 
	return $self->form($c, $c->stash->{localgroup});
}

sub form  {
	my ( $self, $c, $localgroup ) = @_;

	my $form = ClubTriumph::Form::LocalGroup->new;
	# Set the template
# resultset => $c->model('ClubTriumphDB::Member')

	$c->stash( template => 'menu/simpleform.tt2', form => $form, $localgroup );
	$form->process( item => $localgroup, params => $c->req->params, user => $c->user );
	return unless $form->validated;
	$c->response->redirect($c->uri_for('/menu', $localgroup->menus->first->pid, 'view')); 
 #        {mid => $c->set_status_msg("content created")}));
	}
	
sub view : Chained('base') PathPart('view') Args(0) {
	my ( $self, $c ) = @_;
	$c->session(last_visited => {tag => 'localgroup', 'tagid' => $c->stash->{localgroup}->id});
	$c->stash ( template => 'localgroups/view.tt2' );
	}
	
sub list : Local {
	my ( $self, $c ) = @_;
	$c->stash(resultset => $c->model('ClubTriumphDB::LocalGroup'));
	my @locations;
	my @groups = $c->stash->{resultset}->all;
	foreach my $group (@groups)
	{
		foreach my $meeting ($group->group_meetings)
		{
			push (@locations,$meeting->location);
			my $hashref =$meeting->location;
#			$$hashref{infobubble} = '<STRONG>'.$group-> title.'</STRONG><BR><small>meets at - </small>';
#			$$hashref{infobubble} .= $meeting-> location -> html;
#			$$hashref{infobubble} .= '<small>next meeting- </small>'.$meeting-> nextmeeting;
			$$hashref{infobubble} = $meeting-> html;
		}
	}
	$c->stash(localgroups => [$c->stash->{resultset}->all]);  
	$c->stash(locations => \@locations);
	$c->stash ( template => 'localgroups/list.tt2' );
}

sub meeting :Chained('base') :PathPart('meeting') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
    
	$c->stash(meeting_resultset => $c->model('ClubTriumphDB::GroupMeeting'));
	if ($id eq 'new') {
		$c->stash(groupmeeting => $c->model('ClubTriumphDB::GroupMeeting')->new_result({local_group => $c->stash->{localgroup}->id}))
	}
	else
	{
		$c->stash(groupmeeting => $c->stash->{meeting_resultset}->find($id));  
        
		$c->detach('/error_404') if !$c->stash->{groupmeeting};
		die "Group $id not found!" if !$c->stash->{localgroup};
	}
	# Print a message to the debug log
	$c->log->debug('*** INSIDE LOCATION BASE METHOD ***');
	}


 sub create_meeting :  Chained('base') PathPart('create_meeting') Args(0)  {
	my ($self, $c ) = @_;

	my $groupmeeting = $c->model('ClubTriumphDB::GroupMeeting')->new_result({local_group => $c->stash->{localgroup}->id});
	return $self->meeting_form($c, $groupmeeting);
	}
	
sub edit_meeting : Chained('meeting') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
 
	return $self->meeting_form($c, $c->stash->{groupmeeting});
}

sub meeting_form  {
	my ( $self, $c, $groupmeeting ) = @_;

	my $form = ClubTriumph::Form::GroupMeeting->new;
	# Set the template
# resultset => $c->model('ClubTriumphDB::Member')
	$c->stash(location_resultset => $c->model('ClubTriumphDB::Location'));
	$c->stash(locations => [$c->stash->{location_resultset}->all]);  
	$c->stash( template => 'groupmeeting/location_form.tt2', form => $form, $groupmeeting );
	$form->process( item => $groupmeeting, params => $c->req->params, name => 'locationform');
	return unless $form->validated;
	if ($c->req->params->{new_loc}) {
		$c->response->redirect($c->uri_for( '/menu',$c->stash->{menu_item}->pid, 'localgroup','meeting',$groupmeeting->id,'newlocation')); 
	}
	else {
		$c->response->redirect($c->uri_for( '/menu',$c->stash->{menu_item}->pid, 'view')); 
	}

}

 sub deleteconfirm :  Chained('meeting') PathPart('deleteconfirm') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash( template => 'groupmeeting/deleteconfirm.tt2');

 }

 sub delete :  Chained('meeting') PathPart('delete') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash->{groupmeeting}->delete;
	$c->response->redirect($c->uri_for('/menu/',$c->stash->{menu_item}->pid, 'view')); 
 }


sub select_group :Chained('base') :PathPart('select_group') Args(0) {
	my ($self, $c) = @_;
	if ($c->user->club_member && $c->stash->{menu_item}->local_group) {
		$c->user->memno->update({local_group => $c->stash->{menu_item}->local_group->id, lg_preference => $c->stash->{menu_item}->local_group->id});
		foreach my $member ($c->user->memno->members) {
			$member->update({local_group => $c->stash->{menu_item}->local_group->id});
		}
	}
	$c->response->redirect($c->uri_for( '/menu',$c->stash->{menu_item}->pid, 'view'))
}

sub new_location : Chained('meeting') :PathPart('newlocation') :Args(0) {
	my ($self, $c ) = @_;
#	$c->flash(location_return => {'url','/event/createevent'});
	my $meetingloc = $c->model('ClubTriumphDB::Location')->new_result({country => 'GB'});
    return $self->loc_form($c, $meetingloc);
}

sub loc_form {
	my ( $self, $c, $location ) = @_;

	my $form = ClubTriumph::Form::Location->new;
	# Set the template
	$c->stash(locations => [$c->model('ClubTriumphDB::Location')->all]); 
	$c->stash( template => 'location/edit.tt2', form => $form, formtitle => 'Editing '.$c->stash->{localgroup}->title.' creating new location' );
	$form->process( item => $location, params => $c->req->params,
		name => 'locationform',
		user_id => $c->user->id,
		groupmeeting => $c->stash->{groupmeeting});
#		event => $c-> stash -> {event},
#		event_location => $c->model('ClubTriumphDB::EventLocation'));
	return unless $form->validated;
	$c->response->redirect($c->uri_for('/menu', $c->stash->{localgroup}->menus->first->pid,'localgroup','meeting',$c->stash->{groupmeeting}->id,'edit'));

	}
	
sub members :Chained('base') :Pathpart('members') :Args(0) {
	my ($self,$c) = @_;
	my $memberpage =1;
	if ($c->session->{memberpage} && $c->session->{memberpage}{pid} == $c->stash->{menu_item}->pid) { $memberpage = $c->session->{memberpage}{page} } 
	$c->stash(template => 'member/member_display.tt2',
		members => [$c->stash->{localgroup}->members->current_members->viewable_by($c->user)->by_surname->search({},{rows => 20, page => $memberpage})],
		memberpage => $memberpage,
		membercount => $c->stash->{localgroup}->members->current_members->viewable_by($c->user)->count({}),
		title2 => ' - Members');
}	

sub membermap :Chained('base') :Pathpart('membermap') :Args(0) {
	my ($self,$c) = @_;
	$c->stash(template => 'member/member_map.tt2',members => [$c->stash->{localgroup}->members->current_members->viewable_by($c->user)->by_surname->all]);
}

sub emailmembers :Chained('base') :Pathpart('emailmembers') :Args(0) {
	my ($self,$c) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error('no permission')}
	my $localgroup = $c->stash->{localgroup};
	return $self->admin_email_form($c, $localgroup);
}


sub admin_email_form {
	my ( $self, $c, $localgroup ) = @_;
	my @field_list;
	push (@field_list, {name => 'to_self', type => 'Boolean', 
			label => 'to self ('.$c->user->email.')', 
			wrapper_class => 'form-tags',
		});
	push (@field_list, {name => 'all_members', type => 'Boolean', 
			label => 'to all members of '.$localgroup->title, 
			wrapper_class => 'form-tags',
		});
	my $email_path = $c->path_to('root','src','email','localgroup_email');
	my $template = '';
	if (-e $email_path.'/'.$localgroup->id.'.tt2') {
		open (TEMPLATE, $email_path.'/'.$localgroup->id.'.tt2') || die "can't open ".$email_path.'/'.$localgroup->id.'.tt2' ;
		read(TEMPLATE,$template,10000);
		close TEMPLATE;
	}
	my $form = ClubTriumph::Form::EntryEmail->new(from => $c->user->email, field_list => \@field_list, defaults => { from => $c->user->email, content => $template },
		inactive => ['character_count']);
	$c->stash( template => 'localgroups/admin_email_form.tt2', form => $form);
	$form->process(  params => $c->req->params, );
	return unless $form->validated;
	$self->send_localgroup_emails($c, $localgroup, $form);
}

sub send_localgroup_emails {
	my ($self, $c, $localgroup, $form) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error('no permission')}
	my $content = $form->field('content')->value;
	$content =~ s/\[\%\s*(member\.firstname|member\.fullname|member\.formalname)\s*\%\]|\[\%.*\%\]/[% $1 %]/g ;
	my $email_path = $c->path_to('root','src','email','localgroup_email');
	open (TEMPLATE, '>'.$email_path.'/'.$localgroup->id.'.tt2') || die "can't open ".$email_path.'/'.$localgroup->id.'.tt2' ;
	print TEMPLATE $content;
	close TEMPLATE;
	my @email_success;
	my @email_fail;
	if ($form->field('to_self')->value == 1) {
		my $member = $c->user->memno;
		if ($member->email_member($form->field('subject')->value,'',$form->field('from')->value,'localgroup_email/'.$localgroup->id.'.tt2')) {
			push (@email_success, $member)
		}
		else {
			push (@email_fail, $member)
		}
	}
	if ($form->field('all_members')->value == 1) {
		foreach my $member ($localgroup->members->current_members->search({email_optout => {'!=' => 1}})) {
			if ($member->email_member($form->field('subject')->value,'',$form->field('from')->value,'localgroup_email/'.$localgroup->id.'.tt2')) {
				push (@email_success, $member)
			}
			else {
				push (@email_fail, $member)
			}
		}

	}
	$c->flash(success => \@email_success, fail => \@email_fail);
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
