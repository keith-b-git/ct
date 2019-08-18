    package ClubTriumph::Form::ImageContent;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    use namespace::autoclean;
	has '+enctype' => ( default => 'multipart/form-data');
    has '+item_class' => ( default =>'item' );
    has_field 'title';
    has_field 'heading1';
    has_field 'heading2'; 
    has_field 'status' => ( type => 'Select',label_column => 'status' );  
    has_field 'photo' => ( type => 'Upload', noupdate =>1, max_size => '2000000') ;
	has_field 'submit' => (type => 'Submit');
	has 'user_id' => ( isa => 'Int', is => 'rw' );


    __PACKAGE__->meta->make_immutable;
    1;
