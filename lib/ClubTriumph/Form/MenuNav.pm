    package ClubTriumph::Form::MenuNav;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
#    has_field 'heading1';
#    has_field 'heading2';


	has_field 'parent' => ( type => 'Select', label_column => 'select_active',
	empty_select => '---Select---',  element_class => 'chosen-select');  

 
 
	has_field 'submit' => (type => 'Submit', label=>'Move', value => 'Move');
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
		-or => [anchor => {'&' => $access_level},
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

around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
    if ($self->old_parent) {
		if ($self -> item-> parent->id != $self->old_parent->id )
			{
				$self->old_parent->order_children;
				$self->item->make_last;
=cot
				my @lnks = $self->item->descendants->related_resultset('blog_menus')->search({ancs => undef});
				foreach my $itm  (@lnks) {
					$itm->set_ancestor_links;
				}
				my @types = $item->items->search({},{group_by => 'contenttype'});
				foreach my $type (@types) {
					my $level = 1;
					while ($level < 1024) {
						$self->old_parent->count_items($type->contenttype->id,$level);
						$item->parent->count_items($type->contenttype->id,$level);
						if ($type->contenttype->id == 5) {
							$self->old_parent->count_items(6,$level);
							$item->parent->count_items(6,$level);
						}
						$level = $level * 2;
					}
				}
=cut
			}
		}
	else
	{$self->item->make_last}

	});
};


    __PACKAGE__->meta->make_immutable;
    1;
