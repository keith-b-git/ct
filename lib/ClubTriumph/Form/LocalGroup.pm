    package ClubTriumph::Form::LocalGroup;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'localgroup' );

	has 'user' => ( is => 'rw' );
    has_field 'title';

    has_field 'organiser'=> (type => 'Select', empty_select => 'Please Select', sort_column => 'surname', element_class => 'chosen-select') ;  

    has_field 'submit' => (type => 'Submit', Value => 'Save');

sub options_organiser {
	my $self = $_[0];
	my $current = $self->item;
	return unless $self->schema;
	my @options; 
	unless ($self->user->club_officer) {push (@options, {value =>$self->user->memno->memno, label => $self->user->memno->fullname}); return @options}
	my @members = $self->schema->resultset('Member')->current_members->by_surname->all; 
	foreach my $member (@members)
	{
		{push (@options,{value =>$member->memno, label => $member->fullname })}
	}
	return @options;
}


around 'update_model' => sub {
	my $orig = shift;
	my $self = shift;
	my $item = $self->item;
	$self->schema->txn_do( sub {
		$self->$orig(@_);

	my $parent = $self->schema->resultset('Menu')->find({type => 'groupsroot'});
	my $menu_item = $self->schema->resultset('Menu')->find_or_new({parent => $parent->pid, local_group => $self->item->id});
	my $new_group = !($menu_item->in_storage);
	$menu_item->insert if ($new_group);
	$menu_item->update({
		type => 'localgroup',
		parent => $parent->pid,
		user => $self->user->id,
		heading1 => $self->item->title,
		view => 256,
		edit => 8,
		deletable => 8,
		anchor => 8,
		add_news => 8,
		add_championship => 8,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256,
		manager => 23});
	$parent->alpha_sort_children if ($new_group)
	});
};




    __PACKAGE__->meta->make_immutable;
    1;
