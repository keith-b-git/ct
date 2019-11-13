use utf8;
package ClubTriumph::Schema::Result::Memform;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Memform

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

=head1 TABLE: C<memforms>

=cut

__PACKAGE__->table("memforms");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

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
  size: 10

=head2 tel

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 area

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 main_member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 local_group

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 lg_preference

  data_type: 'integer'
  is_nullable: 1

=head2 payment_method

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 payment_reference

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 amount_due

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 amount_paid

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 country

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 memno

  data_type: 'integer'
  is_nullable: 1

=head2 status

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 renew_code

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
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
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "tel",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "area",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "main_member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "local_group",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "lg_preference",
  { data_type => "integer", is_nullable => 1 },
  "payment_method",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "payment_reference",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "amount_due",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "amount_paid",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "country",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "memno",
  { data_type => "integer", is_nullable => 1 },
  "status",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "renew_code",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

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

=head2 main_member

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->belongs_to(
  "main_member",
  "ClubTriumph::Schema::Result::Memform",
  { id => "main_member" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 memforms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->has_many(
  "memforms",
  "ClubTriumph::Schema::Result::Memform",
  { "foreign.main_member" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 orders

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "ClubTriumph::Schema::Result::Order",
  { "foreign.memform" => "self.id" },
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
    on_delete     => "SET NULL",
    on_update     => "SET NULL",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kbLKVQptD3YfWnsrZBHN1Q

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
);



sub total {
	my $self = shift;
	my $total = $self->area->fee + $self->join_fee + $self->memforms->count({}) * $self->area->ass_fee;
	return $total;
}

sub join_fee { #calculate whether joining fee is due or if applicant is already a member
	my $self = shift; 
	return unless $self->area;
	unless ($self->memno) {return $self->area->joinfee}
	my $c = ClubTriumph->ctx or die "Not in a request!";
	if ($c->user && $c->user->memno && $c->user->memno->memno == $self->memno) {return 0}
#	if ($c->action eq 'member/email_renew') {return 0}
	my $member = $self->result_source->schema->resultset('Member')->find($self->memno);
	if ($member &&
		$member->memno &&
	$member->club_member &&
		((uc($self->surname) eq uc($member->surname)) &&
		(uc($self->postcode) eq uc($member->postcode))) ||
		($c->user && $c->user->memno && $c->user->memno->memno == $self->memno) ||
		($self->renew_code && ($self->renew_code eq $member->renew_code))
		)
		{return 0}
	else
		{return $self->area->joinfee}
}


sub age {
	my $self = shift;
	my $age = DateTime->now->subtract_datetime($self->dob)->years;
	return $age;
}

sub young_check {
	my $self = shift;
	unless ($self->dob) {return 0}
	my $age = $self->age;
	return (($age >= 17) && ($age <= 24) )
}

sub young_update {
	my $self = shift;
	return unless ($self->area->type =~ /^UK/);
	if ($self->young_check) {$self->update({area => 2}) }
	else {$self->update({area => 1}) }
}
	

sub location {
	my $self = $_[0];
	use Geo::Coder::OSM;
	my $geocoder = Geo::Coder::OSM->new;
    my $location = $geocoder->geocode(
        location => $self->address1.', '.$self->address2.', '.$self->address3.', '.$self->address4.', '.$self->address5.', '.$self->postcode);
	return $location
	
}

sub set_nearest_group {
	my $self = $_[0];
	my $location = $self->location; return unless $location;
	my @group_meetings=$self->result_source->schema->resultset('GroupMeeting')->all;
	my $group_meeting;
	my $distance=100;
	foreach my $meeting (@group_meetings) {
		if ($meeting->distance($location) && ($meeting->distance($location)->value('miles') < $distance)) {
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
	if ($country eq 'GB') {$area = 1}
	my @eu = ('AT','BE','BG','HR','CY','CZ','DK','EE','FI','FR','DE','GR','HU','IE','IT','LV','LT','LU','MT','NL','PL','PT','RO','SK','SI','ES','SE');
	if (grep {$_ eq $country} @eu) {$area = 3}
	$self->update({area => $area})
}

sub process_application {
	my $self = $_[0];
	my $members_rs = $self->result_source->schema->resultset('Member');
	my $local_group;
	if ($self->local_group) {$local_group = $self->local_group->id}
	my $newmember = $members_rs->find_or_new({
		memno => $self->memno},{key => 'primary'});
	$newmember->set_columns({
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
		local_group => $local_group,
		lg_preference => $self->lg_preference,
		class => 'ORD'
	});
	$newmember->expdate($newmember->new_expdate);
	if ($self->userid) {
		$newmember->userid($self->userid->id);
	}
#	if ($self->area != 2) 
		{$newmember->magazine(1)}
	if ($newmember->in_storage) {
		foreach my $assoc ($newmember->members) {
			$assoc->update ({main_member => undef })
		}
	}
	my $member = $newmember->insert_or_update;
	if ($self->userid) {
		$self->userid->update({memno => $newmember->get_from_storage->memno})}
	foreach my $assoc ($self->memforms) {
		my $newassoc = $members_rs->find_or_new({
			memno => $assoc->memno},{key => 'primary'});
		$newassoc->set_columns({
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
			local_group => $local_group,
			class => 'ASS',
			main_member => $member->memno
		});
		$newassoc->expdate($newassoc->new_expdate);
		if ($assoc->userid) {$newassoc->userid(userid->id);
		$newassoc->userid->memno($newassoc->memno)}
		$newassoc->insert_or_update;
			
	}
	my $message = '';
	if ($self->join_fee) { 
		$member->email_member('Your Club Triumph membership',$message,'membership@club.triumph.org.uk','join_thankyou.tt2');
	}
	else {
		$member->email_member('Your Club Triumph membership',$message,'membership@club.triumph.org.uk','renewal_thankyou.tt2');
	}
	$self->update({status => 'processed'});
	return $member;
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

sub members { # slight bodge to make group form work.
	my $self = $_[0];
	return $self->memforms;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
