    package ClubTriumph::Form::BlogFeed;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	
	has '+item_class' => ( default =>'member' );
#	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'blog_feed';

    has_field 'submit' => (type => 'Submit', Value => 'Save');


    __PACKAGE__->meta->make_immutable;
    1;
