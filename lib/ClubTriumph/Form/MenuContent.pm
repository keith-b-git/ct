    package ClubTriumph::Form::MenuContent;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
	has '+enctype' => ( default => 'multipart/form-data');
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
    has 'user' => ( is => 'ro');
    has_field 'heading1' => (label => 'title', required => 1);



		
	has_field 'content' => ( type => 'TextArea', rows => 5, cols => 75, id => 'elm1', label => '') ;
    has_field 'view' => (type => 'Select', label => 'Viewable by- ', widget => 'RadioGroup');
    has_field 'photo' => ( type => 'Upload', noupdate =>1, max_size => '25000000', min_size =>100, 
		element_attr => { multiple => "multiple"}, #accept => "image/*",
		label => 'attach image(s) or file(s) (use CTRL key to select multiple)') ; 
    has_field 'licence_info' => (type => 'Display', html => 'You can choose a <A href = "https://creativecommons.org/share-your-work/" target = "_blank">Creative Common Licence</a> to share your image(s)');

    has_field 'licence' => (type => 'Select', label => 'Licence- ', label_attr => {title => 'Choose a Creative Commons licence to be applied to your image(s)'}); #, widget => 'RadioGroup',

	has_field 'upload' => (type => 'Submit', value => 'Upload attachment(s) and continue editing');
	has_field 'submit' => (type => 'Submit', value => 'Save');
	
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
		]
}

sub default_licence {
	my $self = $_[0];
	return $self->user->licence
}

sub options_view {
	my $self = $_[0];
	return $self->item->access_options($self->user,511, $self->item->view);
}

around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	$self->schema->txn_do( sub {
		$self->$orig(@_);
		my $n = 0;
		foreach my $upload ( $c->request->upload('photo')) { 
			if ($upload->size) { 
				my $type = 4;
				if ($upload->type =~ /^image/) {$type = 3}
				my $sibling = $c->model('ClubTriumphDB::Item')->new_result({
					title => $upload->filename,
					contenttype => $type,
					view => $item->view,
					author => $c->user->id,
				});
				$sibling->insert;
				$sibling->discard_changes;
				if ($type == 3) {
					$sibling->add_image_to_item($upload)
				}
				else {
					$sibling->add_file_to_item($upload)
				}
				$sibling->link_to_menu($item);

			}
		$n++;
		}

#
	});
	
};


    __PACKAGE__->meta->make_immutable;
    1;
