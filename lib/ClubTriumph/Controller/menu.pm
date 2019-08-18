package ClubTriumph::Controller::menu;
use ClubTriumph::Form::Menu;
use ClubTriumph::Form::MenuContent;
use ClubTriumph::Form::MenuNav;
use ClubTriumph::Form::MenuPerm;
use ClubTriumph::Form::MenuImport;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::menu - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

   $c->response->redirect($c->uri_for('/menu',1,'view'))
}

=head2 base
    
    Can place common logic to start chained dispatch here
    
=cut
    
sub base :Chained('/') :PathPart('menu') :CaptureArgs(1) {
	my ($self, $c, $pid) = @_;
	unless ($pid) {$pid = 1}
	$c->stash(menu_item => $c->model('ClubTriumphDB::Menu')->find({pid => $pid}));  
	$c->error( "Menu Item $pid not found!") if !$c->stash->{menu_item};
	$c->error( "You do not have permission to view this!") unless (($c->stash->{menu_item}->view >= 256) ||($c->user_exists && $c->stash->{menu_item}->viewable_by($c->user)));  
	if ($c->stash->{menu_item}->type eq 'current_club_torque') {
		$c->stash(menu_item => $c->model('ClubTriumphDB::Clubtorque')->search({},{order_by => {'-desc' => 'edition'}, rows=> 1})->first->menus->first)
	}
	if ($c->user && $c->stash->{menu_item}->type eq 'memberroot') {
		$c->stash(menu_item => $c->user->menus->search({type => 'user_profile'})->single)
	}
	$c->stash(title1 => ' - '.join(' - ', reverse($c->stash->{menu_item}->hierachy))) unless ($c->stash->{menu_item}->pid ==1);
#	 $c->detach('/error_404') if !$c->stash->{object};
	$c->stash(baseurl => ['/menu',$c->stash->{menu_item}->pid]);
#	$c->session(last_visited => {tag => 'menu', 'tagid' => $c->stash->{menu_item}->pid});
	$c->stash(allcars => $c->model('ClubTriumphDB::Triumphsall')->all_triumphs) if ($c->stash->{menu_item}->type eq 'carsroot');
	if ($c->user) {
		my $yesterday = time - 24*60*60;
#		my $popularity = $c->model('ClubTriumphDB::History')->count({'menu' => $pid, 'time' => {'>' => $yesterday}});

		my $history = $c->model('ClubTriumphDB::History')->create({'menu' => $pid, 'user' => $c->user->id})  # , 'popularity' => $popularity

	}
	my $params = $c->request->params;
	foreach my $param (keys (%$params)) {
		if ($param =~ /.*page$/) {
			$c->session($param => {page => $c->request->params->{$param}, pid => $c->stash->{menu_item}->pid});
			if ($c->session->{$param}{pid} != $c->stash->{menu_item}->pid) {
				$c->session($param => {page => 1, pid => $c->stash->{menu_item}->pid})
			}
		}
	}

	$c->log->debug('*** INSIDE BASE METHOD FOR MENU ***');
}


sub view  :Chained('base') :PathPart('view') :Args(0){

    my ( $self, $c,  ) = @_;
	unless ($c->stash->{menu_item}->viewable_by($c->user)) {
		unless ($c->user) {
			$c->stash(template => 'menu/login.tt2');
			return
		}
		$c->response->redirect($c->uri_for( '/'))
	}
	if ($c->stash->{menu_item}->type eq'user_profile') { $c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'user','profile'))}

	if (($c->stash->{menu_item}->type =~ /(^event$)|(^location$)|(^localgroup$)/) && !$c->stash->{menu_item}->content && !$c->stash->{menu_item}->news->count({})) {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'map'))}
	if (($c->stash->{menu_item}->type =~ /profileroot/) && !$c->stash->{menu_item}->content && !$c->stash->{menu_item}->news->count({})) {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'links'))}
	if ($c->stash->{menu_item}->type eq 'eventroot') {
		$c->stash(future_events => [$c->model('ClubTriumphDB::Event')->future_events]);
		$c->stash(past_events => [$c->model('ClubTriumphDB::Event')->past_events])}
	if ($c->stash->{menu_item}->type eq 'locationroot') {
		$c->stash(locations => [$c->model('ClubTriumphDB::location')->all]);
	}
	if ($c->stash->{menu_item}->messages_viewable_by($c->user)) {
		if ($c->stash->{menu_item}->type =~ /carsroot/) {
			$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'forum'))
		}
		elsif ($c->stash->{menu_item}->type =~ /(car)|(mark)|(model)|(forum)/) {
			$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'threads'))
		}
	}

	$c->stash(template => 'menu/details.tt2');
}

sub admin  :Chained('base') :PathPart('admin') :Args(0){

    my ( $self, $c,  ) = @_;
	unless ($c->stash->{menu_item}->viewable_by($c->user)) {
		$c->error("Item  not viewable by user!")}

    $c->stash(template => 'menu/admin_main.tt2');
}


sub map : Chained('/menu/base') :PathPart('map') :Args(0) {
	my ($self, $c ) = @_;
	if ($c->stash->{menu_item}->type eq 'event') {
		$c->stash(template => 'event/map.tt2')
	}
	elsif ($c->stash->{menu_item}->type eq 'location') {
		$c->stash(template => 'location/map.tt2')
	}
	elsif ($c->stash->{menu_item}->type eq 'localgroup') {
		$c->stash(template => 'localgroups/map.tt2')
	}
	$c->stash(title2 => ' - Map');
}

sub form  {
	my ( $self, $c, $menu_item ) = @_;

        my $form = ClubTriumph::Form::Menu->new(item => $menu_item, user => $c->user);

        $c->stash( template => 'menu/menuform.tt2', form => $form, $menu_item );
        my $old_parent = $menu_item->parent;
        $form->process( item => $menu_item, params => $c->req->params, old_parent => $old_parent, user => $c->user );
        return unless $form->validated;
		$c->response->redirect($c->uri_for( $menu_item->id, 'view', {mid => $c->set_status_msg("Item edited")})); 

    }
    
    
sub permform  {
	my ( $self, $c, $menu_item ) = @_;

        my $form = ClubTriumph::Form::MenuPerm->new(item => $menu_item, user => $c->user);

        $c->stash( template => 'menu/menuform.tt2', form => $form, $menu_item );
        my $old_parent = $menu_item->parent;
        $form->process( item => $menu_item, params => $c->req->params, old_parent => $old_parent, user => $c->user );
        return unless $form->validated;
#        $menu_item->spider($c);
		$c->response->redirect($c->uri_for( $menu_item->id, 'view', {mid => $c->set_status_msg("Item edited")})); 

    }
    
sub navform  {
	my ( $self, $c, $menu_item ) = @_;

        my $form = ClubTriumph::Form::MenuNav->new(item => $menu_item, user => $c->user);
#		if ($menu_item->parent) {$menu_item->parent->order_children}
        $c->stash( template => 'menu/menunavform.tt2', form => $form, $menu_item );
        my $old_parent = $menu_item->parent;
        $form->process( item => $menu_item, params => $c->req->params, old_parent => $old_parent, user => $c->user );
        return unless $form->validated;
#        $menu_item->spider($c);
		$c->response->redirect($c->uri_for( $menu_item->id, 'view', {mid => $c->set_status_msg("Item edited")})); 

    }
    
sub contentform  {
	my ( $self, $c, $menu_item ) = @_;
		my @inactive;
		unless (($menu_item->type eq 'item') || ($menu_item->type eq 'html')) {@inactive = (inactive => ['heading1'])}
        my $form = ClubTriumph::Form::MenuContent->new(item => $menu_item, @inactive, user => $c->user);
        my $params = $c->req->params;
        my %param = %$params;
        $param{photo} = $c->req->upload('photo')  if $c->req->method eq 'POST';
        $c->stash( template => 'menu/menucontentform.tt2', form => $form, $menu_item );
        my $old_parent = $menu_item->parent;
        $form->process( item => $menu_item, params => \%param );
        return unless ($form->validated && !$param{upload});
        unless ($menu_item->menu_order) {$menu_item->make_last}
        $menu_item->link_uploaded_images($c);
 #       $menu_item->spider($c);
		$c->response->redirect($c->uri_for( $menu_item->id, 'view', {mid => $c->set_status_msg("Item edited")})); 

    }
    
sub importform  {
	my ( $self, $c, $menu_item ) = @_;

        my $form = ClubTriumph::Form::MenuImport->new(item => $menu_item, user => $c->user);
		if ($menu_item->parent) {$menu_item->parent->order_children}
        $c->stash( template => 'menu/simpleform.tt2', form => $form, $menu_item );
        my $old_parent = $menu_item->parent;
        $form->process( item => $menu_item, params => $c->req->params );
        return unless $form->validated;
 #       $menu_item->spider($c);
		$c->response->redirect($c->uri_for( $menu_item->id, 'view', {mid => $c->set_status_msg("Item edited")})); 

    }
    
 sub edit : Chained('base') PathPart('edit') Args(0) {
        my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
        return $self->form($c, $c->stash->{menu_item});
    }
    
sub contentedit : Chained('base') PathPart('contentedit') Args(0) {
        my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash(formtitle => 'Editing '.$c->stash->{menu_item}->heading1.' content');
        return $self->contentform($c, $c->stash->{menu_item});
    }

sub navedit : Chained('base') PathPart('navedit') Args(0) {
        my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash(formtitle => 'Editing '.$c->stash->{menu_item}->heading1.' navigation');

        return $self->navform($c, $c->stash->{menu_item});
    }

sub permedit : Chained('base') PathPart('permedit') Args(0) {
        my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash(formtitle => 'Editing '.$c->stash->{menu_item}->heading1.' permissions');

        return $self->permform($c, $c->stash->{menu_item});
    }

sub importedit : Chained('base') PathPart('importedit') Args(0) {
        my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->editable_by($c->user)) {
		die "Item  not editable by user!"}
	$c->stash(formtitle => 'Editing '.$c->stash->{menu_item}->heading1.' import settings');

        return $self->importform($c, $c->stash->{menu_item});
    }

 sub create :  Chained('base') PathPart('create') Args(0) {
      my ($self, $c ) = @_;
      $c->stash(formtitle => 'Creating New Web Page');

        my $item = $c->model('ClubTriumphDB::Menu')->new_result({
			parent => $c->stash->{menu_item}->pid,
			type => 'html',
			user => $c->user->id,
			view => $c->stash->{menu_item}->view,
			edit => $c->stash->{menu_item}->edit,
			anchor => $c->stash->{menu_item}->anchor,
			view_blogs => $c->stash->{menu_item}->view_blogs,
			add_blog => $c->stash->{menu_item}->add_blog,
			view_images => $c->stash->{menu_item}->view_images,
			add_image => $c->stash->{menu_item}->add_image,
			view_messages => $c->stash->{menu_item}->view_messages,
			add_message => $c->stash->{menu_item}->add_message,
			view_blogs => $c->stash->{menu_item}->view_blogs,
			add_event => $c->stash->{menu_item}->add_event,
			add_news => $c->stash->{menu_item}->add_news,
			add_championship => $c->stash->{menu_item}->add_championship,
			manager => $c->stash->{menu_item}->manager,
			deletable => 2,
			});
        return $self->contentform($c, $item);
    }

 sub deleteconfirm :  Chained('base') PathPart('deleteconfirm') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->deletable_by($c->user)) {
		die "Item  not editable by user!"}
#	$c->response->body('Are you sure you want to permanently delete '.$c->stash->{menu_item}->title.'? <a href = "'.$c->uri_for($c->stash->{menu_item}->pid,'delete').'">delete</a>');
	$c->stash( template => 'menu/deleteconfirm.tt2');

 }

 sub delete :  Chained('base') PathPart('delete') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->stash->{menu_item}->deletable_by($c->user)) {
		die "Item  not editable by user!"}
	my $parent = $c->stash->{menu_item}->parent;
	$c->stash->{menu_item}->remove;
	$c->response->redirect($c->uri_for($parent->pid, 'view')); 
 }



sub order : Local {
	my ($self, $c ) = @_;
	my $home = $c->model('ClubTriumphDB::Menu')->find({pid => 1});
	&siblings($home,$c);
	$c->response->redirect($c->uri_for( 4, 'view')); 
}
	
sub siblings {
	my ($self, $c) =@_;
	if ($self->children)
	{
		my $order = 1;
		my @children = $self->children;
		foreach my $child (@children)
		{
				my $title = $child->title;
	$c->log->debug("******found $title $order************************ ");
			$child->update({menu_order => $order});
			$order ++;
			if ($child->children) {&siblings($child,$c)}
		}
	}
} 

sub move_up : Chained('base') :PathPart('move_up') :Args(0) {
	my ( $self, $c,  ) = @_;
	my $menu_item = $c->stash->{menu_item};
	my $current = $menu_item->menu_order;
	my $prev = $current -1;
	my $swap = $c->model('ClubTriumphDB::Menu')->find({menu_order => $prev, parent => $menu_item->parent});
	if ($swap) {
		$swap->update({menu_order => $current});
		$menu_item->update({menu_order => $prev});
	}
	$c->response->redirect($c->uri_for( $menu_item->id, 'navedit')); 
}

sub move_down : Chained('base') :PathPart('move_down') :Args(0) {
	my ( $self, $c,  ) = @_;
	my $menu_item = $c->stash->{menu_item};
	my $current = $menu_item->menu_order;
	my $next = $current +1;
	my $swap = $c->model('ClubTriumphDB::Menu')->find({menu_order => $next, parent => $menu_item->parent});
	if ($swap) {
		$swap->update({menu_order => $current});
		$menu_item->update({menu_order => $next});
	}
	$c->response->redirect($c->uri_for( $menu_item->id, 'navedit')); 
}

sub move_to : Chained('base') :PathPart('move_to') :Args(1) { # move to a specific place in the order
	my ( $self, $c, $position  ) = @_;
	my $menu_item = $c->stash->{menu_item};
	my $current = $menu_item->menu_order;
	if ($position < $current) {
		foreach my $next ($c->model('ClubTriumphDB::Menu')->search({parent => $menu_item->parent->pid, menu_order => {'between' => [$position  ,$current -1]}})) {
			$next->update({menu_order => $next->menu_order + 1 })
		}
	}
	if ($position > $current) {
		foreach my $next ($c->model('ClubTriumphDB::Menu')->search({parent => $menu_item->parent->pid, menu_order => {'between' => [$current +1 ,$position ]}})) {
			$next->update({menu_order => $next->menu_order - 1 })
		}
	}
	$menu_item->update({menu_order => $position});

	$c->response->redirect($c->uri_for( $menu_item->id, 'navedit')); 
}


sub content_image : Chained('base') :PathPart('content_image') :Args(1) {
	my ($self,$c,$size ) = @_;
	my $image_url = $c->stash->{menu_item}->content_image($c, $size);
	$c->response->redirect($image_url);
}

sub avatar : Chained('base') :PathPart('avatar') :Args(1) {
	my ($self,$c,$size ) = @_;
	my $image_url = $c->stash->{menu_item}->avatar($c,$size);
	if ($image_url) {
		$c->response->redirect($image_url);
		return;
	}
	elsif ($c->stash->{menu_item}->entry && $c->stash->{menu_item}->entry->car) {
		$image_url = $c->stash->{menu_item}->entry->car->menus->first->avatar($c,$size);
		if ($image_url) {
			$c->response->redirect($image_url);
			return
		}
	}
	elsif ($c->stash->{menu_item}->club_role && $c->stash->{menu_item}->club_role->members->count({}) == 1 && $c->stash->{menu_item}->club_role->members->first->profile) {
		$image_url = $c->stash->{menu_item}->club_role->members->first->profile->avatar($c,$size);
		if ($image_url) {
			$c->response->redirect($image_url);
			return
		}
	}
	$c->response->redirect($c->uri_for('/static','images','blank.gif'));
}




sub calendar  : Chained('base') :PathPart('calendar') :Args(0) {
	my ($self,$c ) = @_;
	$c->stash(template => 'menu/calendar.tt2', title2 => ' - calendar');
}

sub past_events :Chained('base') :Pathpart('past_events') :Args(0) {
	my ($self,$c) = @_;
	my $past_eventpage =1;
	if ($c->session->{past_eventpage} && $c->session->{past_eventpage}{pid} == $c->stash->{menu_item}->pid) { $past_eventpage = $c->session->{past_eventpage}{page} } 
	$c->stash(template => 'menu/link_display.tt2',
		links => [$c->stash->{menu_item}->past_events($c->user,20,$past_eventpage)],
		past_eventpage => $past_eventpage,
		count => $c->stash->{menu_item}->past_event_count($c->user),
		title2 => ' - Past Events',
		param => 'past_eventpage',
		current_page => $past_eventpage
		);
}	

sub future_events :Chained('base') :Pathpart('future_events') :Args(0) {
	my ($self,$c) = @_;
	my $future_eventpage =1;
	if ($c->session->{future_eventpage} && $c->session->{future_eventpage}{pid} == $c->stash->{menu_item}->pid) { $future_eventpage = $c->session->{future_eventpage}{page} } 
	$c->stash(template => 'menu/link_display.tt2',
		links => [$c->stash->{menu_item}->future_events($c->user,20,$future_eventpage)],
		future_eventpage => $future_eventpage,
		count => $c->stash->{menu_item}->future_event_count($c->user),
		title2 => ' - future Events',
		param => 'future_eventpage',
		current_page => $future_eventpage
		);
}	

sub links :Chained('base') :Pathpart('links') :Args(0) {
	my ($self,$c) = @_;
	my $link_page =1;
	if ($c->session->{link_page} && $c->session->{link_page}{pid} == $c->stash->{menu_item}->pid) { $link_page = $c->session->{link_page}{page} } 
	$c->stash(template => 'menu/link_display.tt2',
		links => [$c->stash->{menu_item}->viewable_children($c->user,20,$link_page)],
		link_page => $link_page,
		count => $c->stash->{menu_item}->viewable_link_count($c->user),
		title2 => ' - future Events',
		param => 'link_page',
		current_page => $link_page
		);
}	


sub cache_count :Chained('base') :Pathpart('cache_count') :Args(0) {
	my ($self,$c) = @_;
	my $menu = $c->stash->{menu_item};
#	my @types = $menu->items->search({},{group_by => 'contenttype'});
	my @types = $c->model('ClubTriumphDB::BlogMenu')->search({path => {'like' => $menu->path.'%'}},{group_by => 'type'})->related_resultset('item')->all;
	foreach my $cachedtype ($menu->itemcounts) {push @types, $cachedtype}
	foreach my $type (@types) {
		my $level = 1;
		while ($level < 1024) {
			$menu->count_items($type->contenttype->id,$level);
			if ($type->contenttype->id == 5) {
				$menu->count_items(6,$level);
			}
			$level = $level * 2;
		}
	}

	$c->response->redirect($c->uri_for( $menu->id, 'view', {mid => $c->set_status_msg("Cache updated")})); 
}

sub upload_images :Chained('base')  :Args(0) {
	my ($self,$c) = @_;
	my $menu_item = $c->stash->{menu_item};
	my $resultCode =0;
	if ($menu_item->images_addable_by($c->user))  {
		my @files = $c->model('ClubTriumphDB::Item')->upload_images($c);
		$c->stash->{data} = \@files;
	}
	else {$resultCode = 5}
	$c->stash->{resultCode} = $resultCode;
	$c->forward('ClubTriumph::View::JSON')
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
