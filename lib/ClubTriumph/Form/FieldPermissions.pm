package ClubTriumph::Field::Permissions;
use Moose;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Compound';
 
has_field 'members' => (type => 'Select');

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;
