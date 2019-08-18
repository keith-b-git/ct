    package ClubTriumph::Form::Event;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has_field 'email' => (type => 'Email', label => 'Contact e-mail', required_when => {phone => ''},
		messages => { required => 'Please add some contact details' }, label_class => 'form_label');
	has_field 'phone' => (label => 'Contact phone', required_when => {email => ''},
		messages => { required => 'Please add some contact details' }, label_class => 'form_label');
	has_field 'website';
 #	has_field 'description' => (type => 'TextArea');
	has_field 'start_date' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label_class => 'form_label');
	has_field 'start_time' => (type => 'Select', label_class => 'form_label');

	has_field 'end_date' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", label_class => 'form_label' );
	has_field 'end_time' => (type => 'Select', label_class => 'form_label');
	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label', noupdate => 1, label => '');
    has_field 'submit' => (type => 'Submit', value => 'Next', label_class => 'form_label', label => '');

  
	before 'update_model' => sub {
	my $self = shift;
	my $startdate = $self->field('start_date')->value;
	$startdate =~ /^(\d*)-(\d*)-(\d*)/;
	my $start = "$1-$2-$3";
	my $starttime = $self->field('start_time')->value;
	$start .="T$starttime";
	$self->item->start($start);
	my $enddate = $self->field('end_date')->value;
	$enddate =~ /^(\d*)-(\d*)-(\d*)/;
	my $end = "$1-$2-$3";
	my $endtime = $self->field('end_time')->value;
	$end .="T$endtime";
	$self->item->end($end)	
};
    
    

sub default_start_date {
	my ($self,$field,$item) = @_;
	if (defined $item)
	{
	my $date = $item->start;
	if ($date)
		{
		$date =~ /^(\d*)-(\d*)-(\d*)T.*/;
		return "$3/$2/$1";
		}
		else
		{
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
		$mon++; $year += 1900;
		return "$mday/$mon/$year";
		}
	}
}

sub options_start_time {
	my $i = 0;
	my @options;
	while ($i < 25)
	{
		unless ($i =~ /\d\d/) {$i = '0'.$i}
		push (@options, {label => "$i:00", value => "$i:00:00"});
		push (@options, {label => "$i:30", value => "$i:30:00"}); $i++
	}
	return @options;


}

sub default_start_time {
	my ($self,$field,$item) = @_;
	return unless defined $item;
	my $date = $item->start;
	$date =~ /T(\d*):/;
	return "$1:00:00";
}

sub default_end_date {
	my ($self,$field,$item) = @_;
	return unless defined $item;
	my $date = $item->end;
	if ($date)
		{
		$date =~ /^(\d*)-(\d*)-(\d*)T.*/;
		return "$3/$2/$1";
		}
		else
		{
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
		$mon++; $year += 1900;
		return "$mday/$mon/$year";
		}
}

sub options_end_time {
	my $i = 0;
	my @options;
	while ($i < 25)
	{
		unless ($i =~ /\d\d/) {$i = '0'.$i}
		push (@options, {label => "$i:00", value => "$i:00:00"}); $i++
	}
	return @options;
}

sub default_end_time {
	my ($self,$field,$item) = @_;
	return unless defined $item;
	my $date = $item->end;
	$date =~ /T(\d*):/;
	return "$1:00:00";
}




    __PACKAGE__->meta->make_immutable;
    1;
