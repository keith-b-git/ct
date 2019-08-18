package ClubTriumph::Field::Permissions;
 
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Compound';
 
has_field 'month' => (type => 'Integer');
has_field 'day' => ( type => 'Integer' );
has_field 'minutes' => ( type => 'Integer' );

1;
