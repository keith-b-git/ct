use utf8;
package ClubTriumph::Schema::Result::Member;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Member

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

=head1 TABLE: C<members>

=cut

__PACKAGE__->table("members");

=head1 ACCESSORS

=head2 memno

  data_type: 'integer'
  is_nullable: 0

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 inits

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forename

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 surname

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 address1

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address2

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address3

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address4

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 address5

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 tel

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 joindate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 expdate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 class

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 assocs

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 magazine

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 cars

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 dd

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forumlogin

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forumpassword

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 forumscreenname

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 local_group

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 lg_preference

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 secnotes

  data_type: 'integer'
  is_nullable: 1

=head2 area

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 blog_feed

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 main_member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 country

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 location_postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 longitude

  data_type: 'float'
  is_nullable: 1

=head2 latitude

  data_type: 'float'
  is_nullable: 1

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 comments

  data_type: 'mediumtext'
  is_nullable: 1

=head2 om_id

  data_type: 'integer'
  is_nullable: 1

=head2 renew_code

  data_type: 'text'
  is_nullable: 0

=head2 email_optout

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "memno",
  { data_type => "integer", is_nullable => 0 },
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "inits",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forename",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "surname",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "address1",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address2",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address3",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address4",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "address5",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "postcode",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "tel",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "joindate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "expdate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "class",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "assocs",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "magazine",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "cars",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "dd",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forumlogin",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forumpassword",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "forumscreenname",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "local_group",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "lg_preference",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "secnotes",
  { data_type => "integer", is_nullable => 1 },
  "area",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "blog_feed",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "main_member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "country",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "location_postcode",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "longitude",
  { data_type => "float", is_nullable => 1 },
  "latitude",
  { data_type => "float", is_nullable => 1 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "comments",
  { data_type => "mediumtext", is_nullable => 1 },
  "om_id",
  { data_type => "integer", is_nullable => 1 },
  "renew_code",
  { data_type => "text", is_nullable => 0 },
  "email_optout",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</memno>

=back

=cut

__PACKAGE__->set_primary_key("memno");

=head1 RELATIONS

=head2 area

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Memtype>

=cut

__PACKAGE__->belongs_to(
  "area",
  "ClubTriumph::Schema::Result::Memtype",
  { id => "area" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
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
  { "foreign.memberpts" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entrants

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entrant>

=cut

__PACKAGE__->has_many(
  "entrants",
  "ClubTriumph::Schema::Result::Entrant",
  { "foreign.memno" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "ClubTriumph::Schema::Result::Entry",
  { "foreign.member" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 events

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "ClubTriumph::Schema::Result::Event",
  { "foreign.organiser" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 lg_preference

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->belongs_to(
  "lg_preference",
  "ClubTriumph::Schema::Result::LocalGroup",
  { id => "lg_preference" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 local_group

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->belongs_to(
  "local_group",
  "ClubTriumph::Schema::Result::LocalGroup",
  { id => "local_group" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 local_groups

Type: has_many

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->has_many(
  "local_groups",
  "ClubTriumph::Schema::Result::LocalGroup",
  { "foreign.organiser" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 main_member

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "main_member",
  "ClubTriumph::Schema::Result::Member",
  { memno => "main_member" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 member_club_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::MemberClubRole>

=cut

__PACKAGE__->has_many(
  "member_club_roles",
  "ClubTriumph::Schema::Result::MemberClubRole",
  { "foreign.member" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 members

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->has_many(
  "members",
  "ClubTriumph::Schema::Result::Member",
  { "foreign.main_member" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 orders

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "ClubTriumph::Schema::Result::Order",
  { "foreign.member" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 registers

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Register>

=cut

__PACKAGE__->has_many(
  "registers",
  "ClubTriumph::Schema::Result::Register",
  { "foreign.memno" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 userid

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "userid",
  "ClubTriumph::Schema::Result::User",
  { id => "userid" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 users

Type: has_many

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "ClubTriumph::Schema::Result::User",
  { "foreign.memno" => "self.memno" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 club_roles

Type: many_to_many

Composing rels: L</member_club_roles> -> club_role

=cut

__PACKAGE__->many_to_many("club_roles", "member_club_roles", "club_role");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wG2ZwvoziZhu0YBHAluJGQ

#__PACKAGE__->many_to_many(club_roles => 'member_club_roles', 'club_role');

sub club_member {
	my $self = $_[0];
	return (($self->status eq 'current') || ($self->status eq 'near expiry')|| ($self->status eq 'grace period')) 
}

sub fullname
{
	my $self = $_[0];
	my $forename = ucfirst(lc $self -> forename);
	unless ($forename) {$forename = uc($self->inits)}
	my $surname = ucfirst(lc $self -> surname);
	if ($surname =~ /^Mc(.*)$/) {$surname = 'Mc'.ucfirst($1)}
	if ($surname =~ /^O'(.*)$/) {$surname = "O'".ucfirst($1)}
	my $name =  "$forename $surname";
	$name =~s/(\W)(\w{1})/$1\u$2/g;
	return $name;
}

sub formalname
{
	my $self = $_[0];
	my $title = ucfirst(lc $self -> title);
	$title =~s/(\W)(\w{1})/$1\u$2/g;
	return $title.' '.$self->fullname;

}

sub formalname_memno {
	my $self = shift;
	return $self->formalname.' ('.$self->memno.')'
}

sub title_surname 
{
	my $self = $_[0];
	my $title = ucfirst(lc $self -> title);
	my $surname = ucfirst(lc $self -> surname);
	if ($surname =~ /^Mc(.*)$/) {$surname = 'Mc'.ucfirst($1)}
	if ($surname =~ /^O'(.*)$/) {$surname = "O'".ucfirst($1)}
	my $name =  $title.' '.$surname;
	$name =~s/(\W)(\w{1})/$1\u$2/g;
	return $name;
}

sub inits_surname 
{
	my $self = $_[0];
	my $title = ucfirst(lc $self -> title);
	my $surname = ucfirst(lc $self -> surname);
	if ($surname =~ /^Mc(.*)$/) {$surname = 'Mc'.ucfirst($1)}
	if ($surname =~ /^O'(.*)$/) {$surname = "O'".ucfirst($1)}
	my $name =  $title.' '.uc($self->initials).' '.$surname;
	$name =~s/(\W)(\w{1})/$1\u$2/g;
	return $name;
}

sub memno_fullname {
	my $self = shift;
	return sprintf("%05d",$self->memno).' '.$self->fullname;
}


sub pmemno {
	my $self = $_[0];
	return sprintf ('%05s', $self->memno);
}

sub championships {
	my $self = $_[0];
	return $self->champpoints->related_resultset('championship_pt')->search({},{distinct =>1});
}

sub update_blogs {
	my ($self,$c) = @_;
	return unless ($self->blog_feed && $self->club_member && $self->userid && $self->userid->menus);
	use XML::Feed;
    my $feed = XML::Feed->parse(URI->new($self->blog_feed))
        or $c->log->debug("can't open feed ".$self->blog_feed);
	#print $feed->title, "\n";
	if ($feed && $feed->entries) {
	    foreach my $entry ($feed->entries) {
			if ($entry->id && $entry->title && $entry->content->body && $entry->issued && $entry->modified) {
				my $item = $self->result_source->schema->resultset('Item')->find_or_create({contenttype => 2, blogref => $entry->id});
				unless ($item) {die "can't find blog id ".$entry->id};
				$item->update({
					title => $entry->title,
					author => $self->userid,
					contenttype => 2,
					content => $entry->content->body,
					created => $entry->issued,
					modified => $entry->modified,
					view => 256,
					edit => 2
					});
				$item->update({created => $entry->issued});
		#		$item->update({modified => $entry->modified});
				$item->update({modified => $entry->issued});
				my $people = $c->model('ClubTriumphDB::Menu')->find({type => 'peopleroot'});
				if ($people) {$item->link_to_menu($people)} # blogs now linked to people page so they are visible to non members
				if ($self->userid && $self->userid->menus) {
#					$item->set_sortby;
		#			$item->remove_links;
					$item->link_to_menu($self->userid->profile,$self->userid);
					$item->spider($c);
				}
		    }
		}
	}

}

sub location {
	my $self = $_[0];
	return unless ($self->postcode && $self->address1);
	if (($self->postcode eq $self->location_postcode) && $self->latitude && $self->longitude) {
		return {lat => $self->latitude, lon => $self->longitude}
	}
	else {
		use Geo::Coder::OSM;
		my $geocoder = Geo::Coder::OSM->new;
#		use Geo::Coder::All;
#		my $geocoder = Geo::Coder::All->new(geocoder=>'OSM');
	#	use Geo::Coder::Googlev3;
	#	my $geocoder = Geo::Coder::Googlev3->new;
	    my $location = $geocoder->geocode(
	       { location => $self->address1.', '.$self->address2.', '.$self->address3.', '.$self->address4.', '.$self->address5.', '.$self->postcode.', '.$self->country});
	    my $coordinates = $$location{coordinates};
#	    unless ($$coordinates{lat}) {
#			my $google_geocoder = Geo::Coder::All->new();
	#	use Geo::Coder::Googlev3;
	#	my $geocoder = Geo::Coder::Googlev3->new;
#			eval {$location = $google_geocoder->geocode(
#			{ location => $self->address1.', '.$self->address2.', '.$self->address3.', '.$self->address4.', '.$self->address5.', '.$self->postcode.', '.$self->country})};
#			$coordinates = $$location{coordinates};
#		}

	    $self->update({location_postcode => $self->postcode, latitude => $$coordinates{lat}, longitude => $$coordinates{lon}});
		return $coordinates
	}
}

sub nplocation { #returns location with a random error added for privacy
	my $self = shift;
	return unless ($self->location);
	my $factor = 5; #number of miles to randomise
	my $location = $self->location;
	return {lat => $$location{lat}-$factor/60 + rand($factor/60), lon => $$location{lon}-$factor/60 + rand($factor/60)}
}


sub set_nearest_group {
	my $self = $_[0];
	return if ($self->lg_preference > 0); #don't update if manually set
	my $location = $self->location; return unless ($location && $$location{lat} && $$location{lon});
	my @group_meetings=$self->result_source->schema->resultset('GroupMeeting')->all;
	my $group_meeting;
	my $distance=40;
	foreach my $meeting (@group_meetings) {
		my $county = $self->address5;
		if ((!$meeting->local_group->county_filter || ($meeting->local_group->county_filter =~ /$county/ig)) 
		&& $meeting->distance($location) && ($meeting->distance($location)->value('miles') < $distance)) {
			$distance = $meeting->distance($location)->value('miles');
			$group_meeting = $meeting 
		}
	}
	if (defined($group_meeting)) {
		$self->update({local_group => $group_meeting->local_group});
	}
	
}

sub area_from_country {
	my $self = $_[0];
	my $country = $self->country;
	my $area = 4;
	if ($country eq 'UK') {$area = 1}
	my @eu = ('AT','BE','BG','HR','CY','CZ','DK','EE','FI','FR','DE','HU','IE','IT','LV','LT','LU','MT','NL','PL','PT','RO','SK','SI','ES','SE');
	if (grep {$_ eq $country} @eu) {$area = 3}
	$self->update({area => $area})
}

sub young_check {
	my $self = shift;
	unless ($self->dob) {return 0}
	my $age = $self->age;
	return (($age >= 17) && ($age <= 24) && !($self->memforms->count({})))
}

sub young_update {
	my $self = shift;
	return unless ($self->area->type =~ /^UK/);
	if ($self->young_check) {$self->update({area => 2}) }
	else {$self->update({area => 1}) }
}



sub new_expdate {
	my $self = shift;
	if ($self->memno && $self->club_member) {
		my $date = $self->expdate;
		$date->add(days => 1); #get round leap year problems
		$date->add(years => 1);
		$date->subtract(days => 1);
		return $date
	} 
	my $now = DateTime->today;
	if ($now->day < 15) {$now->add('years' => 1)->truncate(to => 'month')->subtract('days' => 1)}
	else {$now->add('months' => 13)->truncate(to => 'month')->subtract('days' => 1)}
	return $now;
}


sub new_memno {
	my $self = shift;
	my $now = DateTime->now;
	my $year = $now->year;
	$year -= 2000;
	my $this_year = $self->result_source->resultset->search({memno => {-between => [$year*1000,$year*1000 + 999]}});
	unless ($this_year->count({})) {return $year*1000+1}
	return $this_year->get_column('memno')->max + 1;
}



sub old_status {
	my $self = shift;
	if ( $self->club_member) {return 'current'}
	else {return 'expired'}
}

sub status {
	my ($self, $date) = @_;
	if ($self->class eq 'HON' && (! $self->expdate || ($self->expdate->epoch > time)) ) {return 'current'}
	return unless ($self->joindate && $self->expdate);
	unless ($date) {$date = DateTime->now->truncate(to => 'day')}
	if ($self->joindate->epoch > $date->epoch) {return 'future'}
	if ($self->expdate->epoch >= $date->clone->add(months => 1)->epoch) {return 'current'}
	if ($self->expdate->epoch >= $date->epoch) {return 'near expiry'}
	if ($self->expdate->epoch >= $date->clone->subtract(months => 1)->epoch) {return 'grace period'}
	else {return 'expired'}
}

sub profile {
	my $self = shift;
	if ($self->userid) {return $self->userid->profile}
}

sub TITLE { my $self= shift; return uc($self->title) }

sub INITS {
	my $self= shift;
	return uc($self->inits)
}

sub SURNAME {
	my $self= shift;
	return uc($self->surname)
}

sub ADDRESS1 {
	my $self= shift;
	return uc($self->address1)
}

sub ADDRESS2 {
	my $self= shift;
	return uc($self->address2)
}

sub ADDRESS3 {
	my $self= shift;
	return uc($self->address3)
}

sub ADDRESS4 {
	my $self= shift;
	return uc($self->address4)
}

sub ADDRESS5 {
	my $self= shift;
	return uc($self->address5)
}

sub POSTCODE {
	my $self= shift;
	return uc($self->postcode)
}

sub countryname {
	my $self = shift;
	return '' unless $self->country;
	use Geography::Countries; 
	return scalar(country($self->country))
}

sub COUNTRYNAME {
	my $self = shift;
	return '' unless $self->country;
	use Geography::Countries; 
	return uc(scalar(country($self->country)))
}

sub om_update { # updates openmeetings user database from this record.
	my ($self,$c) = @_;
	return unless ($self->email && $self->userid);
	use Digest::MD5 qw(md5 md5_hex md5_base64);
	my $om_user=0;
	if ($self->om_id ) {
		$om_user = $c->model('OpenMeetingsDB::OmUser')->find($self->om_id);
		$om_user->update({
			firstname => ucfirst(lc($self->forename)),
			lastname => ucfirst(lc($self->surname))
			});
		}
	unless ($om_user ) {
		$om_user = $c->model('OpenMeetingsDB::OmUser')->create({
			firstname => ucfirst(lc($self->forename)),
			lastname => ucfirst(lc($self->surname))
			}); 
		$om_user->get_from_storage;
		$self->update({om_id =>$om_user->id});

	}
	$om_user->update({
		login => $self->userid->username,
		language_id => 1,
		salutations_id => 1,
		time_zone_id => 'Europe/London',
		type => 'user',
		password => md5_hex($self->userid->password)
	});
	$om_user->get_from_storage;
	$c->log->debug('!!!!!!!!!!!deleted = '.scalar($om_user->deleted));
	$c->model('OpenMeetingsDB::OrganisationUser')->find_or_create({user_id => $om_user->id, organisation_id => 1});
	$c->model('OpenMeetingsDB::OmUserRight')->find_or_create({user_id => $om_user->id, om_right => 'Login'});
	$c->model('OpenMeetingsDB::OmUserRight')->find_or_create({user_id => $om_user->id, om_right => 'Dashboard'});
	$c->model('OpenMeetingsDB::OmUserRight')->find_or_create({user_id => $om_user->id, om_right => 'Room'});
	if ($om_user->adresses_id) {
		my $address = $c->model('OpenMeetingsDB::Address')->find($om_user->adresses_id);
		$address->update({email => $self->email});
	}
	else {
		my $address = $c->model('OpenMeetingsDB::Address')->create({email =>$self->email});
		$address->get_from_storage;
		$om_user->update({adresses_id => $address->id})
	}	
	
	
	
	
}

sub is_shopkeeper {
	my $self = shift;
	return $self->club_member && $self->club_roles->count({'club_role.club_role' => 'Club Shopkeeper'});
}

sub joint_addresses {
	my $self = shift;
	foreach my $ass ($self->members) {
		$ass->update({
			address1 => $self->address1,
			address1 => $self->address1,
			address2 => $self->address2,
			address3 => $self->address3,
			address4 => $self->address4,
			address5 => $self->address5,
			postcode => $self->postcode,
			longitude => $self->longitude,
			latitude => $self->latitude
			});
	}
}

sub joint_expdate {
	my $self = shift;
	foreach my $ass ($self->members) {
		$ass->update({
			expdate => $self->expdate,
			class => 'ASS'
			});
	}
}

sub cars_owned {
	my $self= $_[0];
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
	my $now = DateTime->now;
	return $self->registers->search({-or => [sold => undef, sold => {'>' => $dtf->format_datetime($now)}]});
}

sub membership_admin {
	my $self = shift;
	return ($self->club_member && $self->club_roles->count({membership_admin =>1}))
}

sub manager_of { # is member a manager of page.
	my ($self,$page) = @_;
#	return $self->club_roles->menu_managers->related_resultset('Menu')->count({pid =>$page->pid});
	return ($page->manager && $page->manager->members->count({memno => $self->memno}));
}

sub draft_entries { # returns current draft event entries
	my $self = shift;
	my $halfhourago = DateTime->now->subtract(minutes => 30);
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->entries->search({-or => [-and => [status => 'draft', created => {'>=', $dtf->format_datetime($halfhourago)}], status => 'resubmit']});
}

sub renewal_form {
	my $self = $_[0];
	my $memform_rs = $self->result_source->schema->resultset('Memform');
	my $localgroup;
	if ($self->local_group) {$localgroup = $self->local_group->id}
	my $newmember = $memform_rs->search({memno => $self->memno,renew_code => $self->renew_code, status => 'open'}, {order_by => {-desc => 'id'}})->first;
	if ($newmember) {return $newmember}
	$newmember = $memform_rs->new_result({
		memno => $self->memno,
		title => $self->title,
		forename => $self->forename,
		surname => $self->surname,
		dob => $self->dob,
		address1 => $self->address1,
		address2 => $self->address2,
		address3 => $self->address3,
		address4 => $self->address4,
		address5 => $self->address5,
		postcode => $self->postcode,
		country => $self->country,
		tel => $self->tel,
		email => $self->email,
		mobile => $self->mobile,
		area => $self->area->id,
		local_group => $localgroup,
		lg_preference => $self->lg_preference,
		status => 'open',
		renew_code => $self->renew_code
	});
	if ($self->userid) {
		$newmember->userid($self->userid->id);
	}
	$newmember->insert;

	foreach my $assoc ($self->members) {
		my $newassoc = $memform_rs->new_result({
			memno => $assoc->memno,
			title => $assoc->title,
			forename => $assoc->forename,
			surname => $assoc->surname,
			address1 => $self->address1,
			address2 => $self->address2,
			address3 => $self->address3,
			address4 => $self->address4,
			address5 => $self->address5,
			postcode => $self->postcode,
			country => $self->country,
			tel => $self->tel,
			email => $assoc->email,
			mobile => $assoc->mobile,
			area => $self->area->id,
			local_group => $localgroup,
			main_member => $newmember->id
		});
		$newassoc->insert;
	}
	return $newmember;
}

sub email_member { #send message e-mail to member
	my ($self,$subject,$message,$sender,$template) = @_;
	return unless ($self->email);
	my $c = ClubTriumph->ctx or die "Not in a request!";
	$c->stash(message => $message);
	$c->stash->{email} = {
        to      => $self->email,
        from    => $sender,
        subject => $subject,
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };
	$c->stash(member => $self, mail_template => $template);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}

sub email_reminder1 {
	my ($self,$c) =@_;
	$self->email_member('Club Triumph Membership renewal','','membership@club.triumph.org.uk','reminder1.tt2')
}

sub email_reminder2 {
	my ($self,$c) =@_;
	$self->email_member('Club Triumph Membership renewal (2nd reminder)','','membership@club.triumph.org.uk','reminder2.tt2')
}

sub email_secnotes {
	my ($self,$c) =@_;
	$self->email_member('Club Triumph Secretary\'s notes','','secretary@club.triumph.org.uk','secnotes/secnotes602.tt2')
}


sub generate_renew_code {
	my ($self ) = shift;
	if ($self->renew_code) { return $self->renew_code }
	my $now = DateTime->now;
	my $md5 = Digest::MD5->new;
	$md5->add( $self->formalname, $self->memno, $now->datetime );
	my $code = $md5->hexdigest;
	$self->update({renew_code => $code});
	return $code;
}

sub sendsms {
my ($self, $message, $sender) = @_;
return unless $self->mobile;

use Phone::Number;
my $recipient = new Phone::Number($self->mobile);
my $destination = $recipient->plain;
my $sender_number = new Phone::Number($sender);
$sender = $sender_number->plain;
my $c = ClubTriumph->ctx or die "Not in a request!";
my $password = $c->config->{'Schema::Result::SMS'}->{aql_password};
my $username = $c->config->{'Schema::Result::SMS'}->{aql_username};
my $querystring= "http://gw.aql.com/sms/sms_gw.php?username=$username&password=$password&originator=$sender&destination=".$destination."&message=$message";
use LWP::Simple;
my $response = get($querystring);

my $logfile = $c->path_to('root','log').'/messagelog.log';
open (LOG,">>$logfile");
print LOG "$querystring $response\n";
close LOG;
return $response;
}

sub initials {
my $self = shift;
if ($self->inits) {return $self->inits};
my $inits;
foreach my $forename (split(/ /,$self->forename)) {
	$forename =~ /(^\w)/;
	$inits .= uc($1).' ' if ($1)
	}
$inits =~ s/ $//;
return $inits;
}

sub firstname {
	my $self = shift;
	my @names = split(/ /,$self->forename);
	return ucfirst(lc($names[0]))
}

before 'insert' => sub {
	my $self = shift;
	unless ($self->memno) {
		$self->memno($self->new_memno)
	}
	$self->joindate(DateTime->today());
};


after 'update' => sub {
	my $self = shift;
	return unless ($self->postcode);
	unless ($self->location_postcode && ($self->postcode eq $self->location_postcode)) {
		$self->location
	}
	if ($self->userid) {
		$self->userid->update({
			first_name => $self->forename,
			last_name => $self->surname
		});
		if ($self->email) {
			$self->userid->update({
				email => $self->email
			});
		}
	}
			
#	if ($self->latitude && $self->longitude && ! $self->local_group) {
#		$self->set_nearest_group;
#	}
};



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
