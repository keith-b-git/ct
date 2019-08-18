    package ClubTriumph::Form::HTMLcontent;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    use namespace::autoclean;

    has '+item_class' => ( default =>'item' );
    has_field 'title';
    has_field 'heading1';
    has_field 'heading2';
    has_field 'contenttype' => ( type => 'Select',label_column => 'type',
        empty_select => '---Select---' );   
 #   has_field 'status' => ( type => 'Select',label_column => 'status',
 #       empty_select => '---Select---' );  
    has_field 'registers' => (type => 'Select',multiple => 1,label_column => registers -> regno);
    has_field 'content' => ( type => 'textarea');
	has_field 'submit' => (type => 'Submit');
	


    __PACKAGE__->meta->make_immutable;
    1;
