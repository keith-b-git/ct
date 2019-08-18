    package ClubTriumph::Form::EntryEmail;

    use HTML::FormHandler::Moose;
	extends 'HTML::FormHandler';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;


	has_field 'subject' => (required => 1);
	has_field 'from' => (required => 1);
	has_field 'character_count' => (type => 'Display', html => '<span id="charNum">0/160</span>', id => 'charNum');
	has_field 'content' => ( type => 'TextArea', rows => 10, cols => 75, id => 'elm1', required => 1) ;
 
    has_field 'submit' => (type => 'Submit', value => 'Send');



    __PACKAGE__->meta->make_immutable;
    1;
