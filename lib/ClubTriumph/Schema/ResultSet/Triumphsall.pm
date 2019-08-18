package ClubTriumph::Schema::ResultSet::Triumphsall;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub all_triumphs {
	my $self = $_[0];
	my $home = $self->get_column('home')->sum;
	my $export = $self->get_column('export')->sum;
	my $on_register = $self->result_source->schema->resultset('Register')->count;
	my $in_club = $self->result_source->schema->resultset('Register')->in_club;
	my $first = $self->get_column('first')->min;
	my $last = $self->get_column('last')->max;
	use DateTime::Format::ISO8601;
	$first = DateTime::Format::ISO8601->parse_datetime($first) if $first;
	$last = DateTime::Format::ISO8601->parse_datetime($last) if $last;
	return {
		'home' => $home,
		'export' => $export,
		'on_register' => $on_register,
		'in_club' => $in_club,
		'first' => $first,
		'last' => $last
		}
}
 
1;

