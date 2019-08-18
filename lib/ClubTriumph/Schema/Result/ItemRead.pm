use utf8;
package ClubTriumph::Schema::Result::ItemRead;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::ItemRead

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

=head1 TABLE: C<item_read>

=cut

__PACKAGE__->table("item_read");

=head1 ACCESSORS

=head2 item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 last_read

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "last_read",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</item>

=item * L</user>

=back

=cut

__PACKAGE__->set_primary_key("item", "user");

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "ClubTriumph::Schema::Result::Item",
  { id => "item" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 user

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "ClubTriumph::Schema::Result::User",
  { id => "user" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2015-11-30 13:50:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8dz+cbdLL1yhFBAInvq1rg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
