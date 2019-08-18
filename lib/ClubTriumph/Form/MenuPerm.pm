    package ClubTriumph::Form::MenuPerm;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );

	my $access_options = [
		{value => '0', label => 'None'},
		{value => '1', label => 'Owner'},
		{value => '2', label => 'Administrator'},
		{value => '4', label => 'Moderator'},
		{value => '8', label => 'Manager'},
#		{value => '16', label => 'Competitions Officer'},
		{value => '16', label => 'Club Officer'},
		{value => '32', label => 'Entrant/Member'},
		{value => '64', label => 'Club Member'},
		{value => '128', label => 'Guest User'},
		{value => '256', label => 'All'}
		];
		
	has_field 'view' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'edit' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'deletable' => (type => 'Select', label => 'Delete', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'anchor' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'view_blogs' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_blog' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'view_images' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_image' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'view_messages' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_message' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_event' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_advert' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'view_adverts' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_news' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_shop' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'add_championship' => (type => 'Select', multiple => 1, inflate_default_method => \&inflate_perms, deflate_value_method => \&deflate_perms, widget => 'CheckboxGroup');
	has_field 'manager' => (type => 'Select', label_column => 'description', empty_select => 'optional');
	has_field 'linked_role' => (type => 'Select', label_column => 'description', empty_select => 'optional');
	has_field 'user' => ( deflate_method => \&deflate_user);;
	has_field 'submit' => (type => 'Submit');
	has 'old_parent' => (  is => 'rw' );
	has 'user' => (  is => 'rw' );
 


sub options_parent {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->schema;
	my $access_level = $self->user->access_level;
	my @pids;
	my $parent = 0;
	if ($current->parent) {$parent = $current->parent->pid}
	if ($current->parent && $current->parent->anchor) {
		@pids = $self->schema->resultset('Menu')->search({
		-or => [anchor => {'>=' => $access_level},
		-and => [anchor => 1, user => $self->user->id],
		pid => $parent]})
	}
	elsif ($current->parent) {
		@pids = ($current->parent)
	}
	my @options; 
	my %desc = map { $_ => 1 } $current->descendants->get_column('pid')->all;
	foreach my $pid (@pids)
	{
		unless (exists($desc{$pid->pid}))
		{push (@options,{value =>$pid->pid, label => $pid->title })}
	}
	return @options;
}

sub options_view {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,511, $view)
}

sub options_edit {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_deletable {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_anchor {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_view_blogs {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,256, $view)
}

sub options_add_blog {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_view_images {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,511, $view)
}

sub options_add_image {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_view_messages {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,511, $view)
}

sub options_add_message {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,255, $view)
}

sub options_add_event {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,127, $view)
}

sub options_view_adverts {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,511, $view)
}

sub options_add_advert {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,255, $view)
}

sub options_add_news {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,255, $view)
}

sub options_add_shop {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,255, $view)
}

sub options_add_championship {
	my $self = $_[0];
	my $view = 511;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,255, $view)
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

sub validate_user {
	my ($self,$field) = @_;
	my $user = $self->item->result_source->schema->resultset('User')->find({username => $field->value});
	unless ($user) {$field->add_error('User '.$field->value.' not found'); return 0}
	$field->value($user->id)
}



sub deflate_user {
	my ($self,$value) = @_;
	return unless ($self->form->item->user);
	return $self->form->item->user->username;
}

before 'update_model' => sub {
	my $self = shift;
	foreach my $field ($self->fields) {
		if (ref $field->value eq 'ARRAY')  {$self->values->{$field->name}=0} 
	}

};

    __PACKAGE__->meta->make_immutable;
    1;
