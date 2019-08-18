    package ClubTriumph::Form::Content;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    use namespace::autoclean;

    has '+item_class' => ( default =>'content' );
    has_field 'pagetitle';
    has_field 'heading1';
    has_field 'heading2';
    has_field 'pagetype' => ( type => 'Select',  label_column => 'pid',
        empty_select => '---Select---' );   
    has_field 'rewrite';
    has_field 'width' => ( type => 'Integer' );   
    has_field 'height' => ( type => 'Integer' );
    has_field 'alignment';
#    has_field 'parent' => ( type => 'Select',  label_column => 'pid' );
    has_field 'submit' => ( type => 'Submit', value => 'Submit' );
#   sub options_parent {
#				my ($self, $c) =@_;
#	          my $pids = $c->model('ClubTriumphDB::Content')->get_column('pid');
#	         return $pids;
	   
#	}
  
   sub options_pagetype {
       return (
           'manhtml'   => 'HTML',
           'mantext'   => 'Text',
           'manimage'   => 'Image',
       );
   }

    __PACKAGE__->meta->make_immutable;
    1;
