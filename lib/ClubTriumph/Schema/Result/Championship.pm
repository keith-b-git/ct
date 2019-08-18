use utf8;
package ClubTriumph::Schema::Result::Championship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Championship

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

=head1 TABLE: C<championships>

=cut

__PACKAGE__->table("championships");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 year

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "year",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 champpoints

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Champpoint>

=cut

__PACKAGE__->has_many(
  "champpoints",
  "ClubTriumph::Schema::Result::Champpoint",
  { "foreign.championship_pts" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 events

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "ClubTriumph::Schema::Result::Event",
  { "foreign.challenge" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.championship" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-11-24 17:26:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Th7DxOu3P2n7ToSzpAoepA

sub sum {
	my ($self, $member) =@_;
	return $self->related_resultset('champpoints')->search({memberpts => $member->memno})->get_column('points')->sum
}

sub position {
	my ($self, $member) =@_;
	my $pos = 1;
	my $points = $self->sum($member);
	my $equal = '';
	foreach my $contender ($self->champpoints->search_related('memberpt',{},{distinct =>1})) {
		if ($self->sum($contender) > $points) {$pos ++}
		if (($self->sum($contender) == $points) && ($contender->memno != $member->memno)) {$equal = '='}
	}
	my $ending = 'th';
	my $mod = $pos % 10;
	if (($mod == 1) && ($pos != 11)) {$ending = 'st'}
	if (($mod == 2) && ($pos != 12)) {$ending = 'nd'}
	if (($mod == 3) && ($pos != 13)) {$ending = 'rd'}
	return $equal.$pos.$ending
}


sub leaderboard {
	my $self = $_[0];
	my %points;
	my @leaderboard;
	my @members = $self->related_resultset('champpoints')->related_resultset('memberpt')->search({},{distinct => 1});
	foreach my $member (@members) {
		$points{$member} = $self->sum($member);
		if ($points{$member} >0 ) {
			push (@leaderboard,{'member' => $member,'points' => $points{$member}})
		}
	}
	@leaderboard = sort {$$b{points} <=> $$a{points}} @leaderboard;
	my $pos = 1;
	my $prev = 0;
	my $i = 0;
	while ($leaderboard[$i]) {
		if ($leaderboard[$i]{points} < $prev) {$pos ++}
		$leaderboard[$i]{position} = $pos;
		$prev = $leaderboard[$i]{points};
		$i++;
	}
	return \@leaderboard;
}

sub points {
	my ($self,$member,$event) = @_;
	my $points;
	if ($points = $self->champpoints->find({eventpts => $event->id, memberpts => $member->memno})) {
		return $points->points
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
