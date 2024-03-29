package ClubTriumph::Model::ClubTriumphDB;
use utf8;
use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'ClubTriumph::Schema',
    
    connect_info => {

#        dsn => 'dbi:mysql:clubtriumph',
#        user => 'clubtriumph',
        dsn => 'dbi:mysql:clubtriu_mph',
        user => 'clubtriu_mph',
        password => '',
        AutoCommit => q{1},
		RaiseError        => 1,
		mysql_enable_utf8mb4 => 1,
		on_connect_do     => [
			'SET NAMES utf8mb4',
		],
    }
);

=head1 NAME

ClubTriumph::Model::ClubTriumphDB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<ClubTriumph>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<ClubTriumph::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
