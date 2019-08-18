use utf8;
package ClubTriumph::Schema::Result::Entrant;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Entrant

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

=head1 TABLE: C<entrants>

=cut

__PACKAGE__->table("entrants");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 team

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 memno

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "team",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "memno",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 team

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "team",
  "ClubTriumph::Schema::Result::Entry",
  { id => "team" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
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
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-10-10 16:44:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:elB/ypj8BhqYlXlT9Fln7A

sub sendsms {
my ($self, $message, $sender) = @_;
return unless $self->mobile;
my $c = ClubTriumph->ctx or die "Not in a request!";
my $password = $c->config->{'Schema::Result::SMS'}->{aql_password};
my $username = $c->config->{'Schema::Result::SMS'}->{aql_username};
my $querystring= "http://gw.aql.com/sms/sms_gw.php?username=$username&password=$password&originator=$sender&destination=".$self->mobile."&message=$message";
my $response = get($querystring);
#open (LOG,">>$logfile");
#print LOG "$querystring $response\n";
#close LOG;
return $response;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
