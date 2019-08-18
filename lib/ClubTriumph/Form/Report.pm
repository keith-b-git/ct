    package ClubTriumph::Form::Report;
    use HTML::FormHandler::Moose;
	extends 'HTML::FormHandler';

    use namespace::autoclean;


	has 'user' => (  is => 'rw' );



    has_field 'reason' => (type => 'TextArea', rows => 5, cols => 75, required => 1, label_attr => {title => 'Please explain why you think this item breaks the website rules'} );

    
    has_field 'submit' => (type => 'Submit', value => 'Send Report');






    __PACKAGE__->meta->make_immutable;
    1;
