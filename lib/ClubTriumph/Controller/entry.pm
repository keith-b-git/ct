package ClubTriumph::Controller::entry;
use Moose;
use ClubTriumph::Form::Entry;
use ClubTriumph::Form::EntryCar;
use ClubTriumph::Form::EntryFee;
use ClubTriumph::Form::EntryMer;
use ClubTriumph::Form::EntryAdmin;
use ClubTriumph::Form::EntryEmail;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::entry - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ClubTriumph::Controller::entry in entry.');
}


sub entry :Chained('../event/event') :PathPart('entry') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
	$c->stash(entry => $c->model('ClubTriumphDB::Entry')->find($id));

	#   $c->detach('/error_404') if !$c->stash->{object};
	die "Entry $id not found!" if !$c->stash->{entry};
	if ($c->stash->{entry}->has_expired) {
		$c->stash->{entry}->delete;
		$c->response->redirect($c->uri_for('/menu',$c->stash->{event}->menus->first->pid, 'event','expired'))

	}
	# Print a message to the debug log
	$c->log->debug("*** INSIDE OBJECT METHOD for entry id=$id ***");
}


sub create_entry : Chained('../event/event') :PathPart('enter') :Args(0) { #this is for a normal entrant
	my ($self, $c ) = @_;
	unless ($c->user_exists) {$c->response->redirect($c->uri_for( '/login', {mid => 'You must log in to access this form'})); return}
	unless ($c->stash->{event}->entry_open($c->user)) {die "Entries are not open for this event".$c->stash->{event}->entry_open}
	my $entry = $c->model('ClubTriumphDB::Entry')->find_or_create({user => $c->user->id, member => $c->user->memno, event => $c->stash->{event}->id, status => 'draft'});
	while ($entry->has_expired($c)) {
		$entry->delete;
		$entry = $c->model('ClubTriumphDB::Entry')->find_or_create({user => $c->user->id, member => $c->user->memno, event => $c->stash->{event}->id, status => 'draft'});
	}
	my $entrant = $c->model('ClubTriumphDB::Entrant')->find_or_create({user => $c->user->id, name => $c->user->fullname,
		  mobile => $c->user->mobile, team => $entry->id});
	if ($c->user->memno) {$entrant->update({memno => $c->user->memno->memno})}
    return $self->entry_form($c, $entry);
}

sub new_entry : Chained('../event/event') :PathPart('new_entry') :Args(0) { #this is for admin
	my ($self, $c ) = @_;
	unless ($c->user_exists) {$c->response->redirect($c->uri_for( '/login', {mid => 'You must log in to access this form'})); return}
#	$c->flash(location_return => {'url','/event/createevent'});
	my $entry = $c->model('ClubTriumphDB::Entry')->new_result({ event => $c->stash->{event}->id, status => 'draft'});
#	unless ($entry->entry_no) {
#		my $entry_no = $c->stash->{event}->entries_rs->get_column('entry_no')->max +1;
#		$entry->update({entry_no => $entry_no})}
#	unless ($entry->title) {
#		$entry->update({title => 'Team '.$entry->entry_no})}
#	my $entrant = $c->model('ClubTriumphDB::Entrant')->find_or_create({user => $c->user->id, name => $c->user->memno->fullname, memno => $c->user->memno->memno, team => $entry->id});
    return $self->entry_admin_form1($c, $entry);
}

sub entry_admin_edit : Chained('entry') PathPart('adminedit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{event}->admin_by($c->user)) {$c->error( "You do not have permission to edit this") }
	return $self->entry_admin_form1($c, $c->stash->{entry});
    }

sub entry_admin_form1 {
	my ( $self, $c, $entry ) = @_;
	my @inactive;
	unless ($entry->user && $entry->user->club_member)  {
		@inactive = ('member','entrants.memno');
	}
	my $form = ClubTriumph::Form::EntryAdmin->new( item => $entry, user => $c->user, entry => $c->stash->{entry},
		update_field_list =>  {entrants => {num_when_empty => $c->stash->{event}->min_team}},
		inactive => \@inactive);
	$form->field('entrants')->num_when_empty($entry->event->min_team);
	if ($entry->event->min_team > $entry->entrants) {
		$form->field('entrants')->num_extra($entry->event->min_team - $entry->entrants)}
	$c->stash( template => 'event/admin_entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user, entry => $c->stash->{entry} );
	return unless ($form->validated );
	if ($entry->status ne 'draft') {$entry->create_menu_item}
	if ($entry->event->car) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'admincaredit'))
	}
	else {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','admin_entry_list','all'))
	}
}

sub entry_car_admin_edit : Chained('entry') PathPart('admincaredit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{event}->admin_by($c->user)) {$c->error( "You do not have permission to edit this") }
	return $self->entry_car_admin_form($c, $c->stash->{entry});
    }
    

sub entry_car_admin_form {
	my ( $self, $c, $entry ) = @_;
	my @inactive;
	if ($entry->user->club_member) {
		@inactive = ('other_car', 'engine_size', 'regno')
	}
	else {
		@inactive = ('car', 'new_car')
	}
	my $form = ClubTriumph::Form::EntryCar->new( item => $entry, user => $c->user, entry => $c->stash->{entry}, inactive => \@inactive );
	$c->stash( template => 'event/admin_entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user, entry => $c->stash->{entry} );
	return unless $form->validated;
	if ($c->req->params->{previous}) {$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'adminedit'))}
	elsif ($entry->entry_merchandises->count({}) >0) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'adminextras'))}
	else {
			$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','admin_entry_list','all'))}
}


sub entry_edit : Chained('entry') PathPart('edit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{entry}->user->id == $c->user->id) {$c->error( "You do not have permission to edit this") }
	return $self->entry_form($c, $c->stash->{entry});
    }
   

sub entry_form {
	my ( $self, $c, $entry ) = @_;
	my $form;
	my @inactive;
	if ($entry->user->club_member)  {
		@inactive = ('member');
	}
	else {
		@inactive = ('member','entrants.memno');
	}
	$form = ClubTriumph::Form::Entry->new(item =>$entry, inactive => \@inactive);

	$form->field('entrants')->num_when_empty($entry->event->min_team);
	if ($entry->event->min_team > $entry->entrants) {
		$form->field('entrants')->num_extra($entry->event->min_team - $entry->entrants)}
	$c->stash( template => 'event/entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user,  ); #event => $c->stash->{event}
	return unless $form->validated;

	if ($entry->event->car) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'caredit'))
		}
	elsif ($entry->entry_merchandises->count({}) >0) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'extras'))}
	elsif ($entry->amount_payable > $entry->paid  || ($entry->event->fee_per_entry == 0 && $entry->event->fee_per_entrant == 0) ) {
		if ($entry->on_reserve) {
			$entry->make_reserve($c);
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
		}
		else {
			if ($entry->event->entry_open($c->user)) {
				if ($entry->status eq 'reserve'  && ! $entry->on_reserve) {$entry->update({status => 'resubmit'})}
				unless ($entry->tabletop($c)) {
					$c->response->redirect($c->uri_for('/current_order'))
				}
			}
			else {
				$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','closed'))
			}
		}
	}
	else {
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))}

}



sub entry_car_edit : Chained('entry') PathPart('caredit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{entry}->user->id == $c->user->id) {$c->error( "You do not have permission to edit this") }
	return $self->entry_car_form($c, $c->stash->{entry});
    }
    




sub entry_car_form {
	my ( $self, $c, $entry ) = @_;
	my @inactive;
	if ($entry->user->club_member) {
		@inactive = ('other_car', 'engine_size', 'regno')
	}
	else {
		@inactive = ('car', 'new_car')
	}
	my $form = ClubTriumph::Form::EntryCar->new( item => $entry, user => $c->user, entry => $c->stash->{entry}, inactive => \@inactive );
	$c->stash( template => 'event/entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user, entry => $c->stash->{entry} );
	return unless $form->validated;
	if ($c->req->params->{previous}) {$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'edit'))}
	elsif ($entry->entry_merchandises->count({}) >0) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'extras'))}
	elsif ($entry->amount_payable > $entry->paid || ($entry->event->fee_per_entry == 0 && $entry->event->fee_per_entrant == 0)) {
		if ($entry->on_reserve) {
			$entry->make_reserve($c);
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
		}
		else {
			if ($entry->event->entry_open($c->user) || ($entry->status eq 'reserve') || ($entry->status eq 'resubmit')) {
				if ($entry->status eq 'reserve'  && ! $entry->on_reserve) {$entry->update({status => 'resubmit'})}
				unless ($entry->tabletop($c)) {
					$c->response->redirect($c->uri_for('/current_order'))
				}
			}
			else {
				$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','closed'))
			}
		}
	}
	else {
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))}
}

sub entry_new_car : Chained('entry') PathPart('careditnew') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{entry}->user->id == $c->user->id) {$c->error( "You do not have permission to edit this") }
	my $car = $c->model('ClubTriumphDB::Register')->new_result({memno => $c->stash->{entry}->member});
	return $self->entry_new_car_form($c, $car);
    }
   
sub entry_new_car_form {
	my ( $self, $c, $register ) = @_;
	my $form = ClubTriumph::Form::Register->new( user => $c->user, entry => $c->stash->{entry});
	$c->stash( template => 'register/register_form.tt2', form => $form, $register );
	$form->process( item => $register, params => $c->req->params, user => $c->user  );
	return unless $form->validated;
	my $entry = $c->stash->{entry};
	$entry->update({car => $register});
	if ($entry->entry_merchandises->count({}) >0) {
		$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'extras'))}
	elsif ($entry->amount_payable > $entry->paid || ($entry->event->fee_per_entry == 0 && $entry->event->fee_per_entrant == 0)) {
		if ($entry->on_reserve) {
			$entry->make_reserve($c);
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
		}
		else {
			if ($entry->event->entry_open($c->user) || ($entry->status eq 'reserve') || ($entry->status eq 'resubmit')) {
				if ($entry->status eq 'reserve'  && ! $entry->on_reserve) {$entry->update({status => 'resubmit'})}
				unless ($entry->tabletop($c)) {
					$c->response->redirect($c->uri_for('/current_order'))
				}
			}
			else {
				$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','closed'))
			}
		}
	}
	else {
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))}
}

sub admin_entry_new_car : Chained('entry') PathPart('admincareditnew') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{event}->admin_by($c->user)) {$c->error( "You do not have permission to edit this") }
	my $entry = $c->stash->{entry};
	my $car = $c->model('ClubTriumphDB::Register')->new_result({memno => $entry->member});
	return $self->admin_entry_new_car_form($c, $car);
    }
   
sub admin_entry_new_car_form {
	my ( $self, $c, $register ) = @_;
	my $form = ClubTriumph::Form::Register->new( user => $c->user, entry => $c->stash->{entry});
	$c->stash( template => 'register/register_form.tt2', form => $form  );
	$form->process( item => $register, params => $c->req->params, user => $c->user );
	return unless $form->validated;
	my $entry = $c->stash->{entry};
	$entry->update({car => $register});
	$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'admincaredit'))

}

sub entry_admin_list :Chained('../event/event') :PathPart('admin_entry_list') :Args(1) {
	my ( $self, $c, $status ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{event}->admin_by($c->user)) {$c->error( "You do not have permission to edit this") }
	my @entries;
	if ($status eq 'all') {@entries = [$c->stash->{event}->entries->all]}
	else {@entries = [$c->stash->{event}->entries->search({status => $status})]}
	$c->stash(template => 'entry/admin_list.tt2', entries => @entries)
}

sub admin_entrant_email :Chained('../event/event') :PathPart('admin_entrant_email') :Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error('no permission')}
	my $event = $c->stash->{event};
	return $self->admin_email_form($c, $event);
}

sub admin_email_form {
	my ( $self, $c, $event ) = @_;
	my @field_list;
	push (@field_list, {name => 'to_self', type => 'Boolean', 
			label => 'to self ('.$c->user->email.')', 
			wrapper_class => 'form-tags',
		});
	foreach my $status ($event->entry_statuses) {
		unless ($status eq 'draft') {
			push (@field_list, {name => 'to_'.$status, type => 'Boolean', 
				label => 'to '.$status.' ('.$event->entries->count({status => $status}).')', 
				wrapper_class => 'form-tags',
			});
		}
	}
	my $params = $c->req->params;
	my %newparams;
	foreach my $param (keys %$params) { 
		if ($param =~ /^entry_(\d*)$/) {
			my $entry = $event->entries->find({id => $1});
			if ($entry) {
				push (@field_list, {name => 'entrant_'.$entry->id, type => 'Boolean', 
				label => 'to entry '.$entry->entry_no.' ('.$entry->member->email.')', 
				wrapper_class => 'form-tags'});
			}
		}
		else {
			$newparams{$param} = $c->req->params->{$param};
		}
	}
	my $email_path = $c->path_to('root','src','email','event_email');
	my $template = '';
	if (-e $email_path.'/'.$event->id.'.tt2') {
		open (TEMPLATE, $email_path.'/'.$event->id.'.tt2') || die "can't open ".$email_path.'/'.$event->id.'.tt2' ;
		read(TEMPLATE,$template,10000);
		close TEMPLATE; 
	}
	my $form = ClubTriumph::Form::EntryEmail->new(from => $event->email, field_list => \@field_list, defaults => { from => $event->email, content => $template },
		inactive => ['character_count']);
	$c->stash( template => 'entry/admin_email_form.tt2', form => $form);
	$form->process(  params => \%newparams, );
	return unless $form->validated;
	$self->send_entrants_emails($c, $event, $form);
}

sub send_entrants_emails {
	my ($self, $c, $event, $form) = @_;
	my $content = $form->field('content')->value;
	my $email_path = $c->path_to('root','src','email','event_email');
	open (TEMPLATE, '>'.$email_path.'/'.$event->id.'.tt2') || die "can't open ".$email_path.'/'.$event->id.'.tt2' ;
	print TEMPLATE $content;
	close TEMPLATE;
	my @email_success;
	my @email_fail;
	if ($form->field('to_self')->value == 1) {
		my $entrant;
		$entrant = $event->entries->search({member => $c->user->memno->memno})->first;
		unless ($entrant) {
			$entrant = $event->entries->search({status => {'!=' => 'draft'}})->first;
		}
		$entrant->email_entrant($c,'',$form->field('subject')->value,$form->field('from')->value,'event_email/'.$event->id.'.tt2', $c->user->email)
	}
	foreach my $status ($event->entry_statuses) {
		if ($status ne 'draft' && $form->field('to_'.$status)->value == 1) {
			my @entries = $event->entries->search({status => $status});
			foreach my $entrant (@entries) {
				if ($entrant->email_entrant($c,'',$form->field('subject')->value,$form->field('from')->value,'event_email/'.$event->id.'.tt2')) {
					push (@email_success, $entrant)
				}
				else {
					push (@email_fail, $entrant)
				}
			}
		}
	}
	foreach my $entrant ($event->entries) {
		if ($form->field('entrant_'.$entrant->id) && $form->field('entrant_'.$entrant->id)->value == 1) {
			if ($entrant->email_entrant($c,'',$form->field('subject')->value,$form->field('from')->value,'event_email/'.$event->id.'.tt2')) {
				push (@email_success, $entrant)
			}
			else {
				push (@email_fail, $entrant)
			}
		}
	}
	$c->flash(success => \@email_success, fail => \@email_fail);
}

sub admin_entrant_sms :Chained('../event/event') :PathPart('admin_entrant_sms') :Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error('no permission')}
	my $event = $c->stash->{event};
	return $self->admin_sms_form($c, $event);
}

sub admin_sms_form {
	my ( $self, $c, $event ) = @_;
	my @field_list;
	push (@field_list, {name => 'to_self', type => 'Boolean', 
			label => 'to self ('.$c->user->mobile.')', 
			wrapper_class => 'form-tags',
		});
	foreach my $status ($event->entry_statuses) {
		unless ($status eq 'draft') {
			push (@field_list, {name => 'to_'.$status, type => 'Boolean', 
				label => 'to '.$status.' ('.$event->entries->count({status => $status}).')', 
				wrapper_class => 'form-tags',
			});
		}
	}
	my $params = $c->req->params;
	my %newparams;
	foreach my $param (keys %$params) { 
		if ($param =~ /^entry_(\d*)$/) {
			my $entry = $event->entries->find({id => $1});
			if ($entry) {
				push (@field_list, {name => 'entrant_'.$entry->id, type => 'Boolean', 
				label => 'to entry '.$entry->entry_no.' ('.$entry->member->email.')', 
				wrapper_class => 'form-tags'});
			}
		}
		else {
			$newparams{$param} = $c->req->params->{$param};
		}
	}
#	my $email_path = $c->path_to('root','src','email','event_email');
#	open (TEMPLATE, $email_path.'/'.$event->id.'.tt2') || die "can't open ".$email_path.'/'.$event->id.'.tt2' ;
#	my $template = <TEMPLATE>;
#	close TEMPLATE;
	my $form = ClubTriumph::Form::EntryEmail->new(from => $event->email, field_list => \@field_list, defaults => { from => $c->user->mobile },, inactive => ['subject']  );
	$c->stash( template => 'entry/admin_sms_form.tt2', form => $form, credits => $c->model('ClubTriumphDB::Entrant')->smscredit);
	$form->process(  params => \%newparams, );
	return unless $form->validated;
	my $response = $self->send_entrants_sms($c, $event, $form);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','admin_entry_list','all'), );#{mid =>$c->set_status_msg($response)}
}

sub send_entrants_sms {
	my ($self, $c, $event, $form) = @_;
	my $content = $form->field('content')->value;
	my $email_path = $c->path_to('root','src','email','event_email');
	my $response;
	foreach my $status ($event->entry_statuses) {
		if ($status ne 'draft' && $form->field('to_'.$status)->value == 1) {
			$response = $event->entries->search({status => $status})->related_resultset('entrants')->sendsms($content,$form->field('from')->value); 
		}
	} 
	if ($form->field('to_self')->value == 1) { 
		$c->user->memno->sendsms($content,$form->field('from')->value)
	}
	return $response;
#	$c->flash(success => \@email_success, fail => \@email_fail);
}

sub new_sms :Chained('../event/event') :PathPart('new_sms') :Args(0) {
	my ($self, $c) = @_;
	my $sms = $c->model('ClubTriumphDB::Sm')->new_sms($c);
	return unless ($sms->is_complete);
	$c->stash->{event}->handle_broadcast($c,$sms);
	$c->stash->{event}->entries->new_sms($c,$sms);
}

sub new_telegram :Chained('../event/event') :PathPart('new_telegram') :Args(0) {
	my ($self, $c) = @_; 
	$c->model('ClubTriumphDB::Telegram')->new_telegram($c); 
#	$c->stash->{event}->related_resultset('Telegram')->new_telegram($c); 

	$c->stash(template => 'event/telegram.tt2');
}

sub entrants_csv :Chained('../event/event') :PathPart('entrants_csv') :Args(1) {
	my ( $self, $c, $status ) = @_;
	my @columns = qw ( status title entry_no entrants_name crew1 crew2 crew3 crew4 car year colour engine reg town email crew_1_mobile crew_2_mobile crew_3_mobile crew_4_mobile crew1_local_group crew2_local_group crew3_local_group crew4_local_group) ;
	foreach my $extra ($c->stash->{event}->event_merchandises) {
		push (@columns, 'crew_1_'.$extra->id, 'crew_2_'.$extra->id, 'crew_3_'.$extra->id, 'crew_4_'.$extra->id);
	}
	$c->stash (data => $c->stash->{event}->entries->export_data,  
	columns => \@columns,
	current_view => "CSV" );

#		columns => [ qw ( forename surname address1 address2 address3 address4 postcode tel mobile email) ],  current_view => "CSV" );
#	$c->forward('View::CSV');
}

sub entry_admin_view :Chained('entry') :PathPart('admin_entry_view') :Args(0) {
	my ($self, $c) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {$c->error('no permission')}
	$c->stash(template => 'entry/admin_entry_view.tt2')
}

sub entry_fee : Chained('entry') PathPart('fee') :Args(0) {
	my ($self, $c ) = @_;
	return $self->entry_fee_form($c, $c->stash->{entry});
#	$c->stash( template => 'event/entry_fee.tt2');
    }
    
sub entry_fee_form {
	my ( $self, $c, $entry ) = @_;

	my $form = ClubTriumph::Form::EntryFee->new( item => $entry, user => $c->user, entry => $c->stash->{entry} );
	$c->stash( template => 'event/entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user, entry => $c->stash->{entry} );
	return unless $form->validated;
	if ($c->req->params->{previous}) {
		if ($entry->entry_merchandises->count({}) >0) {
			$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'extras'))}
		else {
			$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'caredit'))}
		}
	else {
		if ($entry->amount_payable > $entry->paid) {
			if ($entry->on_reserve) {
				$entry->make_reserve($c);
				$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
			}
			else {
				$c->response->redirect($c->uri_for('/current_order'))
			}
			}
		else {
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))}
		}

}


sub entry_extras : Chained('entry') PathPart('extras') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{entry}->user->id == $c->user->id) {$c->error( "You do not have permission to edit this") }
	return $self->entry_extras_form($c, $c->stash->{entry});
#	$c->stash( template => 'event/entry_fee.tt2');
    }
    
sub admin_entry_extras_form {
	my ( $self, $c, $entry ) = @_;

	my $form = ClubTriumph::Form::EntryMer->new(item => $entry,    );
	$c->stash( template => 'event/entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user );
	return unless $form->validated;
	if ($c->req->params->{previous}) {$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'caredit'))}
	else {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','admin_entry_list','all'))
	}
}


sub admin_entry_extras : Chained('entry') PathPart('adminextras') Args(0) {
	my ( $self, $c ) = @_;
	return $self->admin_entry_extras_form($c, $c->stash->{entry});
#	$c->stash( template => 'event/entry_fee.tt2');
    }
    
sub entry_extras_form {
	my ( $self, $c, $entry ) = @_;

	my $form = ClubTriumph::Form::EntryMer->new(item => $entry,    );
	$c->stash( template => 'event/entry_form.tt2', form => $form, entry => $entry );
	$form->process( item => $entry, params => $c->req->params, user => $c->user );
	return unless $form->validated;
	if ($c->req->params->{previous}) {
		if ($entry->event->car) {
			$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'caredit'))
		}
		else { 
			$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','entry',$entry->id, 'edit'))
		}
	}
	elsif  ($entry->amount_payable > $entry->paid || ($entry->event->fee_per_entry == 0 && $entry->event->fee_per_entrant == 0)) {
		if ($entry->on_reserve) {
			$entry->make_reserve($c);
			$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
		}
		else {
			if ($entry->event->entry_open($c->user) || ($entry->status eq 'reserve') || ($entry->status eq 'resubmit')) {
				if ($entry->status eq 'reserve'  && ! $entry->on_reserve) {$entry->update({status => 'resubmit'})}
				unless ($entry->tabletop($c)) {
					$c->response->redirect($c->uri_for('/current_order'))
				}
			}
			else {
				$c->response->redirect($c->uri_for('/menu',$entry->event->menus->first->pid,'event','closed'))
			}
		}
	}
	else {
		$c->response->redirect($c->uri_for('/menu',$entry->event->entrylist->pid, 'view'))
	}
}


sub entry_expired : Chained('../event/event') PathPart('expired') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(template => 'entry/expired.tt2');
}

sub entry_closed : Chained('../event/event') PathPart('closed') Args(0) {
	my ( $self, $c ) = @_;
	$c->stash(template => 'entry/closed.tt2');
}

=cut
sub import_entries : Chained('event') :PathPart('import_entries') :Args(1) {
	my ($self,$c,$file) =@_;
	use Text::CSV;
	my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
		or die "Cannot use CSV: ".Text::CSV->error_diag ();
	my $dir = "/home/Keith/Documents/entry lists/";
	open (FILE, $dir.$file) || $c->response->body('cant find '.$file);
	my @lines = <FILE>;
	close FILE;
	my $response;
	my $members = $c->model('ClubTriumphDB::Member');
	my $cars = $c->model('ClubTriumphDB::Register');
	my @regs = $cars->get_column('regno')->all;
	foreach my $line (@lines) {
#		$response .= $line;
		my $status = $csv->parse($line);
		my @columns = $csv->fields();
		my ($stat,$entryno,@entrant,$car,$year,$colour,$engine,$reg,$town,$prevfin,$email,
		@mobile,$paid,$date,$banked,$notes,$emailsent,$Form,$RefundReq,$RefundNotes,$memno);
		($stat,$entryno,$entrant[0],$entrant[1],$entrant[2],$entrant[3],$car,$year,$colour,$engine,$reg,$town,$prevfin,$email,
		$mobile[0],$mobile[1],$mobile[2],$mobile[3],$paid,$date,$banked,$notes,$emailsent,$Form,$RefundReq,$RefundNotes,$memno) = @columns;
		foreach my $entrant (@entrant) {
			$response .='<br>member '.$entrant."\n";
			if ($memno) {
				my $member = $members->find($memno);
				if ($member) {$response .= 'found by memno  '.$member->memno.' '.$member->fullname}
			}
			my ($forename,$surname) = split(/ /, $entrant);
			if ($forename && $surname) {
				my $member = $members->find({'forename' => $forename, 'surname' => $surname});
				if ($member) {$response .= 'found '.$member->memno}
			}
		}
		$response .='<br>car '.$reg."\n";
		foreach my $regno (@regs) { 
			my $test = $regno;
			$test =~ s/ //g;
			if (uc($test) eq uc($reg)) {
				my $triumph = $cars->find({'regno' => $regno});
#				if ($triumph) { 
					$response .='carfound '.$triumph->regno."\n";
#				}
			}
		}
	}
	
	$c->response->body($response);
}

=cut

=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub labels : Chained('../event/event') PathPart('labels') Args(1)  {
	my ( $self, $c, $status ) = @_;
	my $entrants = $c->stash->{event}->entries->search({status => $status});
	$c->stash(members => [$entrants->related_resultset('member')->all]);
	$c->stash->{pdf_template} = 'reports/labels.tt2';
	$c->forward('View::PDF::Reuse');
}

__PACKAGE__->meta->make_immutable;

1;
