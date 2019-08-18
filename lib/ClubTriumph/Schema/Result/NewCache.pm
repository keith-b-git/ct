use utf8;
package ClubTriumph::Schema::Result::NewCache;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::NewCache

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

=head1 TABLE: C<new_cache>

=cut

__PACKAGE__->table("new_cache");

=head1 ACCESSORS

=head2 menu_item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 level

  data_type: 'integer'
  is_nullable: 1

=head2 count

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_nullable: 1

=head2 lcount

  data_type: 'integer'
  is_nullable: 1

=head2 sortby

  data_type: 'integer'
  is_nullable: 1

=head2 latest

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 latloc

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "menu_item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "level",
  { data_type => "integer", is_nullable => 1 },
  "count",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "integer", is_nullable => 1 },
  "lcount",
  { data_type => "integer", is_nullable => 1 },
  "sortby",
  { data_type => "integer", is_nullable => 1 },
  "latest",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "latloc",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 latest

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "latest",
  "ClubTriumph::Schema::Result::Item",
  { id => "latest" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 latloc

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "latloc",
  "ClubTriumph::Schema::Result::Item",
  { id => "latloc" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 menu_item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "menu_item",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "menu_item" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-05 17:38:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KYiFTN0uiQXXi+aaeZNvig



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
