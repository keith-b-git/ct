    package ClubTriumph::Form::MemberGroup;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'member' );
#	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has 'lg_preference' => ( isa => 'Int', is => 'rw' );
    has_field 'local_group' => (type => 'Select', label_column => 'title', element_class => 'chosen-select', empty_select => 'Select Group',
     element_attr => {onChange =>'showSelected();'});#, sort_column => 'distance->value'
 
    has_field 'submit' => (type => 'Submit', Value => 'Save');

sub sort_options_local_group {
	my ($self,@options) =@_;
	return sort  {$a cmp $b} @options
}

around 'update_model' => sub { # update ASS members if main changes
	my $orig = shift;
	my $self = shift;
	$self->item->lg_preference($self->form->field('local_group')->value);
	$self->$orig(@_);
	if ($self->item->members) {
		foreach my $member ($self->item->members) {
			$member->update({local_group => $self->item->local_group});
		}
	}
};

    __PACKAGE__->meta->make_immutable;
    1;
