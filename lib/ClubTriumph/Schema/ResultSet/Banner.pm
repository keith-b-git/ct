package ClubTriumph::Schema::ResultSet::Banner;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';


sub next {
	my ($self, $type, $c) = @_;
	my $current = 0;
	if ($c->session->{"banner_$type"}) {
		$current = $c->session->{"banner_$type"}
	}
	my $next = $self->search({id => {'>' => $current}, "image_$type" => {'!=' => undef}, "url_$type" => {'!=' => undef}, active => 1},{order_by => 'id'})->single;
	if ($next) {
		$c->session("banner_$type" => $next->id);
		return $next
		}
	if ($c->session->{"banner_$type"} > 0) {
		$next = $self->search({"image_$type" => {'!=' => undef}, "url_$type" => {'!=' => undef}, active => 1},{order_by => 'id'})->single;
		if ($next) {
			$c->session("banner_$type" => $next->id);
			return $next
		}
	}
}

1;
 
