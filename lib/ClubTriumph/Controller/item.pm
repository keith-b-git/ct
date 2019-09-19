package ClubTriumph::Controller::item;
#use ClubTriumph::Form::Item;
use ClubTriumph::Form::HTMLcontent;
use ClubTriumph::Form::HTMLimage;
use ClubTriumph::Form::messagecontent;
use ClubTriumph::Form::Report;
use Moose;
use utf8;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::item - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub redirect : Chained('/') PathPart('item') Args(1) {
	my ($self,$c,$id) =@_;
	my $item = $c->model('ClubTriumphDB::Item')->find({id => $id});
       $c->detach('/error_404') if !$item;
	unless ($item->viewable_by($c->user)) {
		die ('item not viewable by user')}
	my $menu_item = $c->stash->{menu_start};
	if ($c->user) {
		$menu_item = $c->model('ClubTriumphDB::History')->search({user => $c->user->id},{order_by => {-desc => 'time'}, rows => 1})->related_resultset('menu')->single;
	}
	my $context = $item->display_context($menu_item,$c->user);
	unless ($context->viewable_by($c->user)) {
		die ('item not viewable by user')}
	$c->response->redirect($item->view_uri($c, $context))
}




=cut
 sub create :  Chained('item') PathPart('create') Args(0)  {
      my ($self, $c ) = @_;
        $c->stash( template => 'item/itemform.tt2' );
        my $item = $c->model('ClubTriumphDB::Item')->new_item({},$c);
        return $self->form($c, $item);
    }

sub new_html :Local {
	my ($self, $c, $tag, $tagid) = @_;

	my $item = $c->model('ClubTriumphDB::Item')->new_html({},$c);
	
	return $self->contentform($c, $item, $tag, $tagid);
}
=cut

sub new_blog :Chained('/menu/base') :PathPart('new_blog') :Args(0) {
	my ($self, $c) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_thread({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '2',author => $c->user->id, view => $c->stash->{menu_item}->view, reply => 128});
	
	return $self->messageform($c, $item);
}

sub new_news :Chained('/menu/base') :PathPart('new_news') :Args(0) {
	my ($self, $c) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_thread({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '12',author => $c->user->id, view => $c->stash->{menu_item}->view, edit => 3});
	
	return $self->messageform($c, $item);
}

sub new_news_adv :Chained('/menu/base') :PathPart('new_news_adv') :Args(0) {
	my ($self, $c) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_thread({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '12',author => $c->user->id, view => $c->stash->{menu_item}->view, edit => 3});
	
	return $self->messageform($c, $item,1);
}


sub new_thread :Chained('/menu/base') :PathPart('new_thread') :Args(0) {
	my ($self, $c) = @_;
	my $reply = 128;
	if ($c->stash->{menu_item}->view < 255) {$reply = $c->stash->{menu_item}->view}
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '5',author => $c->user->id, view => $c->stash->{menu_item}->view, reply => $reply, replycount => 0});
	
	return $self->messageform($c, $item);
}

sub new_thread_adv :Chained('/menu/base') :PathPart('new_thread_adv') :Args(0) {
	my ($self, $c) = @_;
	my $reply = 128;
	if ($c->stash->{menu_item}->view < 255) {$reply = $c->stash->{menu_item}->view}
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '5',author => $c->user->id, view => $c->stash->{menu_item}->view, reply => $reply, replycount => 0});
	
	return $self->messageform($c, $item,1);
}

sub new_advert :Chained('/menu/base') :PathPart('new_advert') :Args(1) {
	my ($self, $c, $type) = @_;
	unless ($c->stash->{menu_item}->advert_addable_by($c->user)) {$c->error('Not allowed')};
	my $reply = 255;
	if ($c->stash->{menu_item}->view < 255) {$reply = $c->stash->{menu_item}->view}
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => $type,author => $c->user->id, view => $c->stash->{menu_item}->view, reply => $reply, price => '00.00'});
	return $self->messageform($c, $item);
}

sub new_image :Chained('/menu/base') :PathPart('new_image') :Args(0) {
	my ($self, $c, $tag, $tagid) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_image({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '3',author => $c->user->id, view => $c->stash->{menu_item}->view, licence => $c->user->licence});
	
	return $self->imageform($c, $item);
}

sub new_image_adv :Chained('/menu/base') :PathPart('new_image_adv') :Args(0) {
	my ($self, $c, $tag, $tagid) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_image({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '3',author => $c->user->id, view => $c->stash->{menu_item}->view, licence => $c->user->licence});
	
	return $self->imageform($c, $item, 1);
}



sub new_shop :Chained('/menu/base') :PathPart('new_shop') :Args(0) {
	my ($self, $c, $tag, $tagid) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_image({},$c);
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '8',author => $c->user->id, view => 256});
	
	return $self->imageform($c, $item);
}





sub new_reply :Chained('item') PathPart('new_reply') Args(0) {
	my ($self, $c, $tag, $tagid) = @_;

#	my $item = $c->model('ClubTriumphDB::Item')->new_message({},$c);
	my $item;
	if ($c->stash->{item}->contenttype->type eq 'PM') {
	$item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '7',author => $c->user->id, view => $c->stash->{item}->view, reply => $c->stash->{item}->reply,
				thread => $c->stash->{item}}, view => 1);
			} else {
	$item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '6',author => $c->user->id, view => $c->stash->{item}->view, reply => $c->stash->{item}->reply,
				thread => $c->stash->{item}});
		}
	return $self->replyform($c, $item, $tag, $tagid);
}




sub view  :Chained('item') PathPart('view') Args(0){

	my ( $self, $c,  ) = @_;
#	my %content = $c->model('ClubTriumphDB::Item')->html($c->stash->{item});
#	$c->stash(\%content);
	if (($c->stash->{item}->contenttype->id == 2) ||  ($c->stash->{item}->contenttype->id == 6) ||  (($c->stash->{item}->contenttype->id >= 8)
		&&  ($c->stash->{item}->contenttype->id <= 12))) { 
		$c->response->redirect($c->stash->{item}->view_uri($c, $c->stash->{menu_item}))
	}
	$c->stash->{item}->inc_views;
	$c->stash(title3 => ' - '.$c->stash->{item}->title);
	if ($c->request->params->{messagepage}) {
		$c->session(messagepage => {page => $c->request->params->{messagepage}, id => $c->stash->{item}->id})
	}
	if ($c->session->{messagepage} && ($c->session->{messagepage}{id} != $c->stash->{item}->id)) {
		$c->session(messagepage => {page => 1, id => $c->stash->{item}->id})
	}
=cut

	my $time = $c->stash->{item}->modified;
	$c->stash->{item}->update({'views' => $c->stash->{item}->views +1},'modified' => $time);
	
	if ($c->req->params->{reply} && ($c->req->params->{submit} eq 'Post Reply')) { 
		my $newitem = $c->model('ClubTriumphDB::Item')->create({contenttype => '6',
			author => $c->user->id,
			content => $c->req->params->{reply},
			 view => $c->stash->{item}->view,
			  reply => $c->stash->{item}->reply,
				thread => $c->stash->{item}});
	}
	if ($c->req->params->{reply} && ($c->req->params->{submit} eq 'Preview Reply')) { 
		my $newitem = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '6',
			author => $c->user->id,
			content => $c->req->params->{reply},
			 view => $c->stash->{item}->view,
			  reply => $c->stash->{item}->reply,
				thread => $c->stash->{item}});
		$c->stash(newreply => $newitem);
	}
=cut
	#set pm read tag
	if ($c->stash->{item}->contenttype->type eq 'PM') {
		if ($c->stash->{item}->related_resultset('pms')->find({userpm => $c->user->id, folder => 'inbox'},{key => 'user_item_folder'})) {
			$c->stash->{item}->related_resultset('pms')->find({userpm => $c->user->id, folder => 'inbox'},{key => 'user_item_folder'})->update({unread => 0 })
		}
	}
	if ($c->user) {
		$c->stash->{item}->related_resultset('items_read')->find_or_create({user => $c->user->id, item => $c->stash->{item}->id})
	}
	$c->stash(template => 'item/itemview.tt2');
		if ($c->stash->{item}->contenttype->id == 7) { #pm
			my $title = $c->stash->{item}->title;
			unless ($title =~ /^re /ig) {$title = 're '.$title}
			my $newreply = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '7',
				author => $c->user->id,
				view => $c->stash->{item}->view,
				reply => $c->stash->{item}->reply,
#				thread => $c->stash->{item},
				title => $title});
		if ($c->req->params->{content} && ($c->req->params->{preview})) { 

			my $newitem = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '7',
				title => $title,
				author => $c->user->id,
				content => $c->req->params->{content},
				view => $c->stash->{item}->view,
				reply => $c->stash->{item}->reply,
#				thread => $c->stash->{item},
			});
			$c->stash(newreply => $newitem);
			}
			return $self->replyform($c, $newreply, $c->stash->{item}->author->username);
		}
	if ($c->stash->{item}->replyable_by($c->user))	{
		if ($c->stash->{item}->contenttype->replyable == 1) {
			my $newreply = $c->model('ClubTriumphDB::Item')->new_result({
				contenttype => '6',
				author => $c->user->id,
				view => $c->stash->{item}->view,
				reply => $c->stash->{item}->reply,
				thread => $c->stash->{item},
				title =>$c->stash->{item}->title});
		if ($c->req->params->{content} && ($c->req->params->{preview})) { 
			my $newitem = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '6',
				author => $c->user->id,
				content => $c->req->params->{content},
				view => $c->stash->{item}->view,
				reply => $c->stash->{item}->reply,
				thread => $c->stash->{item}});
			$c->stash(newreply => $newitem);
			}
			return $self->replyform($c, $newreply);
			}
	}

	
		

#	$c->stash(template => 'menu/content.tt2');
}

sub popup :Chained('item') :Pathpart('popup') :Args(0) {
	my ($self, $c) = @_;
    $c->stash(template => 'item/image_popup.tt2');
}

=cut
sub itemview :Chained('item') :Pathpart('itemview') :Args(0) {
	my ($self, $c) = @_;
	my $time = $c->stash->{item}->modified;
	$c->stash->{item}->update({'views' => $c->stash->{item}->views +1},'modified' => $time);
	if ($c->stash->{item}->contentype->type eq 'PM') {$c->stash->{item}->userpms->find({userpm => $c->user->id})->update({read =>1 })}
	$c->stash->item->users->find_or_create({user => $c->user});
    $c->stash(template => 'menu/content.tt2');
}
=cut
 sub edit : Chained('item') PathPart('edit') Args(0) {
        my ( $self, $c ) = @_;
       $c->stash( template => 'item/itemform.tt2' );
        return $self->messageform($c, $c->stash->{item});
    }
    
 sub edit_adv : Chained('item') PathPart('edit_adv') Args(0) {
        my ( $self, $c ) = @_;
       $c->stash( template => 'item/itemform.tt2' );
        return $self->messageform($c, $c->stash->{item},1);
    }

 sub message_edit : Chained('item') PathPart('message_edit') Args(0) {
        my ( $self, $c ) = @_;
       $c->stash( template => 'item/itemform.tt2' );
        return $self->messageform($c, $c->stash->{item});
    }  
   

=head2 form

    Process the FormHandler form
=cut

    sub form  {
        my ( $self, $c, $item ) = @_;

 #       my $form = ClubTriumph::Form::Item->new;
        # Set the template
		my @field_list = $item->blogtags($c);
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
		user => $c->user,
		field_list => \@field_list,
#		user_id => $c->user->memno->memno, 
		 );
#        $c->stash( template => 'item/itemform.tt2', form => $form, $item );
		$c->stash( form => $form,  );
        $form->process( item => $item, params => $c->req->params );
        return unless $form->validated;
#		$c->response->redirect($c->uri_for( 'id',$item->id, 'edit', {mid => $c->set_status_msg("Item edited")})); 
		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Item updated")}))

    }


sub contentedit : Chained('item') PathPart('contentedit') Args(0) {
        my ( $self, $c ) = @_;

        return $self->contentform($c, $c->stash->{item});
    }



sub contentform  {
	my ( $self, $c, $item ) = @_;
#		my @field_list = &blogtags($c,$self,$item, $tag, $tagid);
		my @field_list = $item->blogtags($c);
#my @field_list;
		my @menu_items = $c->model('ClubTriumphDB::Menu')->anchorable($c->user,$item);
		my $form = ClubTriumph::Form::HTMLcontent->new(
		item => $item,
		field_list => \@field_list,
		user => $c->user,
		menu_items => \@menu_items);
        $c->stash( template => 'item/itemform.tt2', form => $form,  );
        $form->process( item => $item, params => $c->req->params); #no_update=>1
#       
		$item->update_item($c);
        return unless $form->validated;
        my ($tag,$tagid);
		if ($c->session->{last_visited}) {
			my $last = $c->session->{last_visited};
			$tag = $$last{tag};
			$tagid = $$last{tagid};
		}
#		$c->response->redirect($c->uri_for('/item', $item->id, 'newcontentedit', {mid => $c->set_status_msg("Item Edited")})); 
		if (($tag eq 'register') && $tagid) {
			$c->response->redirect($c->uri_for('/register', $tagid, 'view', {mid => $c->set_status_msg("Blog Item uploaded")}))}
		if (($tag eq 'localgroup') && $tagid) {
			$c->response->redirect($c->uri_for('/local_group', $tagid, 'view', {mid => $c->set_status_msg("Blog Item uploaded")}))}
		if (($tag eq 'event') && $tagid) {
			$c->response->redirect($c->uri_for('/event', 'id', $tagid, 'view', {mid => $c->set_status_msg("Blog Item uploaded")}))}
		if (($tag eq 'menu') && $tagid) {
			$c->response->redirect($c->uri_for('/menu', $tagid, 'view', {mid => $c->set_status_msg("Blog Item uploaded")}))}

    }

sub messageform  {
	my ( $self, $c, $item, $advanced ) = @_;
#		my @field_list = &blogtags($c,$self,$item, $tag, $tagid);
#		my @field_list = $item->blogtags($c);
#my @field_list;

        my @inactive = ('photo','more_tags','add_tag');
        if ($item->contenttype == 3) {push (@inactive,'content')}
        if ($advanced) {
			if ($item->contenttype->id == 7 || $item->contenttype->id == 6 ) {push (@inactive,'view')}   
			unless ($item->contenttype->id == 5  ) {push (@inactive,'reply')}   
			unless ($item->contenttype->id == 3  ) {push (@inactive,'licence_info','licence')} 
			unless ($c->user->access_level & 4   ) {push (@inactive, 'reply')}
		}   
        else {
			push (@inactive,'view','reply','menu_items','attachments','more_tags','add_tag')
		} 
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
#		field_list => \@field_list,
#		tags => \@field_list,
        user => $c->user,
        c => $c,
        inactive => \@inactive
		);
		my $params = $c->req->params;
		my %param = %$params;
		if ($c->req->upload) {
			my @attachments = grep {$_ =~ /^attachments/} keys %{$c->req->{uploads}}; 
			foreach my $attachment (@attachments) {
				$param{$attachment} = $c->req->upload($attachment)  if $c->req->method eq 'POST';
				my $filename = $c->req->upload($attachment)->filename;
				my $tempname = $c->req->upload($attachment)->tempname;
				my $type = $c->req->upload($attachment)->type;
				$param{$attachment.'name'} = $c->req->upload($attachment)->filename;
				$attachment =~ s/file$//;
				my $newtemp = $tempname;
				$newtemp =~ s/^\/tmp\///;
				use File::Copy;
				$param{$attachment.'tempname'} = $newtemp;
				$param{$attachment.'type'} = $type;
				copy($tempname,$c->path_to('root','static','temp').'/'.$newtemp); #create persistent temp file
				$param{$attachment.'tempname'} = $newtemp;
			}
		}
		my $newaction = $c->req->uri;
		if ($advanced) {$newaction =~ s/_adv$//}
			else {$newaction = $newaction.'_adv'}
        $c->stash( template => 'item/itemform.tt2', form => $form, advanced => $advanced, newaction => $newaction);

        $form->process( item => $item, params => \%param,  inactive => \@inactive); # no_update=>1,
#       

        return unless ($form->validated && !($c->req->params->{add_tag})); 
 # 		$item->update_item($c->req,$c);      
        my $context = $item->display_context($c->stash->{menu_item},$c->user);
#		unless ($context->viewable_by($c->user)) {
#		die ('item not viewable by user')}
		$item->link_uploaded_images($c);
		$c->response->redirect($item->view_uri($c, $context));
=cut        
        
		if ($item->contenttype->id == 2) {
			my $blogno = $c->stash->{menu_item}->viewable_item_position($c->user,$item);
			my $blogsperpage = 10;
			if ($c->stash->{blogsperpage}) {$blogsperpage = $c->stash->{blogsperpage}}
			my $pageno =  int ( ($blogno - 1) / $blogsperpage) + 1;
			my $num = $blogno - ( ( $pageno - 1 ) * $blogsperpage) ;
			$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'blog', {blogpage => $pageno, mid => $c->set_status_msg("Blog updated")}).'#num'.$num)
		}
		else {
			$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Message updated")}))
		}
=cut
}

sub replyform  {
	my ( $self, $c, $item, $recipients ) = @_;
 #      my $params = ({content => $c->req->params->{content}});
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
        user => $c->user,
		c => $c,
#		use_fields_for_input_without_param => 1,
		);
        $c->stash(  form => $form,  ); #template => 'item/itemform.tt2',
		my $posted = (($c->req->params->{submit} ne '') || ($c->req->params->{preview} ne ''));
		my $params = $c->req->params;
		my %param = %$params;
		if ($c->req->upload) {
			my @attachments = grep {$_ =~ /^attachments/} keys %{$c->req->{uploads}}; 
			foreach my $attachment (@attachments) {
				$param{$attachment} = $c->req->upload($attachment)  if $c->req->method eq 'POST';
				my $filename = $c->req->upload($attachment)->filename;
				my $tempname = $c->req->upload($attachment)->tempname;
				my $type = $c->req->upload($attachment)->type;
				$param{$attachment.'name'} = $c->req->upload($attachment)->filename;
				$attachment =~ s/file$//;
				my $newtemp = $tempname;
				$newtemp =~ s/^\/tmp\///;
				use File::Copy;
				$param{$attachment.'tempname'} = $newtemp;
				$param{$attachment.'type'} = $type;
				copy($tempname,$c->path_to('root','static','temp').'/'.$newtemp); #create persistent temp file
				$param{$attachment.'tempname'} = $newtemp;
			}
		}
		if ($item->contenttype->id == 7 ) {$form->process( item => $item, params => \%param, inactive => ['photo','view','reply','attachments','menu_items'], 
			 posted => $posted, recipients => $recipients)}
		else {$form->process( item => $item, params => \%param, inactive => ['photo','title','view','reply','menu_items','title'],  posted => $posted)}
        return unless $form->validated;
#		$item->update_item($c);
#        my $messagepage = int(scalar($item->thread->items)/10)+1;
#        $c->session(messagepage => {page => $messagepage, id => $item->thread->id});
#		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->thread->id, 'view', {mid => $c->set_status_msg("Message updated")}).'#reply')
        my $context = $item->display_context($c->stash->{menu_item},$c->user);
        
		$item->link_uploaded_images($c);
		if ($item->contenttype->id == 7) { # if pm
			$c->response->redirect($c->uri_for('/menu',$c->user->profile->pid,'user','private_messages','inbox'));
			}
		else {
			$c->response->redirect($item->view_uri($c, $context));
		}
}

sub pmreplyform  {
	my ( $self, $c, $item ) = @_;
       my $params = ({content => $c->req->params->{content}});
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
        user => $c->user,
 #       params => $params,
		c => $c
		);
        $c->stash(  form => $form, ); #template => 'item/itemform.tt2',
		my $posted = (($c->req->params->{submit} ne '') || ($c->req->params->{preview} ne ''));
        $form->process( item => $item, params => $c->req->params, inactive => ['photo'], posted => $posted);
#       
#		$item->update_item($c->req,$c);
        return unless $form->validated;
        $c->session(pmpage => {page => 1, pid => $c->stash->{menu_item}->pid});
		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'view',  {pmpage => 1, mid => $c->set_status_msg("Message $c->stash->{item}->title sent")}).'#reply')
}


sub imageedit : Chained('item') PathPart('imageedit') Args(0) {
        my ( $self, $c ) = @_;

        return $self->imageform($c, $c->stash->{item});
    }

sub imageedit_adv : Chained('item') PathPart('imageedit_adv') Args(0) {
        my ( $self, $c ) = @_;

        return $self->imageform($c, $c->stash->{item},1);
    }


sub imageform  {
        my ( $self, $c, $item, $advanced ) = @_;
		my @inactive;
		unless ($advanced)  {
			push (@inactive,'view','reply','menu_items','attachments','more_tags','add_tag')
		} 

		my $form = ClubTriumph::Form::Item->new(
		item => $item,
		user => $c->user,

		c => $c,
		inactive => \@inactive ,
		 );

        my $params = $c->req->params;
        my %param = %$params;
        $param{photo} = $c->req->upload('photo')  if $c->req->method eq 'POST';
	#	my @params = ( photo => $c->req->upload('file') ) if $c->req->method eq 'POST';
        $c->stash( template => 'item/itemform.tt2', form => $form );
        $form->process( item => $item,
        params => \%param, #no_update=>1,  
#        user => $c->user,
#         inactive => ['content']
		);
        return unless $form->validated;
		$item->update_item($c);
#		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Image updated")}))
		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'gallery', {mid => $c->set_status_msg("Image updated")}))
}

    
   sub item :Chained('/menu/base') :PathPart('item') :CaptureArgs(1) {
        my ($self, $c, $item) = @_;
		$c->stash(resultset => $c->model('ClubTriumphDB::Item'));
        unless ($item eq 'new')
        {
        $c->stash(item => $c->stash->{resultset}->find({id => $item}));

        $c->detach('/error_404') if !$c->stash->{item};
        die "Content $item not found!" if !$c->stash->{item};
		unless ($c->stash-> {item}->viewable_by($c->user)) {
			$c->response->redirect($c->uri_for( '/menu',$c->stash->{menu_item}->pid,'view'))}
			#die "Item $item not viewable!" }
		}
        # Print a message to the debug log
        $c->log->debug("*** INSIDE item METHOD for obj pid=$item ***");
    }


sub editcontent : Chained('item') PathPart('editcontent') Args(0) {
	my ( $self, $c,) = @_;
	my $id = $c->stash->{item}->id;
	my @blogs = $c->stash->{item}->registers;
	$c->stash(blogs => [@blogs]);
    my $memno = $c->user->memno->memno;
	$c->stash(cars => [$c->model('ClubTriumphDB::Register')->search({memno => $memno})]);
#	$c->stash(blogosphere => [$c->model('ClubTriumphDB::Blogosphere')->search({ item => $c->stash->{item}->id })]);
#	$c->stash(blogosphere => [$c->model('ClubTriumphDB::Blogosphere')->all]);
	if (($c->stash->{item}->contenttype->type) eq 'HTML' )
	{
       my $content  = $c->req->params ->{content};
 #       if ($content)
        {
		$c->stash->{item}->update_item( $c)
		}
        $c->stash( template => 'item/htmlform.tt2' );
	}

		if (($c->stash->{item}->contenttype->type) eq 'Text' )
	{
        my $content = $c->req->params ->{content};
        if ($content)
        {
		my $done = $c->model('ClubTriumphDB::Item')->savetextcontent($id,$content)
		}
		my %content = $c->model('ClubTriumphDB::Item')->html($c->stash->{item});
		$content{id} = $id;
		 $c->stash(  \%content );
        $c->stash( template => 'item/htmlform.tt2' );
	}
	if (($c->stash->{item}->contenttype->type) eq 'Image')
	{
        my $photo = $c->req->upload("photo");;
        if ($photo)
        {
#			my $image = $photo-> slurp;
#			my $done = $c->model('ClubTriumphDB::Item')->saveimagecontent($id,$image)
		}
#		my %content = $c->model('ClubTriumphDB::Item')->html($c->stash->{item});
#		$content{id} = $id;
#		$c->stash(  \%content );
		$c->stash->{item}->update_item($c);
        $c->stash( template => 'item/imageform.tt2' );
	}       
	return 
}

sub delete :Chained('item') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
	unless ($c->stash->{item}->editable_by($c->user)) {$c->error( "You do not have permission to delete this") }
	my $action;
	use Switch;
	switch ($c->stash->{item}->contenttype->type) {
		case 'HTML' {$action = 'blogs'}
		case 'Image' {$action = 'gallery'}
		case 'Thread' {$action = 'threads'}
		case 'PM' {$action = 'pms'}
		case 'event_diary' {$action = 'diary'}
		case 'shop' {$action = 'shop'}
		case 'Attachment' {$action = 'contentedit'}
		case 'carforsale' {$action = 'market'}
		case 'partsforsale' {$action = 'market'}
		case 'wanted' {$action = 'market'}
		case 'Message' {$action = 'item/'.$c->stash->{item}->thread->id.'/view'}
		else {$action = 'view'}
	}
    $c->stash->{item}->remove($c);
    $c->stash->{status_msg} = "Content deleted.";
	$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, $action))#, {mid => $c->set_status_msg("Content Deleted")}
}

sub threads :Chained('/menu/base') :PathPart('threads') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/threads.tt2', title2 => ' - Discussion' );
}

sub unread :Chained('/menu/base') :PathPart('unread') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/unread.tt2', title2 => ' - Discussion' );
}

sub top_ten :Chained('/menu/base') :PathPart('top_ten') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/top_ten.tt2', title2 => ' - Top Ten' );
}

sub local_threads :Chained('/menu/base') :PathPart('local_threads') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/threads.tt2', local => 1, title2 => ' - Discussion' );
}

sub forum :Chained('/menu/base') :PathPart('forum') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/forum.tt2', title2 => ' - Forum' );
}

sub messages :Chained('/menu/base') :PathPart('messages') :Args(0) {
	my ($self, $c) = @_;
	if ($c->stash->{menu_item}->menus->viewable($c->user) && 
			$c->stash->{menu_item}->current_children_rs($c->user)->viewable($c->user)->messages_viewable($c->user)->count({})) {
		$c->stash( template => 'item/forum.tt2' ) 
	}
	else {
		$c->stash( template => 'item/threads.tt2' );
	}
}

sub gallery :Chained('/menu/base') :PathPart('gallery') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/gallerymagnific.tt2', title2 => ' - gallery'  );
}

sub blog :Chained('/menu/base') :PathPart('blog') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/blogs.tt2', title2 => ' - blog'  );
}

sub market :Chained('/menu/base') :PathPart('market') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/adverts.tt2', title2 => ' - Marketplace' );
}

sub image  :Chained('item') PathPart('image') Args(1){
	my ($self, $c, $param) =@_;
	if ($c->user) {
		$c->stash->{item}->related_resultset('items_read')->find_or_create({user => $c->user->id, item => $c->stash->{item}->id})}
	$c->response->redirect($c->uri_for('/image',$param,'image'.$c->stash->{item}->id.'.'.$c->stash->{item}->extension))
}

sub shop :Chained('/menu/base') :PathPart('shop') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'shop/shop.tt2', title2 => ' - Club Shop'  );
}

sub diary :Chained('/menu/base') :PathPart('diary') :Args(0) {
	my ($self, $c) = @_;
	$c->stash( template => 'item/diary.tt2', title2 => ' - Message Diary'  );
}

sub diaryrss :Chained('/menu/base') :PathPart('diaryrss') :Args(0) {
    my ( $self, $c ) = @_;
	$c->stash(feed => $c->stash->{menu_item}->items_bytype_viewable_by(undef,14)->diaryfeed($c));
    $c->forward('View::FEED');
}


sub report : Chained('item') PathPart('report') Args(0) {
	my ($self,$c) = @_;
	return $self->reportform($c, $c->stash->{item});
}


sub reportform  {
	my ( $self, $c, $item ) = @_;
	my @field_list = $item->blogtags($c);
	my $form = ClubTriumph::Form::Report->new(
	item => $item,
	user => $c->user,
	);
	$c->stash( form => $form, $item, formtitle => 'Reporting '.$item->title  );
	$form->process( item => $item, params => $c->req->params );
	return unless $form->validated;
	$item->report($c,$c->user,$form->field('reason')->value);
	$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Your report has been submitted")}))
}

sub split : Chained('item') PathPart('split') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user->access_level <= 4) {die ('no premission')}
	my $item = $c->stash->{item};
	my $thread = $item->thread;
	my $modified = $item->modified;
	$item->update({contenttype => 5, thread => undef, title => 'split from '.$item->title});
	$item->update ({modified => $modified});
	foreach my $reply ($thread->items->search({sortby => {'>' => $item->sortby}})) {
		$modified = $reply->modified;
		$reply->update({thread => $item->id});
		$reply->update({modified => $modified});
	}
	foreach my $tag ($thread->tags) {
		$item->link_to_menu($tag,$item->author) 
	}
	$thread->update({replycount => $thread->items->count({})});
	$item->spider($c);
	$thread->spider($c);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'item',$item->id,'edit'));

}

sub merge : Chained('item') PathPart('merge') Args(0) {
	my ( $self, $c ) = @_;
	my $message;
	unless ($c->user->access_level <= 4) {die ('no permission')}
	if ($c->session->{mergewith}) {
			unless ($c->session->{mergewith} = $c->stash->{item}->id) {
			my $merge= $c->model('ClubTriumphDB::Item')->find($c->session->{mergewith});
			my $item = $c->stash->{item};
			my $modified = $merge->modified;
			$merge->update({contenttype => 6, thread => $item->id});
			$merge->update({modified => $modified});
			foreach my $reply ($merge->items) {
				$modified = $reply->modified;
				$reply->update({thread => $item->id});
				$reply->update({modified => $modified});
			}
			$item->spider($c);
		}
		$c->session->{mergewith} = 0;
	}
	else {
		$c->session(mergewith => $c->stash->{item}->id);
		$message = "now go to thread that you wish to merge with";
	} 		
#	$c->stash(template => 'menu/content.tt2');
	my $context = $c->stash->{item}->display_context($c->stash->{menu_item},$c->user);
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'item',$c->stash->{item}->id,'view',{mid => $c->set_status_msg($message)}));
	
}

sub stick : Chained('item') PathPart('stick') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user->access_level <= 4) {die ('no permission')}
	my $item = $c->stash->{item};
	my $modified = $item->modified;
	if ($item->sticky) {
		$item->update({sticky => undef});
	}
	else {
		$item->update({sticky => 1});
	}
	$item->update({modified =>$modified});
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'item',$c->stash->{item}->id,'view',{mid => $c->set_status_msg('Sticky status updated')}));
}

sub lock : Chained('item') PathPart('lock') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user->access_level <= 4) {die ('no permission')}
	my $item = $c->stash->{item};
	my $modified = $item->modified;
	if ($item->reply > 0) {
		$item->update({reply => 0});
	}
	else {
		my $reply = $item->view;
		if ($reply > 128) {$reply = 128}
		$item->update({reply => $reply});
	}
	$item->update({modified =>$modified});
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'item',$c->stash->{item}->id,'view',{mid => $c->set_status_msg('Lock status updated')}));
}


sub random_image : Chained('/menu/base') :PathPart('random_image') :Args(1) { #redirects to a random image of size specified
	my ($self,$c,$size) = @_;
	my $image = $c->stash->{menu_item}->random_item($c->user,3);
	if ($image) {
		$c->response->redirect($c->uri_for('/image',$size,'image'.$image->id.'.jpg'))
	}
	else {
		$c->response->redirect($c->uri_for('/static','images','blank.gif'));
	}
}

sub fix_sortby : Chained('item') :PathPart('fix_sortby') :Args(0) {
	my ($self,$c) = @_;
	my $item = $c->stash->{item};
	my $sortby = $item->created->epoch();
	while ($c->model('ClubTriumphDB::Item')->count({sortby =>$sortby})) {$sortby++}
	my $created = $item->created;
	$item->update ({sortby => $sortby});
	$item->update ({modified => $created});
	$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'item',$c->stash->{item}->id,'view',{mid => $c->set_status_msg('sortby fised')}));

}
	
sub new_sms :Chained('/event/event') :PathPart('new_sms1') :Args(0) {
	my ($self, $c) = @_;
	if ($c->req->params->{id}) {
		my $item = $c->model('ClubTriumphDB::Item')->find_or_create({contenttype => '14',blogref => $c->req->params->{id}});
		$item->update_sms($c);
	}
	$c->stash(template => 'email/simple_message.tt2',message => 'done');
}

sub mark_all_read :Chained('/menu/base')  :Args(0) {
	my ($self, $c) = @_;
	unless ($c->user_exists && $c->stash->{menu_item}) {$c->error('you must be logged in to use this function')}
	my $bookmark = $c->model('ClubTriumphDB::Bookmark')->find_or_create({user => $c->user->id});
	$bookmark->update({latest => $c->stash->{menu_start}->latest_item($c->user,5)->sortby});
	$c->model('ClubTriumphDB::ItemRead')->search({user => $c->user->id})->delete;
	if ($c->request->referer) {
		$c->response->redirect($c->request->referer) 
	}
	else {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'threads'))
	}
}

sub mark_all_unread :Chained('/menu/base')  :Args(0) {
	my ($self, $c) = @_;
	unless ($c->user_exists && $c->stash->{menu_item}) {$c->error('you must be logged in to use this function')}
	$c->model('ClubTriumphDB::Bookmark')->search({user => $c->user->id})->delete;
	$c->model('ClubTriumphDB::ItemRead')->search({user => $c->user->id})->delete;
	if ($c->request->referer) {
		$c->response->redirect($c->request->referer) 
	}
	else {
		$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'threads'))
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
