    package ClubTriumph::Form::GroupMeeting;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'groupmeeting' );


	has 'user_id' => ( isa => 'Int', is => 'rw' );
    has_field 'local_group'=> (type => 'Hidden') ; 
    has_field 'location'  => (type => 'Select', 
    empty_select => '---Select---', 
    label_column => 'name_town',
    element_attr => {onChange =>'showSelected();'}, element_class => 'chosen-select');

    has_field 'week_of_month' => (type => 'Select',
    options => [
		{value => 99, label => 'select'},
		{value => 0, label => 'first'},
		{value => 1, label => 'second'},
		{value => 2, label => 'third'},
		{value => 3, label => 'fourth'},
		{value => 4, label => 'last'} ]);
    has_field 'day_of_week' => (type => 'Weekday') ;
    has_field 'frequency' => (type => 'Select',
    options => [
		{value => 'monthly', label => 'every month'},
		{value => 'even', label => 'even months'},
		{value => 'odd', label => 'odd months'} ]);
	has_field 'time' => (type => 'Select');

 

    has_field 'submit' => (type => 'Submit', value => 'Save');
    has_field 'new_location' =>(type => 'Display', html => 'Or - if location doesn\'t exist in gazetteer -');
    has_field 'new_loc' => (type => 'Submit', value => 'Create New Location');

sub options_time
{
my @options;
my $hour = 12;
while ($hour < 24)
	{
		push (@options,{value => "$hour:00:00",label => "$hour:00"});
		push (@options,{value => "$hour:30:00",label => "$hour:30"});
		$hour++;
	}
return @options;
}

	

    __PACKAGE__->meta->make_immutable;
    1;

