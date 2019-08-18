    package ClubTriumph::Form::Card;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;
	



	has_field 'card_number' => (required => 1, label_class => 'form_label');
	has_field 'expiry_month' => (type => 'MonthName', required => 1, label_class => 'form_label');
	has_field 'expiry_year' => (type => 'IntRange', range_start => (localtime)[5] + 1900, range_end => (localtime)[5] + 1910, required => 1, label_class => 'form_label');

    has_field 'cvm' => (required => 1, label_class => 'form_label', label => 'last 3 digits on signature strip on rear of card');
    has_field 'submit' => (type => 'Submit', value => 'Place Order', label_class => 'form_label', label => '');


    __PACKAGE__->meta->make_immutable;
    1;
