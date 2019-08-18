package ClubTriumph::View::HTML;
use Moose;
use namespace::autoclean;
use Geography::Countries;
use Lingua::EN::Inflexion qw< noun inflect >;
use utf8;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
        INCLUDE_PATH => [
            ClubTriumph->path_to( 'root', 'src' ),
        ],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.tt2',
    RECURSION => 0,
    EVAL_PERL => 1,
	ENCODING     => 'utf-8',
    FILTERS => {'highlight'  => [\&highlight,1],
				'searchresult'  => [\&searchresult,1],
				'countryname'  => [\&countryname,1],
				'dateformat'  => [\&dateformat,1],
				'utf8en'  => [\&utf8en,1],
				'inflect'  => [\&myinflect,1],
				'cc_expand'  => [\&cc_expand,1],
				'html_strip'  => [\&html_strip,1],
				'lf_to_br'  => [\&lf_to_br,1],
				'html_scrub'  => [\&html_scrub,1]}
);

use Template::Filters;  # Need to use, so that we can have access to $Template::Filters::FILTERS
$Template::Filters::FILTERS->{escape_js} = \&escape_js_string;

sub escape_js_string {
    my $s = shift;
    $s =~ s/(\\|'|"|\/)/\\$1/g;
    return $s;
};





#$Template::Filters::FILTERS->{highlight} = [\&highlight,1];
#$Template::Filters::FILTERS->{highlight}  = [\&highlight, 1];
#my $context = $Template::Filters::FILTERS->context();

#$context->define_filter('highlight', \&highlight, 1);

sub highlight {
    my ($context, $search) = @_;
    return sub {
		my $text = shift;
		unless ($search) {return $text}
		$search = lc($search);
		my @searchwords= $search =~ /(\w+(?:[-'\/]\w+)*)/g;
		my $match = join('|',@searchwords);
		$text =~ s/($match)/<span class ="highlight">$1<\/span>/sig;
		return $text;
	}
}



sub searchresult {
    my ($context, $search) = @_;
    return sub {
		my $text = shift;
		$text =~ tr/\040-\176/ /c;
#		unless ($search) {return $text}
		$search = lc($search);
		my @searchwords= $search =~ /(\w+(?:[-'\/]\w+)*)/g;
		my $match = join('|',@searchwords);#.'|$';
		my $finaltext = '';
		my $done = 0;
		while ($text =~ /$match/ig) {
			$text =~ s/(^.*?)(.{0,50}?\W)($match)(\W.*?$)/$4/sig; #(.*?$)
			if ($1) {
				if ($finaltext) { $finaltext .= substr ($1,0,50) }
				if (length($1) > 50) {$finaltext .= '...'}
			}
			$finaltext .= "$2<span class = \"highlight\">$3<\/span>";
		}
		$text =~ /(.{0,50})(.*?$)/sig;
		$finaltext .=$1;
		if ($2) {$finaltext .= '...'}
		return $finaltext;
	}
}

sub countryname {
    return sub {
		my $country = shift;
		return country($country)
	}
}

sub dateformat {
	my ($context,$type) = @_;
	return sub {
		my $data = shift;
		return unless $data;
#		my $date = DateTime->from object(object => $data);
		my $date = DateTime::Format::ISO8601->parse_datetime( $data );
		my $text;
		my $duration = DateTime->now( time_zone => "UTC")->subtract_datetime($date);
		my ($minutes,$hours,$days,$weeks,$months,$years) = $duration->in_units('minutes','hours','days','weeks','months','years');
		if ($weeks || $months || $years) {
			$text = $date->day_abbr.' ';
			$text .=$date->day;
			use Switch;
			switch ($date->day) {
				case ['',' ','   '] {}
				case [1,21,31] {$text .= 'st'}
				case [2,22] {$text .= 'nd'}
				case [3,23] {$text .= 'rd'}
				else {$text .= 'th'}
			}
			$text .= ' '.$date->month_abbr.' '.$date->year;
#			$text .= ' '.$date->hour_12.':'.$date->min.lc($date->am_or_pm);
			if ($type eq 'date_time') {$text .=  ' '.$date->hour_12.':'.sprintf('%02d',$date->min).lc($date->am_or_pm)}
		}
		else {
			if ($days < 1) {
				if ($hours < 1) {
					if ($minutes < 1) {$text = 'less than a minute ago'}
					elsif ($minutes < 2) {$text .= 'a minute ago'}
					else  {$text .= $minutes.' minutes ago'}
				}
				elsif ($hours < 2) {$text = 'an hour ago'}
				else  {$text = $hours.' hours ago'}
			}
			else {		
				$text = $date->day_name.' '.$date->hour_12.':'.sprintf('%02d',$date->min).lc($date->am_or_pm);
				}
		}
		return $text;
		}
	
	}

sub utf8en {
    return sub {
		my $stuff = shift;
		use Unicode::UTF8 qw[decode_utf8 encode_utf8];
		return decode_utf8($stuff)
	}
}

sub myinflect {
    return sub {
		my $text = shift;
		my $stuff = inflect $text;
		return $stuff
	}
}

sub cc_expand {
    return sub {
		my $licence = shift;
		use Switch;
		switch ($licence) {
			case 'CC BY' {return "<a href = 'https://creativecommons.org/licenses/by/4.0/'>Attribution</a>"}
			case 'CC BY-SA' {return "<a href = 'https://creativecommons.org/licenses/by-sa/4.0/'>Attribution ShareAlike</a>"}
			case 'CC BY-ND' {return "<a href = 'https://creativecommons.org/licenses/by-nd/4.0/'>Attribution-NoDerivs</a>"}
			case 'CC BY-NC' {return "<a href = 'https://creativecommons.org/licenses/by-nc/4.0/'>Attribution-NonCommercial</a>"}
			case 'CC BY-NC-SA' {return "<a href = 'https://creativecommons.org/licenses/by-nc-sa/4.0/'>Attribution-NonCommercial-ShareAlike</a>"}
			case 'CC BY-NC-ND' {return "<a href = 'https://creativecommons.org/licenses/by-nc-nd/4.0/'>Attribution-NonCommercial-NoDerivs</a>"}
			case 'reserved' {return 'All Rights Reserved'}
			case 'public' {return 'Public Domain'}
			case 'other' {return 'Other'}
		}
	}
}

sub html_strip {
    return sub {
		my $stuff = shift;
	use HTML::Strip;
	my $hs = HTML::Strip->new();
	return $hs->parse($stuff);
	}
}

sub lf_to_br {
    return sub {
		my $stuff = shift;
	$stuff =~ s/\n/<br>/g;
	return $stuff;
	}
}

sub html_scrub {
	    return sub {
		my $s = shift;
	    use HTML::Scrubber;
	    my $scrubber = HTML::Scrubber->new;
	    return $scrubber->scrub($s)
	}
}

=head1 NAME

ClubTriumph::View::HTML - TT View for ClubTriumph

=head1 DESCRIPTION

TT View for ClubTriumph.

=head1 SEE ALSO

L<ClubTriumph>

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
