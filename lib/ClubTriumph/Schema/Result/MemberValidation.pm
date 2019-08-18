use utf8;
package ClubTriumph::Schema::Result::MemberValidation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::MemberValidation

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

=head1 TABLE: C<member_validation>

=cut

__PACKAGE__->table("member_validation");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 membership_no

  data_type: 'text'
  is_nullable: 1

=head2 address1

  data_type: 'text'
  is_nullable: 1

=head2 town

  data_type: 'text'
  is_nullable: 1

=head2 country

  data_type: 'text'
  is_nullable: 1

=head2 postcode

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 forename

  data_type: 'text'
  is_nullable: 1

=head2 surname

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "membership_no",
  { data_type => "text", is_nullable => 1 },
  "address1",
  { data_type => "text", is_nullable => 1 },
  "town",
  { data_type => "text", is_nullable => 1 },
  "country",
  { data_type => "text", is_nullable => 1 },
  "postcode",
  { data_type => "text", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "forename",
  { data_type => "text", is_nullable => 1 },
  "surname",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-20 18:44:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f3cpPLg3fyELu9XUbAzhMQ

sub check {
	my $self = shift;
	unless ($self->membership_no =~ /^\d{1,5}$/) {return 0}
	my $member = $self->result_source->schema->resultset('Member')->find({memno => $self->membership_no});
	return 0 unless $member;
	my $address1 = $self->address1;
	$address1 =~ s/ Rd$/ Road/ig;
	$address1 =~ s/ Ave$/ Avenue/ig;
	$address1 =~ s/ Gdns$/ Gardens/ig;
	return ((uc($self->postcode) eq uc($member->postcode)) && 
		(uc($address1) eq uc($member->address1)) &&
		($self->country eq $member->country) &&
		(uc($self->town) eq uc($member->address4)) &&
		(uc($self->email) eq uc($member->email)) &&
		(uc($self->forename) eq uc($member->forename)) &&
		(uc($self->surname) eq uc($member->surname)))

}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
