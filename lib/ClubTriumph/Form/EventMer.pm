    package ClubTriumph::Form::EventMer;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
	with 'ClubTriumph::Form::MerRepeatableJs';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );

	has_field 'event_merchandises'  => ( type => 'Repeatable', setup_for_js => 1,  do_wrapper => 1, tags => { controls_div => 1 }, label =>'merchandise item' );
	has_field 'event_merchandises.id' => ( type => 'PrimaryKey' );

	has_field 'event_merchandises.title' => (required =>1);
	has_field 'event_merchandises.description' => (type => 'TextArea', rows => 10, cols => 50);
	has_field 'event_merchandises.moptions' => (type => 'TextArea', rows => 5, cols => 20,
		label_attr => {title => 'Enter each option for this item on a seperate line'},
		label => 'Options, enter each option for this item on a seperate line, including null option if required');
	has_field 'event_merchandises.type' => (type => 'Select', empty_select => 'Select',
	widget => 'RadioGroup',
			options => [{value => 'entry', label => 'Per Entry'},
			{value => 'entrant', label => 'Per Entrant'}]
			);
	has_field 'event_merchandises.visible' => (type => 'Checkbox');
	has_field 'event_merchandises.rm_element' => ( type => 'RmElement', value => 'Remove Item',);
	has_field 'add_element' => ( type => 'AddElement', repeatable => 'event_merchandises',  tags => { controls_div => 1 } ,
	value => 'Add more event options',
	);

	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label', label => '');
    has_field 'submit' => (type => 'Submit', value => 'Next - edit web page content');

sub validate_event_merchandises_moptions {
	my ($self,$field) = @_;
	my $count = 0;
	my @lines = split(/\n/,$field->value);
	while (my $line = <@lines>) {
		if ($line =~ /\S+/) {$count++}
	}
	if ($count < 2) {
		$field->add_error('You meust enter at least two options for this item')
	}
	else {
		return 1
	}
}


    __PACKAGE__->meta->make_immutable;
    1;
