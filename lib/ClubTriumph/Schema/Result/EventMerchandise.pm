use utf8;
package ClubTriumph::Schema::Result::EventMerchandise;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::EventMerchandise

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

=head1 TABLE: C<event_merchandise>

=cut

__PACKAGE__->table("event_merchandise");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 event

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 moptions

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 visible

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "event",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "moptions",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "visible",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entry_merchandises

Type: has_many

Related object: L<ClubTriumph::Schema::Result::EntryMerchandise>

=cut

__PACKAGE__->has_many(
  "entry_merchandises",
  "ClubTriumph::Schema::Result::EntryMerchandise",
  { "foreign.merchandise" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 event

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "ClubTriumph::Schema::Result::Event",
  { id => "event" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LGFjj+esvPICCskU/rKMIw

sub options_list {
	my $self = shift;
	my @options;
	foreach my $option (split( /\n/,$self->moptions)) {
		$option =~ s/[\000-\037]//g;
		push @options, $option;
	}
	return \@options;
}

sub total {
	my ($self,$option) = @_;
	return $self->entry_merchandises->count({moption => $option});
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
