    package ClubTriumph::Form::Order;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
	
	has '+item_class' => ( default =>'member' );
#	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'title' => (label_class => 'form_label');
	has_field 'forename' => (required => 1, label_class => 'form_label');
	has_field 'surname' => (required => 1, label_class => 'form_label');

    has_field 'address1' => (required => 1, label_class => 'form_label');
    has_field 'address2' => (label_class => 'form_label');
    has_field 'address3' => (label_class => 'form_label');
    has_field 'address4' => (label => 'Town', label_class => 'form_label');
    has_field 'address5' => (label => 'County', label_class => 'form_label');
    has_field 'postcode' => (required => 1, label_class => 'form_label');
	has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select', label_class => 'form_label');
    has_field 'tel' => (label_class => 'form_label');
    has_field 'email' => (required => 1, label_class => 'form_label');
    has_field 'terms' => (type => 'Display', html => 'You must read and accept our <a href = "/static/docs/Terms_and_Conditions.pdf">terms and conditions</a> of sale', label => '', label_class => 'form_label');
    has_field 'tandcs' => (type => 'Checkbox', required => 1, label => 'Terms and conditions read and accepted', label_class => 'form_label'); 
    has_field 'submit' => (type => 'Submit', value => 'Continue', label_class => 'form_label', label => '');

sub options_country {
	my $self = $_[0];
	my @options;
	foreach my $country (code2)
	{
		if (country($country,CNT_F_REGULAR))
		{push (@options,{value =>$country, label => scalar(country($country))})}
	}
	my @sortedoptions = sort {$a->{label} cmp $b->{label}} @options;
	return @sortedoptions;
}
    __PACKAGE__->meta->make_immutable;
    1;
