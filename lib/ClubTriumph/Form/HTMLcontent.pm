    package ClubTriumph::Form::HTMLcontent;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
    has_field 'title';
    has_field 'heading1';
    has_field 'heading2';
#    has_field 'contenttype' => ( type => 'Select',label_column => 'type',
#       empty_select => '---Select---' );   
    has_field 'status' => ( type => 'Select',label_column => 'status');  
    has_field 'content' => ( type => 'TextArea', rows => 50, cols => 100, id => 'elm1') ;
    has_field 'parent' => ( type => 'Select', empty_select => 'None ---'); 
	has_field 'submit' => (type => 'Submit', order => 99);
	has 'menu_items' => (is => 'rw');
	
sub options_parent {
	my $self = $_[0];
	my @parents;
	foreach my $menu_item (@{$self ->menu_items})
	{
		push(@parents,{value => $menu_item->pid, label => $menu_item -> title});
	}
	return @parents
}
sub default_parent {
	my ( $self, $field, $item ) = @_;
	if ($self->item->menus > 0) {
		my @menu_items = $self-> item-> menus ;
		return $menu_items[0]->parent->pid
	}
}
	
    __PACKAGE__->meta->make_immutable;
    1;
