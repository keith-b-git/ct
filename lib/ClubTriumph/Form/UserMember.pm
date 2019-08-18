    package ClubTriumph::Form::UserMember;
    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
    use namespace::autoclean;

	has '+item_class' => ( default =>'user' );
	has_field 'membership_no' => (required => 1, label_class => 'form_label');
#    has_field 'email' => (required => 1, label_class => 'form_label');
    has_field 'forename' => (required => 1, label_class => 'form_label');
    has_field 'surname' => (required => 1, label_class => 'form_label');
    has_field 'address1' => (required => 1, label => '1st Line of address');
    has_field 'town' => (required => 1, label_class => 'form_label');
    has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select', label_class => 'form_label');
	has_field 'postcode' => (required => 1, label_class => 'form_label');

    has_field 'submit' => (type => 'Submit', Value => 'Next', label_class => 'form_label');

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
