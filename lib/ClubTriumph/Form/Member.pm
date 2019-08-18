    package ClubTriumph::Form::Member;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;
	use Geography::Countries qw/country code2 CNT_F_REGULAR/;
	
	has '+item_class' => ( default =>'member' );
#	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'title';
	has_field 'forename';
	has_field 'surname';

    has_field 'address1' => (required => 1);
    has_field 'address2';
    has_field 'address3';
    has_field 'address4' => (label => 'Town');
    has_field 'address5' => (label => 'County');
    has_field 'postcode' => (required => 1);
	has_field 'country' => (type =>'Select', required => 1, empty_select => 'Please Select', element_class => 'chosen-select');
    has_field 'tel';
    has_field 'mobile';
    has_field 'email';
    has_field 'submit' => (type => 'Submit', Value => 'Save');

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

sub validate_tel {
	my ($self,$field) = @_;
	use Phone::Number;
	my $num = new Phone::Number($field->value);
	if ($num) {
		$field->value($num->formatted);
	}
	else {
		$field->add_error('Invalid phone number')
	}
}

sub validate_mobile {
	my ($self,$field) = @_;
	use Phone::Number;
	my $num = new Phone::Number($field->value);
	if ($num) {
		$field->value($num->formatted);
	}
	else {
		$field->add_error('Invalid phone number')
	}
}
    __PACKAGE__->meta->make_immutable;
    1;
