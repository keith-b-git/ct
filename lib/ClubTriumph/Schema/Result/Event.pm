use utf8;
package ClubTriumph::Schema::Result::Event;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Event

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<event_>

=cut

__PACKAGE__->table("event_");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 description

  data_type: 'mediumtext'
  is_nullable: 1

=head2 start

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 end

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 series

  data_type: 'integer'
  is_nullable: 1

=head2 fee_per_entry

  data_type: 'decimal'
  is_nullable: 1
  size: [9,2]

=head2 fee_per_entrant

  data_type: 'decimal'
  is_nullable: 1
  size: [9,2]

=head2 image_import_dir

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 predecessor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 organiser

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 event_type

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 min_team

  data_type: 'integer'
  is_nullable: 1

=head2 max_team

  data_type: 'integer'
  is_nullable: 1

=head2 car

  data_type: 'integer'
  is_nullable: 1

=head2 entry_opens

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 entry_closes

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 max_entries

  data_type: 'integer'
  is_nullable: 1

=head2 challenge

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 email

  data_type: 'mediumtext'
  is_nullable: 1

=head2 phone

  data_type: 'mediumtext'
  is_nullable: 1

=head2 website

  data_type: 'mediumtext'
  is_nullable: 1

=head2 nm_entry

  data_type: 'integer'
  is_nullable: 1

=head2 nm_fee_per_entry

  data_type: 'decimal'
  is_nullable: 1
  size: [9,2]

=head2 nm_fee_per_entrant

  data_type: 'decimal'
  is_nullable: 1
  size: [9,2]

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "description",
  { data_type => "mediumtext", is_nullable => 1 },
  "start",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "end",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "series",
  { data_type => "integer", is_nullable => 1 },
  "fee_per_entry",
  { data_type => "decimal", is_nullable => 1, size => [9, 2] },
  "fee_per_entrant",
  { data_type => "decimal", is_nullable => 1, size => [9, 2] },
  "image_import_dir",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "predecessor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "organiser",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "event_type",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "min_team",
  { data_type => "integer", is_nullable => 1 },
  "max_team",
  { data_type => "integer", is_nullable => 1 },
  "car",
  { data_type => "integer", is_nullable => 1 },
  "entry_opens",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "entry_closes",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "max_entries",
  { data_type => "integer", is_nullable => 1 },
  "challenge",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "email",
  { data_type => "mediumtext", is_nullable => 1 },
  "phone",
  { data_type => "mediumtext", is_nullable => 1 },
  "website",
  { data_type => "mediumtext", is_nullable => 1 },
  "nm_entry",
  { data_type => "integer", is_nullable => 1 },
  "nm_fee_per_entry",
  { data_type => "decimal", is_nullable => 1, size => [9, 2] },
  "nm_fee_per_entrant",
  { data_type => "decimal", is_nullable => 1, size => [9, 2] },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 challenge

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Championship>

=cut

__PACKAGE__->belongs_to(
  "challenge",
  "ClubTriumph::Schema::Result::Championship",
  { id => "challenge" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 champpoints

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Champpoint>

=cut

__PACKAGE__->has_many(
  "champpoints",
  "ClubTriumph::Schema::Result::Champpoint",
  { "foreign.eventpts" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 club_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->has_many(
  "club_roles",
  "ClubTriumph::Schema::Result::ClubRole",
  { "foreign.club_event" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "ClubTriumph::Schema::Result::Entry",
  { "foreign.event" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 event_locations

Type: has_many

Related object: L<ClubTriumph::Schema::Result::EventLocation>

=cut

__PACKAGE__->has_many(
  "event_locations",
  "ClubTriumph::Schema::Result::EventLocation",
  { "foreign.event_" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 event_merchandises

Type: has_many

Related object: L<ClubTriumph::Schema::Result::EventMerchandise>

=cut

__PACKAGE__->has_many(
  "event_merchandises",
  "ClubTriumph::Schema::Result::EventMerchandise",
  { "foreign.event" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 events

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "ClubTriumph::Schema::Result::Event",
  { "foreign.predecessor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.event" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organiser

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "organiser",
  "ClubTriumph::Schema::Result::Member",
  { memno => "organiser" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 predecessor

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "predecessor",
  "ClubTriumph::Schema::Result::Event",
  { id => "predecessor" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2018-08-11 21:16:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wfraNrsvHhZkC++l03hk0A

__PACKAGE__->many_to_many(locations => 'event_locations', 'location');

__PACKAGE__->many_to_many(items => 'blog_events', 'item');

sub blogs {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '2'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}

sub threads {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '5'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}

sub images {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '3'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}

sub image_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '3'})
}

sub blog_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '2'})
}

sub thread_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '5'})
}

sub entry_open {
	my ($self,$user) = @_;
	return unless ($self->event_type eq 'ct-man');
	unless ($self && ($self->entry_opens) && ($self->entry_closes) && $user && ($user->club_member || $self->nm_entry)) {return 0}
	return ((time >= $self->entry_opens->epoch) && (time <= $self->entry_closes->epoch + 24*60*60 -1)) 
}


sub challenge_active {
	my ($self,$challenge) = @_;
	if ($self->challenge && $challenge && ($self->challenge->id != $challenge->id)) {return 0}
	else {return 1}
}

sub location_count {
	my $self = $_[0];
	return scalar($self->event_locations)
}

sub entered_by { # returns whether user has entered event
	my ($self, $user) = @_;
	return unless $user;
	if ($self->entries->count({'entrants.memno' => $user->memno->memno},{prefetch => 'entrants'})) {return 1}
	return 0
}

sub entry_for_user { # returns users entry
	my ($self, $user) = @_;
	return unless $user;
	return $self->entries->search({'entrants.user' => $user->id},{prefetch => 'entrants'})->first
}


sub entrylist { # returns entry list menu item
	my $self = $_[0];
	return $self->menus->first->menus->find({type => 'entrylist'});
}

sub update_from_predecessor {
	my $self = shift;
	return unless $self->predecessor;
	my $pred = $self->predecessor;
	$self->update({
		description => $pred->description,
		fee_per_entry => $pred->fee_per_entry,
		fee_per_entrant => $pred->fee_per_entrant,
		event_type => $pred->event_type,
		min_team => $pred->min_team,
		max_team => $pred->max_team,
		car => $pred->car,
		max_entries => $pred->max_entries,
	});
	foreach my $location ($pred->locations) {
		my $link = $self->result_source->schema->resultset('EventLocation')->find_or_create({'event_' => $self->id, location => $location->id})
	}
}

sub in_future {
	my $self = shift;
	return $self->start > DateTime->now;
	}
	
sub form_stages { #provides data for form navigator
	my $self = shift;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my @form_stages;
	push (@form_stages, {stage => 'Event Details', url => $c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','edit')});
	if ($self->title) {
		push (@form_stages, {stage => 'Date & Contact', url => $c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','edit2')});
	}
	else {
		push (@form_stages, {stage => 'Date & Contact', url => ''});
	}
	if ($self->start) {
		push (@form_stages, {stage => 'Location', url => $c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','addlocation')});
	}
	else {
		push (@form_stages, {stage => 'Location', url => ''});
	}
	if ($self->event_type eq 'ct-man') {
		if ($self->locations->count({}) >0) {
			push (@form_stages, {stage => 'Event Management', url => $c->uri_for('/menu',$c->stash->{menu_item}->pid,'event','edit3')});
		}
		else {
			push (@form_stages, {stage => 'Event Management', url => ''});
		}
	}
	return \@form_stages;
}

sub entry_count {
	my $self = shift;
	return unless ($self->event_type eq 'ct-man');
	my $halfhourago = DateTime->now->subtract(minutes => 30);
	my $count = $self->entries->count({
		-or =>
		[-and => [status => {'!=' => 'withdrawn'},
		status => {'!=' => 'reserve'}],
		-and => [status => 'draft', created => {'>=', $halfhourago}]
		]});
	return $count;
}
		
sub entry_full {
	my $self = shift;
	return $self->entry_count >= $self->max_entries
	
}

sub live_count {
	my $self = shift;
	return $self->entries->count({
	-and => [status => {'!=' => 'withdrawn'},
#		status => {'!=' => 'reserve'},
		status => {'!=' => 'draft'}],
	});
}

sub entry_statuses {
	my $self = shift;
	return $self->entries->search({
	},{group_by => 'status', order_by => 'id'})->get_column('status')->all
}


sub entries_by {
	my ($self, $status) = @_;
	return $self->entries->count({
	status => $status
	});
}

sub my_entries {
	my ($self, $user) = @_;
	return unless $user;
	unless ($user->memno) {
		return [$self->entries->search({	status => {'!=' => 'withdrawn'}, 
		status => {'!=' => 'draft'},
		'entrants.user' => $user->id},{prefetch => 'entrants'})]
	}
	my $me = $self->result_source->resultset->current_source_alias;
	my $member = $user->memno;
	return [$self->entries->search({
		status => {'!=' => 'withdrawn'}, 
		status => {'!=' => 'draft'}, 
		-or => [
			"$me.member" => $member->memno,
			'entrants.memno' => $member->memno]}
				,{prefetch => 'entrants', group_by => "$me.id"}
	)];
}

sub weblink {
	my $self =shift;
	if ($self->website =~ /^https?:\/\//) {return $self->website}
	return 'http://'.$self->website
}

sub admin_by { #returns whether user has admin rights to event
	my ($self,$user) = @_;
	return 1 if ($self->menus->first->user->id == $user->id);
	return 1 if $self->menus->first->editable_by($user);
	return 0;
}

sub handle_broadcast {
	my ($self,$c,$sms) = @_;
	my $message = $sms->content;
	$c->log->debug(" *** message = $message ***");
	return 0 unless ($message =~ /^broadcast/i);
	$c->log->debug(" *** message is broadcast ***");
	my $valid = 0;
#	foreach my $member ($c->model('ClubTriumphDB::Member')->search({mobile => $sms->originator})) {
#		if ($member->userid && $self->admin_by($member->userid)) {$valid = 1}
#		$c->log->debug(" *** found member ".$member->memno." valid = $valid ***");
#	} 
	if ($self->organiser->mobile eq $sms->originator) {$valid = 1}
	foreach my $manager ($self->menus->first->manager->members) {
		if ($manager->mobile eq $sms->originator) {$valid = 1}
	}
	
	return 0 unless $valid;
	$c->log->debug(" *** sender is valid ***");
	$message =~ s/^broadcast//i;
	my $response = $self->entries->search({status => 'live'})->related_resultset('entrants')->sendsms($message,$sms->originator); 
	$sms->delete_parts;
	return 1;
}

sub set_webhook {
	my ($self,$c) =@_;
	my $token = $c->config->{'Model::Telegram'}->{token};
	use WWW::Telegram::BotAPI;
	my $api = WWW::Telegram::BotAPI->new (
		token => $token,
		force_lwp => 1
	);
	my $webhook = $api->api_request ('setWebHook',{
		url => $c->uri_for('/menu',$self->menus->first->pid,'event','new_telegram')->as_string,
#		certificate  => {file => '/etc/ssl/certs/server.crt'},
#		certificate  => {triumph.servers.prgn.misp.co.uk.crt'},
	});

	my $webhookinfo = $api->api_request ('getWebHookInfo');
	my $response = $$webhookinfo{result}{url}."\n";
	$response .= $$webhookinfo{result}{has_custom_certificate}."\n";
	$response .= $$webhookinfo{result}{pending_update_count}."\n";
	$response .= $$webhookinfo{result}{last_error_date}."\n";
	$response .= $$webhookinfo{result}{last_error_message}."\n";
	return $response;
}

sub participant_count {
	my $self = shift;
	return $self->entries->search({
	-and => [status => {'!=' => 'withdrawn'},
		status => {'!=' => 'reserve'},
		status => {'!=' => 'draft'}],
	},{prefetch => 'entrants'})->related_resultset('entrants')->count({});
}

after 'update' => sub {
	my $self = shift;
	return unless ($self->entry_opens && $self->entry_opens->year);
	if ($self->entry_opens->hour == 0 && $self->entry_opens->minute == 0 && $self->entry_opens->second == 0) {
		my $entry_opens = $self->entry_opens->clone->add(seconds => int(rand(06*60*60)) + 1);
		$self->update({entry_opens => $entry_opens});
	} 
};

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
