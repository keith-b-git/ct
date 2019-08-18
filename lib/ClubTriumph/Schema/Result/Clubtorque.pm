use utf8;
package ClubTriumph::Schema::Result::Clubtorque;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Clubtorque

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

=head1 TABLE: C<clubtorque>

=cut

__PACKAGE__->table("clubtorque");

=head1 ACCESSORS

=head2 edition

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("edition", { data_type => "integer", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</edition>

=back

=cut

__PACKAGE__->set_primary_key("edition");

=head1 RELATIONS

=head2 articles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Article>

=cut

__PACKAGE__->has_many(
  "articles",
  "ClubTriumph::Schema::Result::Article",
  { "foreign.articleedition" => "self.edition" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.club_torque" => "self.edition" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-12-30 15:13:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vS5I4Mcz76gT2tg0fm4rSQ

sub title {
	my $self = shift;
	my $edition = $self->edition + 2;
	my $volume = int(($edition - 1) / 6) + 3;
	my $month = $edition % 6;
	my @fullmons = ('November','January','March','May','July','September','November');
	my $year = $volume + 1965;
	return "Club Torque $fullmons[$month] $year, Volume $volume, Number ".$self->edition;
}

sub size { #returns size of file
	my ($self,$c) = @_;
	my $ctdir = $c->path_to('data',$c->config->{'Controller::Clubtorque'}->{clubtorque_dir}).'/';
	my $file = $ctdir.$self->edition.'.pdf';
	unless (-e $file) {return 0}
	return (stat $file)[7];
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
