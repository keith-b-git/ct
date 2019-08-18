    package ClubTriumph::Form::EventEmail;

    use HTML::FormHandler::Moose;

#	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;


	has_field 'subject' => (required => 1);
	has_field 'from' => (required => 1);
	has_field 'content' => ( type => 'TextArea', rows => 5, cols => 75, id => 'elm1', required => 1) ;
 
    has_field 'submit' => (type => 'Submit', Value => 'Next - edit web page content');



    __PACKAGE__->meta->make_immutable;
    1;
