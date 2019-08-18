use utf8;
package ClubTriumph::Schema::Result::Contenttype;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Contenttype

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

=head1 TABLE: C<contenttypes>

=cut

__PACKAGE__->table("contenttypes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 displaytype

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 search_cat

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 list_type

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 replyable

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "displaytype",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "search_cat",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "list_type",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "replyable",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 club_roles

Type: has_many

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->has_many(
  "club_roles",
  "ClubTriumph::Schema::Result::ClubRole",
  { "foreign.editor_of" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 itemcounts

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Itemcount>

=cut

__PACKAGE__->has_many(
  "itemcounts",
  "ClubTriumph::Schema::Result::Itemcount",
  { "foreign.contenttype" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items",
  "ClubTriumph::Schema::Result::Item",
  { "foreign.contenttype" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-16 10:40:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6Fx5TyjYEm8zmJxl3kkLuw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
