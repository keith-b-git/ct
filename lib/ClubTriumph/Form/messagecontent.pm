    package ClubTriumph::Form::messagecontent;

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

	has_field 'submit' => (type => 'Submit', order => 99);

	


	
    __PACKAGE__->meta->make_immutable;
    1;
