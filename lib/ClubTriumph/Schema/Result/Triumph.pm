use utf8;
package ClubTriumph::Schema::Result::Triumph;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Triumph

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

=head1 TABLE: C<triumphs>

=cut

__PACKAGE__->table("triumphs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 model

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 mark

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "model",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "mark",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 mark

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Mark>

=cut

__PACKAGE__->belongs_to(
  "mark",
  "ClubTriumph::Schema::Result::Mark",
  { id => "mark" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 model

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Model>

=cut

__PACKAGE__->belongs_to(
  "model",
  "ClubTriumph::Schema::Result::Model",
  { id => "model" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 triumphsalls

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Triumphsall>

=cut

__PACKAGE__->has_many(
  "triumphsalls",
  "ClubTriumph::Schema::Result::Triumphsall",
  { "foreign.triumph" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-18 17:43:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7mMeJIOJ7qNLBwCC+q+t7g

sub first {
	my $self = $_[0];
	my $first = $self->triumphsalls_rs->get_column('first')->min;
	return unless $first;
	use DateTime::Format::ISO8601;
	return DateTime::Format::ISO8601->parse_datetime($first);
}

sub last {
	my $self = $_[0];
	my $last = $self->triumphsalls_rs->get_column('last')->max;
	return unless $last;
	use DateTime::Format::ISO8601;
	return DateTime::Format::ISO8601->parse_datetime($last);
}

sub home {
	my $self = $_[0];
	return $self->triumphsalls_rs->get_column('home')->sum;
}

sub export {
	my $self = $_[0];
	return $self->triumphsalls_rs->get_column('export')->sum;
}

sub on_register {
	my $self = $_[0];
	return $self->result_source->schema->resultset('Register')->count({'triumph.triumph' => $self->id},{prefetch => 'triumph'});
}

sub in_club {
	my $self = $_[0];
	return $self->result_source->schema->resultset('Register')->search_rs({'triumph.triumph' => $self->id},{prefetch => 'triumph'})->in_club;
}

sub known_as {
	my $self = $_[0];
	return $self->model->model.$self->mark->mark
}

sub pid {
	my $self = shift;
	my $pid = $self->triumphsalls->first->menus->first->parent;
	return $pid if ($pid->type eq 'mark');
	$pid = $pid->parent;
	return $pid if ($pid->type eq 'mark');
	$pid = $pid->parent;
	return $pid if ($pid->type eq 'mark');
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
