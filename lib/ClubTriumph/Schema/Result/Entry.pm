use utf8;
package ClubTriumph::Schema::Result::Entry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Entry

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

=head1 TABLE: C<entries>

=cut

__PACKAGE__->table("entries");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 car

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 paid

  data_type: 'decimal'
  is_nullable: 1
  size: [9,2]

=head2 event

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 status

  data_type: 'varchar'
  is_nullable: 1
  size: 14

=head2 old_status

  data_type: 'varchar'
  is_nullable: 1
  size: 14

=head2 organiser_notes

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 entry_no

  data_type: 'integer'
  is_nullable: 1

=head2 member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 orderno

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 other_car

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 charity_link

  data_type: 'text'
  is_nullable: 1

=head2 engine_size

  data_type: 'integer'
  is_nullable: 1

=head2 regno

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "car",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "paid",
  { data_type => "decimal", is_nullable => 1, size => [9, 2] },
  "event",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "status",
  { data_type => "varchar", is_nullable => 1, size => 14 },
  "old_status",
  { data_type => "varchar", is_nullable => 1, size => 14 },
  "organiser_notes",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "entry_no",
  { data_type => "integer", is_nullable => 1 },
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "orderno",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "other_car",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "charity_link",
  { data_type => "text", is_nullable => 1 },
  "engine_size",
  { data_type => "integer", is_nullable => 1 },
  "regno",
  { data_type => "varchar", is_nullable => 1, size => 12 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<status_idx>

=over 4

=item * L</status>

=item * L</id>

=item * L</event>

=back

=cut

__PACKAGE__->add_unique_constraint("status_idx", ["status", "id", "event"]);

=head1 RELATIONS

=head2 baskets

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Basket>

=cut

__PACKAGE__->has_many(
  "baskets",
  "ClubTriumph::Schema::Result::Basket",
  { "foreign.entry" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 car

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Register>

=cut

__PACKAGE__->belongs_to(
  "car",
  "ClubTriumph::Schema::Result::Register",
  { id => "car" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 entrants

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entrant>

=cut

__PACKAGE__->has_many(
  "entrants",
  "ClubTriumph::Schema::Result::Entrant",
  { "foreign.team" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entry_merchandises

Type: has_many

Related object: L<ClubTriumph::Schema::Result::EntryMerchandise>

=cut

__PACKAGE__->has_many(
  "entry_merchandises",
  "ClubTriumph::Schema::Result::EntryMerchandise",
  { "foreign.entry" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 event

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "ClubTriumph::Schema::Result::Event",
  { id => "event" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 member

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "member",
  "ClubTriumph::Schema::Result::Member",
  { memno => "member" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.entry" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 mobiles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Mobile>

=cut

__PACKAGE__->has_many(
  "mobiles",
  "ClubTriumph::Schema::Result::Mobile",
  { "foreign.entry" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 orderno

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Order>

=cut

__PACKAGE__->belongs_to(
  "orderno",
  "ClubTriumph::Schema::Result::Order",
  { id => "orderno" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 telegrams

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Telegram>

=cut

__PACKAGE__->has_many(
  "telegrams",
  "ClubTriumph::Schema::Result::Telegram",
  { "foreign.entry" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "ClubTriumph::Schema::Result::User",
  { id => "user" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pyE+V7TnujSFgF1Po0mafw

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1, timezone => "Europe/London"},
);


sub amount_payable {
	my $self = $_[0];
	if ($self->status eq 'withdrawn' || $self->status eq 'complimentary') {return 0}
	my $fee;
	if (($self->user  && $self->user->club_member)  || ($self->member && $self->member->club_member)) {
		$fee = $self->event->fee_per_entry;
		$fee += $self->event->fee_per_entrant * $self->entrants;
	}
	else {
		if ($self->event->nm_entry) {
		$fee = $self->event->nm_fee_per_entry;
		$fee += $self->event->nm_fee_per_entrant * $self->entrants;
		}
	}
	return $fee
}

sub balance {
	my $self = $_[0];
	if ($self->status eq 'reserve' && $self->on_reserve) {return $self->paid}
	return $self->paid - $self->amount_payable ;
}

sub update_merchandise {
	my $self = shift;
	foreach my $item ($self->event->event_merchandises) {
		if ($item->type eq 'entry') {
			$self->entry_merchandises->find_or_create(entry => $self->id, merchandise => $item->id)
		}
		if ($item->type eq 'entrant') {
			foreach my $entrant ($self->entrants) {
				$self->entry_merchandises->find_or_create(entry => $self->id, entrant => $entrant->id, merchandise => $item->id)
			}
		}
	}
	foreach my $merchandise ($self->entry_merchandises) {
		if ($merchandise->merchandise->type eq 'entrant' && !($self->entrants->find({id => $merchandise->entrant}))) {
			$merchandise->delete
		}
	}
}

sub create_menu_item {
	my ($self, $c) =@_;
	my $entry_list = $self->result_source->schema->resultset('Menu')->find({parent => $self->event->menus->single->id, type => 'entrylist'});
	return unless ($entry_list);
	my $user;
	if ($self->user) {$user = $self->user->id}
	if ($self->member && $self->member->userid) {$user = $self->member->userid->id}
	my $menu_item = $self->result_source->schema->resultset('Menu')->find_or_create({parent => $entry_list, entry => $self->id});
	$menu_item->update({
		type => 'entry',
		user => $user,
		heading1 => $self->title,
		});
	$menu_item->default_permissions;
}

sub team_number {
	my $self = shift;
	return if ($self->status eq 'draft');
	if ($self->entry_no) {return $self->entry_no}
	else {
		my $entryno =  $self->event->entries->count({
		-and => [id => {'<=' => $self->id},
		status => {'!=' => 'draft'},
		]});
		$self->update({entry_no => $entryno});
		return $entryno
	}
}

sub will_expire {
	my $self = shift;
	return $self->created->clone->set_time_zone('Europe/London')->add(minutes => 30)
}

sub has_expired {
	my $self = shift;
	my $halfhourago = DateTime->now->subtract(minutes => 30);
	return ($self->status eq 'draft') && ($self->created < $halfhourago)
}

sub on_reserve {
	my $self = shift;
	my $halfhourago = DateTime->now->subtract(minutes => 30);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $count = $self->event->entries->count({
		-and => [id => {'<=' => $self->id},
		-or =>
		[-and => [ status => {'!=' => 'withdrawn'},status => {'!=' => 'draft'}],
		-and => [status => 'draft', created => {'>=', $dtf->format_datetime($halfhourago)}]
		]]});
	return ($count  > $self->event->max_entries);
}

sub make_reserve {
	my ($self, $c) =@_;
	$self->update({status => 'reserve'});
	$self->create_menu_item($c)
}
	
sub next_entry {
	my $self = shift;
	return unless ($self->entry_no);
	return $self->event->entries->search({status => {'!=' => 'draft'},entry_no => {'>' => $self->entry_no}},{order_by => 'entry_no'})->first
}

sub previous_entry {
	my $self = shift;
	return unless ($self->entry_no);
	return $self->event->entries->search({status => {'!=' => 'draft'},entry_no => {'<' => $self->entry_no}},{order_by => {'-desc' => 'entry_no'}})->first
}

sub email_entrant { #send message e-mail to entrant
	my ($self,$c,$message,$subject,$sender,$template,$force_to) = @_;
	$c->stash(message => $message);
	my $to;
	if ($self->member && $self->member->email) {$to = $self->member->email}
	elsif ($self->user && $self->user->email_address) {$to = $self->user->email_address}
	if ($force_to) {$to = $force_to}
	return unless ($to);
	$c->stash->{email} = {
        to      => $to,
        from    => $sender,
        subject => $subject,
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };
	$c->stash(entry => $self, mail_template => $template);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	    return 0
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	    return 1
	}
}

sub car_desc {
	my $self = shift;
	if ($self->car) {return $self->car->known_as}
	return $self->other_car;
}

sub location {
	my $self = shift;
	my $tenminutesago = DateTime->now->subtract(minutes => 10);
	my $telegramloc = $self->telegrams->search({locationtime => {'>' => $tenminutesago}},{order_by => {-desc => 'locationtime'}})->first;
	if ($telegramloc) {
		return {latitude => $telegramloc->latitude, longitude => $telegramloc->longitude}
	}
	
}
sub new_sms {
	my ($self,$c,$sms) = @_;
	my $diaryentry = $c->model('ClubTriumphDB::Item')->find_or_create({
		blogref => $sms->messid,
			contenttype => 14,
			view => 256
	});
	$diaryentry->update({
		content => $sms->content,
		view => $self->menus->first->view});
	$diaryentry->update({created => DateTime->now});
	$diaryentry->update({modified => DateTime->now});
	$diaryentry->link_to_menu($self->menus->single);
	foreach my $uploads (keys %{$c->req->{uploads}}) {
		foreach my $upload ($c->req->upload($uploads)) { 
			if (($upload->type && $upload->type =~ /^image/ || 
			$upload->filename =~ /\.jpg$/ ||
			$upload->filename =~ /\.jpeg$/ 
			) && $upload->size) { 
				my $image = $diaryentry->items_attachments->find_or_create({title => $upload->filename, contenttype => 3, view => 256}); 
				$image->add_image_to_item($upload); 
				$image->link_to_menu($self->menus->single);
			}
			elsif ($upload->size) { 
				my $file= $diaryentry->items_attachments->find_or_create({title => $upload->filename, contenttype => 4, view => 256}); 
				$file->add_file_to_item($upload); 
				if ($upload->type =~ /^text/i ||
				$upload->filename =~ /\.txt$/) {
					if ($upload->slurp =~ /Latitude:(.*),Longitude:(.*)\n/) {
						$diaryentry->update({latitude => $1, longitude => $2});
					}
#					if (length( $upload->slurp) > (length $self->content)) {
						my $atttext = $upload->slurp;
						$atttext =~ s/^10cr//i;
						$diaryentry->update({content => $atttext})
#					}
				}
			}
		}
	}
#	$c->model('ClubTriumphDB::Telegram')->send_diary($c,$diaryentry);
	$c->model('ClubTriumphDB::Telegram')->send_channel($c,$diaryentry)
}

sub new_telegram {
	my ($self,$c,$telegram) = @_;
	my $token = $c->config->{'Model::Telegram'}->{token};
	if ($$telegram{message}{text} || $$telegram{message}{photo} || $$telegram{message}{video}) {
		my $diaryentry = $c->model('ClubTriumphDB::Item')->find_or_create({
			blogref => $$telegram{message}{message_id},
				contenttype => 14,
		});
		$diaryentry->update({
			content => $$telegram{message}{text},
			view => $self->menus->first->view});
		$diaryentry->update({created => DateTime->now});
		$diaryentry->update({modified => DateTime->now});
		$diaryentry->link_to_menu($self->menus->single);
		if ($self->location) {
			$diaryentry->update({latitude => $self->location->{latitude}, longitude => $self->location->{longitude}});
		}
		my $photos = $$telegram{message}{photo};
		my $biggestpic;
		foreach my $photo (@$photos) {
			if (!$biggestpic || ($$photo{width} > $$biggestpic{width})) {
				$biggestpic = $photo
			}
		}
		use WWW::Telegram::BotAPI;
		my $api = WWW::Telegram::BotAPI->new (
		token => $token,
		force_lwp => 1
		);
		if ($biggestpic) {
			my $file = $api->api_request ('getFile',
			{file_id => $$biggestpic{file_id}
			});
			$$file{result}{file_path} =~ /\.(\w*)$/;
			my $extension = $1;
			my $tempname = $c->path_to('root','static','temp').'/'.'embedded'.$self->id.'.'.$extension; 
			use LWP::Simple;
			getstore('https://api.telegram.org/file/bot'.$token.'/'.$$file{result}{file_path},$tempname); 
			my $att = $diaryentry->attach_file($c,$tempname,$tempname,'image/',$$telegram{message}{caption},,$diaryentry->licence);
			$att->link_to_menu($self->menus->single);
			unless ($diaryentry->content) {$diaryentry->update({content => $$telegram{message}{caption}})}
		}
		if ($$telegram{message}{video}) { $c->log->debug('*** found a video ***');
			my $file = $api->api_request ('getFile',
			{file_id => $$telegram{message}{video}{file_id}
			}); 
			$c->log->debug('** file_path '.$$file{result}{file_path});
			$$file{result}{file_path} =~ /\.(\w*)$/;
			my $extension = $1;
			my $tempname = $c->path_to('root','static','temp').'/'.'embedded'.$self->id.'.'.$extension; 
			$c->log->debug('**  tempname'.$tempname);
			use LWP::Simple;
			getstore('https://api.telegram.org/file/bot'.$token.'/'.$$file{result}{file_path},$tempname); 
			my $att = $diaryentry->attach_file($c,$tempname,$tempname,$$telegram{message}{video}{mime_type},$$telegram{message}{caption},,$diaryentry->licence);
			unless ($diaryentry->content) {$diaryentry->update({content => $$telegram{message}{caption}})}
		}
		$c->model('ClubTriumphDB::Telegram')->send_channel($c,$diaryentry)
	}
}

sub teamdesc {
	my $self = shift;
	my $desc;
	if ($self->menus && $self->menus->first) {$desc = $self->menus->first->title."\n"}
	if ($self->car) {$desc .= $self->car->known_as."\n"}
	foreach my $entrant ($self->entrants) {
		$desc .= ' '.$entrant->name."\n"
	}
	return $desc;
}

sub tabletop { #for handling no fee events, goes to submitted from draft
	my ($self, $c) = @_;
	if (($c->user->club_member && ($self->event->fee_per_entry == 0 
		&& $self->event->fee_per_entrant == 0)) || 
		($self->event->nm_entry && ! $c->user->club_member && ($self->event->nm_fee_per_entry == 0 
		&& $self->event->nm_fee_per_entrant == 0)))
		 {
		if ($self->status eq 'draft') {
			$self->update({status => 'submitted', paid =>  $self->amount_payable});
			$self->create_menu_item;
		}
	$c->response->redirect($c->uri_for('/menu',$self->menus->first->pid,'view'));
	return 1;
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
