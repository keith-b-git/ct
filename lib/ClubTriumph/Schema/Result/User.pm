use utf8;
package ClubTriumph::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'mediumtext'
  is_nullable: 1

=head2 password

  data_type: 'mediumtext'
  is_nullable: 1

=head2 email_address

  data_type: 'mediumtext'
  is_nullable: 1

=head2 memno

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 first_name

  data_type: 'mediumtext'
  is_nullable: 1

=head2 last_name

  data_type: 'mediumtext'
  is_nullable: 1

=head2 active

  data_type: 'integer'
  is_nullable: 1

=head2 pmnew

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 admintxt

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 verifyquick

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 avatar

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 pmcnt

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 lastpost

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 posts

  data_type: 'integer'
  is_nullable: 1

=head2 avatarupload

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 registered

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dateformat

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 timezone

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 timeformat

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 sig

  data_type: 'text'
  is_nullable: 1

=head2 verifyage

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 avatarsize

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 lastpm

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sn

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 lastactive

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 md5upgrade

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 status

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 location

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sex

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dob

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 personaltxt

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 censor

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 siteurl

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 hidemail

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 lng

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dst

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forgotpass

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 pmpopup

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sitename

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 notify

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 yim

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 msn

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 shownewonly

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 icq

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 aim

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 hideonline

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 skype

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 validation

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forumid

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 threads_per_page

  data_type: 'integer'
  is_nullable: 1

=head2 replies_per_page

  data_type: 'integer'
  is_nullable: 1

=head2 images_per_page

  data_type: 'integer'
  is_nullable: 1

=head2 blogs_per_page

  data_type: 'integer'
  is_nullable: 1

=head2 shop_per_page

  data_type: 'integer'
  is_nullable: 1

=head2 location_tag

  data_type: 'tinyint'
  is_nullable: 1

=head2 contact_view

  data_type: 'integer'
  is_nullable: 1

=head2 date_registered

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 licence

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "mediumtext", is_nullable => 1 },
  "password",
  { data_type => "mediumtext", is_nullable => 1 },
  "email_address",
  { data_type => "mediumtext", is_nullable => 1 },
  "memno",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "first_name",
  { data_type => "mediumtext", is_nullable => 1 },
  "last_name",
  { data_type => "mediumtext", is_nullable => 1 },
  "active",
  { data_type => "integer", is_nullable => 1 },
  "pmnew",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "admintxt",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "verifyquick",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "avatar",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "pmcnt",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "lastpost",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "posts",
  { data_type => "integer", is_nullable => 1 },
  "avatarupload",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "registered",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dateformat",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "timezone",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "timeformat",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "sig",
  { data_type => "text", is_nullable => 1 },
  "verifyage",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "avatarsize",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "lastpm",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sn",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "lastactive",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "md5upgrade",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "status",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "location",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sex",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dob",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "personaltxt",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "censor",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "siteurl",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "hidemail",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "lng",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dst",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forgotpass",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "pmpopup",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sitename",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "notify",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "yim",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "msn",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "shownewonly",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "icq",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "aim",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "hideonline",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "skype",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "validation",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forumid",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "threads_per_page",
  { data_type => "integer", is_nullable => 1 },
  "replies_per_page",
  { data_type => "integer", is_nullable => 1 },
  "images_per_page",
  { data_type => "integer", is_nullable => 1 },
  "blogs_per_page",
  { data_type => "integer", is_nullable => 1 },
  "shop_per_page",
  { data_type => "integer", is_nullable => 1 },
  "location_tag",
  { data_type => "tinyint", is_nullable => 1 },
  "contact_view",
  { data_type => "integer", is_nullable => 1 },
  "date_registered",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "licence",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 baskets

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Basket>

=cut

__PACKAGE__->has_many(
  "baskets",
  "ClubTriumph::Schema::Result::Basket",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 blog_menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::BlogMenu>

=cut

__PACKAGE__->has_many(
  "blog_menus",
  "ClubTriumph::Schema::Result::BlogMenu",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 bookmarks

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Bookmark>

=cut

__PACKAGE__->has_many(
  "bookmarks",
  "ClubTriumph::Schema::Result::Bookmark",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entrants

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entrant>

=cut

__PACKAGE__->has_many(
  "entrants",
  "ClubTriumph::Schema::Result::Entrant",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "ClubTriumph::Schema::Result::Entry",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 histories

Type: has_many

Related object: L<ClubTriumph::Schema::Result::History>

=cut

__PACKAGE__->has_many(
  "histories",
  "ClubTriumph::Schema::Result::History",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items",
  "ClubTriumph::Schema::Result::Item",
  { "foreign.author" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items_read

Type: has_many

Related object: L<ClubTriumph::Schema::Result::ItemRead>

=cut

__PACKAGE__->has_many(
  "items_read",
  "ClubTriumph::Schema::Result::ItemRead",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 locations

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Location>

=cut

__PACKAGE__->has_many(
  "locations",
  "ClubTriumph::Schema::Result::Location",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 loginouts

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Loginout>

=cut

__PACKAGE__->has_many(
  "loginouts",
  "ClubTriumph::Schema::Result::Loginout",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member_validations

Type: has_many

Related object: L<ClubTriumph::Schema::Result::MemberValidation>

=cut

__PACKAGE__->has_many(
  "member_validations",
  "ClubTriumph::Schema::Result::MemberValidation",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 members

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->has_many(
  "members",
  "ClubTriumph::Schema::Result::Member",
  { "foreign.userid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 memforms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->has_many(
  "memforms",
  "ClubTriumph::Schema::Result::Memform",
  { "foreign.userid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 memno

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "memno",
  "ClubTriumph::Schema::Result::Member",
  { memno => "memno" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
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
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 notifications

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Notification>

=cut

__PACKAGE__->has_many(
  "notifications",
  "ClubTriumph::Schema::Result::Notification",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 orders

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "ClubTriumph::Schema::Result::Order",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 participants

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Participant>

=cut

__PACKAGE__->has_many(
  "participants",
  "ClubTriumph::Schema::Result::Participant",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Pm>

=cut

__PACKAGE__->has_many(
  "pms",
  "ClubTriumph::Schema::Result::Pm",
  { "foreign.userpm" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menu_items

Type: many_to_many

Composing rels: L</participants> -> menu_item

=cut

__PACKAGE__->many_to_many("menu_items", "participants", "menu_item");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 19:16:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZKW/nsq7KubxAjudmPdQxA


__PACKAGE__->many_to_many(menu_history => 'histories', 'menu');


__PACKAGE__->many_to_many("itempms", "pms", "itempm");


sub club_roles {
	my $self = $_[0];
	unless (($self -> memno)&&($self->memno->club_member)) { return ([{role => 'guest', description => 'Guest Website User'}])}
	my @roles;# = [{role => 'club_member',description => 'Club Member'}];

	if ($self->memno->club_member) {push (@roles,{role => 'club_member',description => 'Club Member'})}
	push (@roles, $self->memno->club_roles);
	foreach my $local_group ($self->memno->local_groups) {push (@roles,{role => 'local_group_organiser',description => 'Local Group Organiser: '.$local_group->title,  menus => ($local_group->menus)})}
	foreach my $event ($self->memno->events->search({},{order_by => {-desc => 'end'}})) {push (@roles,{role => 'event_organiser',description => 'Event Organiser: '.$event->title, menus => ($event->menus)})}
	return \@roles
}

sub club_roles_abbr {
	my $self = $_[0];
	unless (($self -> memno)&&($self->memno->club_member)) { return ([{role => 'guest', description => 'Guest Website User'}])}
	my @roles;# = [{role => 'club_member',description => 'Club Member'}];

	if ($self->memno->club_member) {push (@roles,{role => 'club_member',description => 'Club Member'})}
	push (@roles, $self->memno->club_roles);
	foreach my $local_group ($self->memno->local_groups) {push (@roles,{role => 'local_group_organiser',description => 'Local Group Organiser: '.$local_group->title,  menus => ($local_group->menus)})}
	foreach my $event ($self->memno->events->search({end => {'>' => DateTime->now->subtract(years => 2)}},{order_by => {-desc => 'end'}})) {push (@roles,{role => 'event_organiser',description => 'Event Organiser: '.$event->title, menus => ($event->menus)})}
	return \@roles
}


sub club_member {
	my $self = $_[0];
	return ($self->memno && $self->memno->club_member)
}

sub club_officer {
	my $self = $_[0];
	unless (($self -> memno)&&($self->memno->club_member)) {return 0}
	foreach my $role ($self->memno->club_roles) {
		if ($role->club_officer) {return 1}
	}
	return 0;
}

sub access_level {
	my $self = $_[0];
	my $c = ClubTriumph->ctx;
	if ($c->session->{level_fake}) {return $c->session->{level_fake}}
	my $access_level = 512 | 256;
	unless ($c->user) {return $access_level}
	if (defined $c->session->{access_level} && $self->id == $c->user->id) {return $c->session->{access_level}}
	$access_level |= 128;
	unless (($self -> memno)&&($self->memno->club_member)) {return $access_level}
	$access_level |= 64;
	foreach my $club_role ($self->memno->club_roles) {
		$access_level |= $club_role->access_level
	}
	if ($self->club_officer) {$access_level |= 16}
	return $access_level
}

sub accessible_to_user { #because template toolkit can't handle &
	my ($self,$level) = @_;
	return $self->access_level & $level
}


sub blogs {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '2'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
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

sub last_visited {
	my $self = $_[0];
	return ($self->histories)[-1];
}

sub profile {
	my $self = $_[0];
	return $self->menus->search({type => 'user_profile'})->first;
	}
	
sub imagebank {
	my ($self) = $_[0];
	my $rows = 10;
	return $self->items->search({contenttype => '3'},{order_by => {-desc => 'id'},rows => $rows});
	}
	
	
sub pm_count {
	my ($self, $folder) = @_;
	my $count = $self->itempms->count({folder => $folder});
	return $count
}

sub new_pm_count {
	my ($self, $folder) = @_;
	my $count = $self->itempms->count({unread => 1, folder => $folder});
	return $count
}

sub privatemessages {
	my ($self, $rows, $page, $folder) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->itempms->search({folder => $folder},
	{ rows => $rows,page => $page, order_by => {-desc => 'modified'}, group_by => 'id'}); 
}

sub sentpms {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->items->search({contenttype => 7},
	{ rows => $rows,page => $page, order_by => {-desc => 'modified'}, group_by => 'id'}); 
}

sub sent_pm_count {
	my ($self, $rows, $page) = @_;
	my $count = $self->items->search({contenttype => 7});
	return $count
}

sub basket_total {
	my $self = $_[0];
	my $total;
	foreach my $purchase ($self->baskets) {
		$total += ($purchase->price * $purchase->quantity);
	}
	return $total;
}

sub basket_items {
	my $self = $_[0];
	return $self->baskets->get_column('quantity')->sum
}

sub post_count {
	my $self = $_[0];
	return $self->items->count({'-or' => [{contenttype => 5},{contenttype => 6}]})
}

sub count_posts {
	my $self = shift;
	$self->update({posts => $self->post_count})
}


sub generate_confirmation_code {
	my ($self, $ip_address ) = @_;
	my $now = DateTime->now;
	my $md5 = Digest::MD5->new;
	$md5->add( $self->username, $ip_address, $now->datetime );
	my $code = $md5->hexdigest;
	return $code;
}

sub fullname {
	my $self = $_[0];
	if ($self->memno) {return $self->memno->fullname}
	else {return $self->first_name.' '.$self->last_name}
}

sub data_used {
	my $self = shift;
	return $self->items->get_column('storage')->sum || 0;
}


sub organiser_of { # returns whether user is the organiser for an event or group
	my ($self,$menu) = @_;
	return unless $menu;
	if ($menu->local_group && $menu->local_group->organiser && $menu->local_group->organiser->userid && ($menu->local_group->organiser->userid->id == $self->id)) {
		return $self->club_member}
}

sub is_shopkeeper {
	my $self = shift;
	return unless $self->club_member;
	return $self->memno->is_shopkeeper;
}

sub maxtags {
	my $self = $_[0];
	if ($self-> club_member) {return 3}
	else {return 2}
}

sub create_profile {
	my ($self,$c) = @_;
	unless ($self->threads_per_page) {$self->threads_per_page(20)};
	unless ($self->replies_per_page) {$self->replies_per_page(20)};
	unless ($self->images_per_page) {$self->images_per_page(20)};
	unless ($self->shop_per_page) {$self->shop_per_page(20)};
	unless ($self->date_registered) {$self->date_registered(DateTime->now)};
	my $profile = $self->menus->find_or_create({user =>$self->id, type => 'user_profile'});
	my $root = $self->result_source->schema->resultset('Menu')->find({type => 'profileroot'});
	if ($root) {
		$profile->update({heading1 => $self->fullname.' - ('.$self->username.') - user profile', parent => $root->pid});
		$profile->default_permissions;
#		$profile->spider($c);
	}
}

sub membership_status {
	my $self = shift;
	if ($self->memno) {return $self->memno->status};
	if ($self->memforms->count({})) {return 'application in progress'}
	return 'non-member';
}

#profile page stuff

sub images_viewable_by {
	my ($self,$user) = @_;
	return 1;
}

sub messages_viewable_by {
	my ($self,$user) = @_;
	return 1;
}

sub blogs_viewable_by {
	my ($self,$user) = @_;
	return 1;
}

sub threads {
	my ($self, $user, $rows, $page) = @_;
	return unless ($self->messages_viewable_by($user));
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}

	return $self->items->items_viewable_by($user)->search({ -or => [contenttype => 5, contenttype =>6] },
			{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
}

sub baseurl {
	my $self = $_[0];
	return ['/profile',$self->id]
}

#end of profile page stuff

sub email_user { #send simple message e-mail to user
	my ($self,$c,$message,$subject) = @_;
	$c->stash(message => $message);
	$c->stash->{email} = {
        to      => $self->email,
        from    => 'test@club.triumph.org.uk',
        subject => $subject,
		template => 'simple_message.tt2',
    };
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}

sub send_email { # generic email
	my ($self,$c,$from,$to,$subject,$template, $object) = @_;
	$c->stash->{email} = {
        to      => $to,
        from    => $from,
        subject => $subject,
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };    
	$c->stash(user => $self, mail_template => $template, object => $object);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}



sub membership_admin {
	my $self = shift;
	return ($self->memno && $self->memno->membership_admin)
}

sub contactable {
	my ($self,$user) = @_;
	my $level = $self->contact_view;
	unless ($level) {$level = 0}
	unless ($user) { return ($level == 256)}
	return ($level & $user->access_level)
}

sub link_to_member {
	my ($self, $memno) = @_;
	return unless $memno;
	my $member = $self->result_source->schema->resultset('Member')->find({memno => $memno});
	return unless $member;
	$self->update({memno=>$memno});
	$member->update({userid => $self->id});
	if ($self->email && !($member->email)) {$member->update({email => $self->email})}
	$self->result_source->schema->resultset('Member')->search({userid => $self->id, memno => {'!=' => $memno}})->update({userid => undef});
	$self->result_source->resultset->search({memno => $memno, id => {'!=' => $self->id}})->update({memno => undef});
	$member->entries->related_resultset('menus')->update({user => $self->id});
	$member->registers->related_resultset('menus')->update({user => $self->id});
	
	
}

sub mobile {
	my $self = shift;
	if ($self->memno && $self->memno->mobile) {
		return $self->memno->mobile
	}
}

sub draft_entries { # returns current draft event entries
	my $self = shift;
	my $halfhourago = DateTime->now->subtract(minutes => 30);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->entries->search({-or => [-and => [status => 'draft', created => {'>=', $dtf->format_datetime($halfhourago)}], status => 'resubmit']});
}

sub live_entries { # returns current live event entries
	my $self = shift;
	return $self->entries->search({-or => [status => 'live', status => 'complimentary']});
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
