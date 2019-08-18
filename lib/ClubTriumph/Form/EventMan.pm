    package ClubTriumph::Form::EventMan;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Table';
    use namespace::autoclean;

	has '+item_class' => ( default =>'event' );
#	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw');
	has 'user_id' => ( isa => 'Int', is => 'rw' );
	has_field 'max_entries' => (required => 1);
	has_field 'min_team' => (required => 1);
	has_field 'max_team' => (required => 1);
	has_field 'car' => (type => 'Boolean');
	has_field 'fee_per_entry' => (type => 'Money');
	has_field 'fee_per_entrant' => (type => 'Money');
	has_field 'nm_entry' => (type => 'Boolean', label_attr => {title => 'Allow non members to enter event?'});
	has_field 'nm_fee_per_entry' => (type => 'Money');
	has_field 'nm_fee_per_entrant' => (type => 'Money');
	has_field 'entry_opens' =>  ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy", required => 1);
	has_field 'entry_closes' => ( type => 'Date', element_class => 'datepicker', format => "dd/mm/yy" , required => 1);
	has_field 'extras' => (type => 'Submit', value => 'Add', label_class => 'form_label',  label => 'Add Event Options');
	has_field 'previous' => (type => 'Submit', value => 'Previous', label_class => 'form_label',  label => '');
    has_field 'submit' => (type => 'Submit', value => 'Next - edit web page content');



=cut
around 'update_model' => sub {
	my$orig = shift;
	my $self = shift;
	my $item = $self->item;

	$self->schema->txn_do( sub {
	$self->$orig(@_);
	my $menu_item = $self->schema->resultset('Menu')->find_or_create({parent => $item->menus->single->id, type => 'entrylist'});

	$menu_item->update({
		user => $self->item->organiser->userid,
		heading1 => 'entry list',
		view => 256,
		edit => 8,
		anchor => 0,
		add_blog => 64,
		view_blogs => 256,
		add_image => 64,
		view_images => 256,
		add_message => 128,
		view_messages => 256});
	});
};
=cut


    __PACKAGE__->meta->make_immutable;
    1;
