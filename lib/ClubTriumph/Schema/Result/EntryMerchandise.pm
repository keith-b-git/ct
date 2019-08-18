use utf8;
package ClubTriumph::Schema::Result::EntryMerchandise;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::EntryMerchandise

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

=head1 TABLE: C<entry_merchandise>

=cut

__PACKAGE__->table("entry_merchandise");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 merchandise

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 entry

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 1

=head2 entrant

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 moption

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "merchandise",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "entry",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
  "entrant",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "moption",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entry

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "entry",
  "ClubTriumph::Schema::Result::Entry",
  { id => "entry" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 merchandise

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::EventMerchandise>

=cut

__PACKAGE__->belongs_to(
  "merchandise",
  "ClubTriumph::Schema::Result::EventMerchandise",
  { id => "merchandise" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-02 13:27:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N4GCvR1KaDx9wcUfHknOHw

sub find_entrant {
	my $self = shift;
	return $self->entry->entrants->find({id => $self->entrant});
}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
