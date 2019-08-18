    package ClubTriumph::Form::basket;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
#	with 'HTML::FormHandler::Render::Table';
	
	use namespace::autoclean;
	
	has '+item_class' => ( default =>'item' );
	

	
	has_field 'baskets'  => ( type => 'Repeatable'); #num_when_empty => 2,
	has_field 'baskets.id' => ( type => 'PrimaryKey' );

	
	has_field 'baskets.quantity' => (do_wrapper => 0);

	has_field 'submit' => (type => 'Submit', Value => 'Update');
	
	
	
   __PACKAGE__->meta->make_immutable;
    1;

