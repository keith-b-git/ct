    package ClubTriumph::Form::MenuImport;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
    has_field 'heading1' => (label => 'title');
    has_field 'oldforum' => (label => 'Old forum import board');
    has_field 'image_import_dir' => (label => 'Image import dir');
	has_field 'import_start' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy");
	has_field 'import_end'  =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy");

		
  

	has_field 'submit' => (type => 'Submit');
=cut
before 'update_model' => sub {
	my $self = shift;
	my $content = $self->field('content')->value;
	$content =~ s/mapblock start/ mapblockxxx /;
	$self->field('content')->value( $content);

};
=cut



    __PACKAGE__->meta->make_immutable;
    1;
