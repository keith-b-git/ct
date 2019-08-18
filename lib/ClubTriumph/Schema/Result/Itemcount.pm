use utf8;
package ClubTriumph::Schema::Result::Itemcount;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Itemcount

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

=head1 TABLE: C<itemcount>

=cut

__PACKAGE__->table("itemcount");

=head1 ACCESSORS

=head2 contenttype

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 menu_item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 c1

  data_type: 'integer'
  is_nullable: 1

=head2 c2

  data_type: 'integer'
  is_nullable: 1

=head2 c4

  data_type: 'integer'
  is_nullable: 1

=head2 c8

  data_type: 'integer'
  is_nullable: 1

=head2 c16

  data_type: 'integer'
  is_nullable: 1

=head2 c32

  data_type: 'integer'
  is_nullable: 1

=head2 c64

  data_type: 'integer'
  is_nullable: 1

=head2 c128

  data_type: 'integer'
  is_nullable: 1

=head2 c256

  data_type: 'integer'
  is_nullable: 1

=head2 c512

  data_type: 'integer'
  is_nullable: 1

=head2 l1

  data_type: 'integer'
  is_nullable: 1

=head2 l2

  data_type: 'integer'
  is_nullable: 1

=head2 l4

  data_type: 'integer'
  is_nullable: 1

=head2 l8

  data_type: 'integer'
  is_nullable: 1

=head2 l16

  data_type: 'integer'
  is_nullable: 1

=head2 l32

  data_type: 'integer'
  is_nullable: 1

=head2 l64

  data_type: 'integer'
  is_nullable: 1

=head2 l128

  data_type: 'integer'
  is_nullable: 1

=head2 l256

  data_type: 'integer'
  is_nullable: 1

=head2 l512

  data_type: 'integer'
  is_nullable: 1

=head2 lat1

  data_type: 'integer'
  is_nullable: 1

=head2 lat2

  data_type: 'integer'
  is_nullable: 1

=head2 lat4

  data_type: 'integer'
  is_nullable: 1

=head2 lat8

  data_type: 'integer'
  is_nullable: 1

=head2 lat16

  data_type: 'integer'
  is_nullable: 1

=head2 lat32

  data_type: 'integer'
  is_nullable: 1

=head2 lat64

  data_type: 'integer'
  is_nullable: 1

=head2 lat128

  data_type: 'integer'
  is_nullable: 1

=head2 lat256

  data_type: 'integer'
  is_nullable: 1

=head2 lat512

  data_type: 'integer'
  is_nullable: 1

=head2 loc1

  data_type: 'integer'
  is_nullable: 1

=head2 loc2

  data_type: 'integer'
  is_nullable: 1

=head2 loc4

  data_type: 'integer'
  is_nullable: 1

=head2 loc8

  data_type: 'integer'
  is_nullable: 1

=head2 loc16

  data_type: 'integer'
  is_nullable: 1

=head2 loc32

  data_type: 'integer'
  is_nullable: 1

=head2 loc64

  data_type: 'integer'
  is_nullable: 1

=head2 loc128

  data_type: 'integer'
  is_nullable: 1

=head2 loc256

  data_type: 'integer'
  is_nullable: 1

=head2 loc512

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "contenttype",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "menu_item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "c1",
  { data_type => "integer", is_nullable => 1 },
  "c2",
  { data_type => "integer", is_nullable => 1 },
  "c4",
  { data_type => "integer", is_nullable => 1 },
  "c8",
  { data_type => "integer", is_nullable => 1 },
  "c16",
  { data_type => "integer", is_nullable => 1 },
  "c32",
  { data_type => "integer", is_nullable => 1 },
  "c64",
  { data_type => "integer", is_nullable => 1 },
  "c128",
  { data_type => "integer", is_nullable => 1 },
  "c256",
  { data_type => "integer", is_nullable => 1 },
  "c512",
  { data_type => "integer", is_nullable => 1 },
  "l1",
  { data_type => "integer", is_nullable => 1 },
  "l2",
  { data_type => "integer", is_nullable => 1 },
  "l4",
  { data_type => "integer", is_nullable => 1 },
  "l8",
  { data_type => "integer", is_nullable => 1 },
  "l16",
  { data_type => "integer", is_nullable => 1 },
  "l32",
  { data_type => "integer", is_nullable => 1 },
  "l64",
  { data_type => "integer", is_nullable => 1 },
  "l128",
  { data_type => "integer", is_nullable => 1 },
  "l256",
  { data_type => "integer", is_nullable => 1 },
  "l512",
  { data_type => "integer", is_nullable => 1 },
  "lat1",
  { data_type => "integer", is_nullable => 1 },
  "lat2",
  { data_type => "integer", is_nullable => 1 },
  "lat4",
  { data_type => "integer", is_nullable => 1 },
  "lat8",
  { data_type => "integer", is_nullable => 1 },
  "lat16",
  { data_type => "integer", is_nullable => 1 },
  "lat32",
  { data_type => "integer", is_nullable => 1 },
  "lat64",
  { data_type => "integer", is_nullable => 1 },
  "lat128",
  { data_type => "integer", is_nullable => 1 },
  "lat256",
  { data_type => "integer", is_nullable => 1 },
  "lat512",
  { data_type => "integer", is_nullable => 1 },
  "loc1",
  { data_type => "integer", is_nullable => 1 },
  "loc2",
  { data_type => "integer", is_nullable => 1 },
  "loc4",
  { data_type => "integer", is_nullable => 1 },
  "loc8",
  { data_type => "integer", is_nullable => 1 },
  "loc16",
  { data_type => "integer", is_nullable => 1 },
  "loc32",
  { data_type => "integer", is_nullable => 1 },
  "loc64",
  { data_type => "integer", is_nullable => 1 },
  "loc128",
  { data_type => "integer", is_nullable => 1 },
  "loc256",
  { data_type => "integer", is_nullable => 1 },
  "loc512",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</contenttype>

=item * L</menu_item>

=back

=cut

__PACKAGE__->set_primary_key("contenttype", "menu_item");

=head1 RELATIONS

=head2 contenttype

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Contenttype>

=cut

__PACKAGE__->belongs_to(
  "contenttype",
  "ClubTriumph::Schema::Result::Contenttype",
  { id => "contenttype" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 menu_item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "menu_item",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "menu_item" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-02-14 13:50:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/LbvSZk9LU5JxguzZn1OqA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
