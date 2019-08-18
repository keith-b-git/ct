    package ClubTriumph::Form::Menu;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
    has_field 'title';
    has_field 'heading1';
    has_field 'heading2';


	has_field 'parent' => ( type => 'Select', label_column => 'select_active',
	empty_select => '---Select---');  
#	has_field 'type' => (type => 'Select',	
#	options => [
#	{value => 'item', label => 'Item'},
#	{value => 'menuonly', label => 'Menu only'},
#	{value => 'link', label => 'Link'},
#	{value => 'eventroot', label => 'Event Root'},
#	{value => 'groupsroot', label => 'Local Groups Root'},
#	{value => 'profileroot', label => 'Profile Root'},
#	{value => 'carsroot', label => 'Cars Root'},
#	{value => 'event', label => 'Event'}
#	]);
#	has_field 'item' => ( type => 'Select',label_column => 'heading1',
#	empty_select => '---Select---' );  

		
	has_field 'content' => ( type => 'TextArea', rows => 5, cols => 75, id => 'elm1', label => '') ;
	    
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
		
	has_field 'view' => (type => 'Select');
	has_field 'edit' => (type => 'Select');
	has_field 'anchor' => (type => 'Select');
	has_field 'view_blogs' => (type => 'Select');
	has_field 'add_blog' => (type => 'Select');
	has_field 'view_images' => (type => 'Select');
	has_field 'add_image' => (type => 'Select');
	has_field 'view_messages' => (type => 'Select');
	has_field 'add_message' => (type => 'Select');
	has_field 'add_event' => (type => 'Select');

	has_field 'link';
 
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
	return $self->item->access_options($self->user,256, $view)
}

sub options_edit {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,64, $view)
}

sub options_anchor {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,64, $view)
}

sub options_view_blogs {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,256, $view)
}

sub options_add_blog {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,64, $view)
}

sub options_view_images {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,256, $view)
}

sub options_add_image {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,64, $view)
}

sub options_view_messages {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,256, $view)
}

sub options_add_message {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,128, $view)
}

sub options_add_event {
	my $self = $_[0];
	my $view = 256;
	if ($self->item->parent) {$view = $self->item->parent->view} 
	return $self->item->access_options($self->user,64, $view)
}

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
    if ($self->old_parent) {
		if ($self -> item-> parent->id != $self->old_parent->id)
			{
				$self->old_parent->order_children;
				$self->item->make_last;
			}
		}
	else
	{$self->item->make_last}
	unless ($self->item->menu_order) {$self->item->make_last}
	});
};


    __PACKAGE__->meta->make_immutable;
    1;
