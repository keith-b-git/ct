package ClubTriumph::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
    
);

=head1 NAME

ClubTriumph::View::Email - Email View for ClubTriumph

=head1 DESCRIPTION

View for sending email from ClubTriumph. 

=head1 AUTHOR

Keith Bennett

=head1 SEE ALSO

L<ClubTriumph>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
