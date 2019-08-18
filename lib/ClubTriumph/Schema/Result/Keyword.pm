use utf8;
package ClubTriumph::Schema::Result::Keyword;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Keyword

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

=head1 TABLE: C<keywords>

=cut

__PACKAGE__->table("keywords");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 word

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 idf

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "word",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "idf",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</word>

=back

=cut

__PACKAGE__->set_primary_key("id", "word");

=head1 RELATIONS

=head2 wordcounts

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Wordcount>

=cut

__PACKAGE__->has_many(
  "wordcounts",
  "ClubTriumph::Schema::Result::Wordcount",
  { "foreign.word" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2014-12-31 14:12:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AXQu8AuPvvneRmKL1RNNuw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
