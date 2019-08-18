package ClubTriumph::View::CSV;

use base qw ( Catalyst::View::CSV );
use strict;
use warnings;

__PACKAGE__->config ( sep_char => ",", suffix => "csv", binary => 1 );

=head1 NAME

ClubTriumph::View::CSV - CSV view for ClubTriumph

=head1 DESCRIPTION

CSV view for ClubTriumph

=head1 SEE ALSO

L<ClubTriumph>, L<Catalyst::View::CSV>, L<Text::CSV>

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
