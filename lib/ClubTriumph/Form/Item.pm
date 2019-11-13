    package ClubTriumph::Form::Item;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::RepeatableJs';
	with 'ClubTriumph::Form::AttachmentRepeatableJs';
    use namespace::autoclean;
	has '+enctype' => ( default => 'multipart/form-data');
    has '+item_class' => ( default =>'item' );
#    has 'tags' => (is => 'rw');
	has 'user' => ( is => 'ro');
	has 'c' => ( is => 'ro');
	has 'recipients' => (is => 'rw');
    has_field 'title' => ( size =>'50');
    has_field 'recipients' => (type => 'TextArea', rows => 5, cols => 20, label => 'Recipients - enter the username of each person on a seperate line');
    has_field 'price';
    has_field 'pandp';
    has_field 'price_text';   
	has_field 'sizes'  => ( type => 'TextArea', rows => 5, cols => 20);
	
	has_field 'start_date' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy");
	has_field 'end_date' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy");

    
     
    
#    has_field 'heading1';
#   has_field 'heading2';
	has_field 'contenttype' => ( type => 'Hidden');
    has_field 'photo' => ( type => 'Upload', noupdate =>1, max_size => '25000000', min_size =>1000, element_attr => {accept => "image/*", multiple => "multiple"}, #, capture=> "camera"
			label => 'Image (use CTRL key to select multiple images)') ; 
    has_field 'content' => ( type => 'TextArea', rows => 5, cols => 75, id => 'elm1', label => '') ;
    has_field 'view' => (type => 'Select', label => 'Viewable by- ', widget => 'RadioGroup');
    has_field 'reply' => (type => 'Select', label => 'Replyable by- ' ,   widget => 'RadioGroup');
    has_field 'licence_info' => (type => 'Display', html => 'You can choose a <A href = "https://creativecommons.org/share-your-work/" target = "_blank">Creative Common Licence</a> to share your work');
    has_field 'licence' => (type => 'Select', label => 'Licence- '); #, widget => 'RadioGroup',
	has_field 'preview' => (type => 'Submit', value => 'Preview');
	has_field 'latitude';
	has_field 'longitude';
	has_field 'menu_items' => (type => 'Select', multiple => 1, label => 'tags', widget => 'CheckboxGroup', label_column => 'title', inflate_default_method => \&inflate_menu_items);
	has_field 'more_tags' => (type => 'Select', element_class =>'chosen-select', element_attr => {onChange =>'addTag();'},
		empty_select => 'find more tags');
	has_field 'add_tag' => (type => 'Submit', value => 'Add tag');
	has_field 'attachments'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>"Attach a file ",
		num_when_empty => 0, label_class => 'form_label', accessor => 'items_attachments', noupdate =>1,); 
		has_field 'attachments.id' => ( type => 'PrimaryKey' );
		has_field 'attachments.title';
		has_field 'attachments.preview' => (type => 'Display');
		has_field 'attachments.file' => ( type => 'Upload', no_update =>1, max_size => '500000000', min_size =>100, required => 0, );
		has_field 'attachments.rm_element' => ( type => 'RmElement', value => 'Remove Attachment',);
		has_field 'attachments.filename' => (type => 'Hidden');
		has_field 'attachments.tempname' => (type => 'Hidden');
		has_field 'attachments.type' => (type => 'Hidden');
		has_field 'attachments.licence_info' => (type => 'Display', 
			html => '<br clear = "all">You can choose a <A href = "https://creativecommons.org/share-your-work/" target = "_blank">Creative Common Licence</a> to share your work');
		has_field 'attachments.licence' => (type => 'Select', label => 'Licence- ', options_method => \&options_licence, label_attr => {title => 'Choose a Creative Commons licence to be applied to your content'}); #, widget => 'RadioGroup',

	has_field 'add_element' => ( type => 'AddElement', label => 'add attachment', repeatable => 'attachments',  tags => { controls_div => 1 } ,
	value => 'Click to attach a file', label_class => 'form_label'
	);
	has_field 'submit' => (type => 'Submit', value => 'Post');
	has_field 'upload' => (type => 'Submit', value => 'Upload attachment and continue editing');

	
	
sub options_menu_items {
	my $self = $_[0];
	return $self->item->blogtags($self->c);
}

sub inflate_menu_items {
	my ($self,$value) = @_;
	if ($value) {
		return $self->form->item->menu_items;
		}
		else {
		my @pages = ($self->form->c->stash->{menu_item}->pid);
		return @pages;
	}
}
	
sub options_view {
	my $self = $_[0];
	return $self->c->stash->{menu_item}->access_options($self->user,511, $self->c->stash->{menu_item}->view);
}

sub options_reply {
	my $self = $_[0];
	my @options = ({value => 0, label => 'locked'});
	my $opts =  $self->c->stash->{menu_item}->access_options($self->user,255, $self->c->stash->{menu_item}->view);
	push (@options, @$opts );
	return @options;
}

sub options_more_tags {
	my $self = shift;
	my @menu_items;
	if ($self->item->contenttype->id == 5 ) {
		@menu_items = $self->user->result_source->schema->resultset('Menu')->messages_addable($self->user);
	}
	if ($self->item->contenttype->type eq 'Image') {
		@menu_items = $self->user->result_source->schema->resultset('Menu')->images_addable($self->user);
	}
	if ($self->item->contenttype->type eq 'HTML') {
		@menu_items = $self->user->result_source->schema->resultset('Menu')->blogs_addable($self->user);
	}
	if ($self->item->contenttype->id == 8) { # shop
		@menu_items = $self->user->result_source->schema->resultset('Menu')->shop_addable($self->user);
	}
	if ($self->item->contenttype->id == 12) { # news
		@menu_items = $self->user->result_source->schema->resultset('Menu')->news_addable($self->user);
	}
	my @options;
	foreach my $menu_item (@menu_items) {
		push (@options, {value => $menu_item->pid, label => $menu_item->heading1});
	}
	return @options;
}

sub options_licence {
	my $self = shift;
	return [
		{label => 'Attribution', value => 'CC BY'},
		{label => 'Attribution ShareAlike', value => 'CC BY-SA'},
		{label => 'Attribution-NoDerivs', value => 'CC BY-ND'},
		{label => 'Attribution-NonCommercial', value => 'CC BY-NC'},
		{label => 'Attribution-NonCommercial-ShareAlike', value => 'CC BY-NC-SA'},
		{label => 'Attribution-NonCommercial-NoDerivs', value => 'CC BY-NC-ND'},
		{label => 'All Rights Reserved', value => 'reserved'},
		{label => 'Public Domain', value => 'public'},
		{label => 'Other', value => 'other'},
		]
}

sub default_attachments_licence {
	my $self = $_[0];
	return $self->user->licence
}

sub default_recipients {
	my $self = $_[0];
	if ($self->recipients) {
		return $self->recipients
	}
}
	
sub validate {
	my $self = $_[0];
	return 1 if ($self->field('add_tag')->is_active && $self->field('add_tag')->input);
	unless ($self->field('content')->value || ($self->item->contenttype->type eq 'Image') || ($self->item->contenttype->type eq 'shop')) {$self->field('content')->add_error('You must enter some content for this item')}
	unless ($self->field('title')->value ||  ($self->item->contenttype->id == 6) || ($self->item->contenttype->type eq 'Image')) {$self->field('title')->add_error('You must add a title for this item')}
	unless (($self->item->contenttype->type ne 'Image') || $self->field('photo')->value || $self->item->image_exists) {$self->field('photo')->add_error('You must select an image to upload')}
	if ($self->item->contenttype->type eq 'PM') {
		unless ($self->field('recipients')->value) {$self->field('recipients')->add_error ('you must enter a recipient')}
		my @recipients = split(/\n/,$self->field('recipients')->value);
		foreach my $recipient (@recipients) {
			$recipient =~ s/[\000-\037]//g;
			unless ($self->schema->resultset('User')->find({username => $recipient})) {$self->field('recipients')->add_error ("recipient $recipient not found")}
		}
#		$self->item->userpms = [$self->schema->resultset('User')->find({username => $self->field('recipients')->value})]
	}
	if ($self->field('preview')->input) {$self->field('preview')->add_error ('previewed')}
	if ($self->field('upload')->input) {$self->field('upload')->add_error ('uploaded')}
	return 1 if (($self->item->contenttype->id == 6)||($self->item->contenttype->id == 7)); 
	if ($self->field('menu_items')->is_active) {
		my $menus = $self->field('menu_items')->value;
		unless (scalar @$menus) {
			$self->field('menu_items')->value(($self->c->stash->{menu_item}->pid))
		}
		foreach my  $menu_pid (@$menus) {
			$self->c->log->debug('^^^^^^^^^^^^^^^^^^^'.$menu_pid);
			my $menu_item = $self->c->model('ClubTriumphDB::Menu')->find({pid => $menu_pid});
			if ($menu_item) {
				if (($self->item->contenttype->type eq 'Image') && !($menu_item->images_addable_by($self->user))) {
					$self->field('menu_items')->add_error('not permitted')}
				if (($self->item->contenttype->type eq 'Thread') && !($menu_item->messages_addable_by($self->user))) {
					$self->field('menu_items')->add_error('not permitted')}
				if (($self->item->contenttype->type eq 'HTML') && !($menu_item->find($1)->blogs_addable_by($self->user))) {
					$self->field('menu_items')->add_error('not permitted')}
			}
		}
	}
	
=cut
	my $found;
	my $first;
	foreach my $field ($self->sorted_fields) {
		if (($field->name =~ /^menu_(\d*)$/) && $field->value) {
			if (($self->item->contenttype->type eq 'Image') && !($self->schema->resultset('Menu')->find($1)->images_addable_by($self->user))) {
				$field->add_error('not permitted')}
			if (($self->item->contenttype->type eq 'Thread') && !($self->schema->resultset('Menu')->find($1)->messages_addable_by($self->user))) {
				$field->add_error('not permitted')}
			if (($self->item->contenttype->type eq 'HTML') && !($self->schema->resultset('Menu')->find($1)->blogs_addable_by($self->user))) {
				$field->add_error('not permitted')}
			$found++}
		if (($field->name =~ /^menu_/) && !$first) {$first = $field}
	}
	
	my $tagfound =0;

	foreach my $param (keys %{$self->params}) {
		if (($param =~ /^menu_(\d*)$/) && $self->params->{$param}) {
			$tagfound ++;
		}
	}
#	unless ($tagfound) {$first->add_error('You must select at least one tag'); return 0}
	my $maxtags = $self->user->maxtags;
#	if ($tagfound > $maxtags) {$first->add_error("You can't select more than $maxtags tags for this item"); return 0}
=cut

	return 1;
}



sub html_attachments_preview {
	my ($self, $field) = @_;
	my $id=$field->parent->field('id')->value;
	if ($field->parent->field('filename')->value) {
		my $text =  '<a href = "'.$field->form->c->uri_for('/static','temp',$field->parent->field('tempname')->value).'">'.$field->parent->field('filename')->value.'</a>';
		if ($field->parent->field('type')->value =~ /^image/) {
			$text .= '<br><img src = "'.$field->form->c->uri_for('/static','temp',$field->parent->field('tempname')->value).'" height = "200">';
		}
		return '<div>'.$text.'</div>';
	}
	my $item = $field->form->item->items_attachments->find({id => $id});
	if ($item) {
		my $text =  '<a href = "'.$item->download_uri($field->form->c).'">'.$item->title.'</a>';
		if ($item->contenttype->id == 3) {
			$text .= '<br><img src = "'.$item->display_uri($field->form->c,'h-200').'">';
		}
		return '<div>'.$text.'</div>';
	}
}

sub inflate_perms {
	my ($self,$value) = @_; 
	my @values = (0);
	if ($value) {
		my $testvalue = 512;
		while ($testvalue >= 1) {
			if ($value & $testvalue ) {
				push ( @values, $testvalue);
			} 
		$testvalue = $testvalue >> 1;
		}
	return @values;
	}
	
}

sub deflate_perms {
	my ($self, $values) = @_;
	my $result = 0;
	foreach my $value (@$values) {
		$result += $value
	}
	return $result;
}

before 'update_model' => sub {
	my $self = shift;
	foreach my $field ($self->field('view'), $self->field('reply')) {
		if ($field->is_active && ref $field->value eq 'ARRAY')  {$self->values->{$field->name}=0} 
	}
	$self->values->{'content'} = substr($self->values->{'content'},0,9999);
};

after 'update_model' => sub {
	my $self = shift;
	$self->item->update_item($self->c);
	unless ($self->item->menu_items->count({})) {$self->item->link_to_menu($self->c->stash->{menu_item})}
};



    __PACKAGE__->meta->make_immutable;
    1;
