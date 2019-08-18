use utf8;
package ClubTriumph::Schema::Result::Model;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Model

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

=head1 TABLE: C<models>

=cut

__PACKAGE__->table("models");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 model

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "model",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 triumphs

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Triumph>

=cut

__PACKAGE__->has_many(
  "triumphs",
  "ClubTriumph::Schema::Result::Triumph",
  { "foreign.model" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-18 17:43:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xXDePI5+UTV4d+rXM+uiiQ


sub first {
	my $self = $_[0];
	my $first = $self->result_source->schema->resultset('Triumphsall')->search({'triumph.model' => $self->id},{prefetch => 'triumph'})->get_column('first')->min;
	return unless $first;
	use DateTime::Format::ISO8601;
	return DateTime::Format::ISO8601->parse_datetime($first);
}

sub last {
	my $self = $_[0];
	my $last = $self->result_source->schema->resultset('Triumphsall')->search({'triumph.model' => $self->id},{prefetch => 'triumph'})->get_column('last')->max;
	return unless $last;
	use DateTime::Format::ISO8601;
	return DateTime::Format::ISO8601->parse_datetime($last);
}

sub home {
	my $self = $_[0];
	return $self->result_source->schema->resultset('Triumphsall')->search({'triumph.model' => $self->id},{prefetch => 'triumph'})->get_column('home')->sum;
}

sub export {
	my $self = $_[0];
	return $self->result_source->schema->resultset('Triumphsall')->search({'triumph.model' => $self->id},{prefetch => 'triumph'})->get_column('export')->sum;
}

sub on_register {
	my $self = $_[0];
	return $self->search_related('triumphs',{})->search_related('triumphsalls',{})->search_related('registers', {})->count
#	return $self->result_source->schema->resultset('Register')->count({'triumph.triumph.model' => $self->id},{prefetch => {'triumph' => 'triumph'}});
}

sub in_club {
	my $self = $_[0];
	return $self->search_related('triumphs',{})->search_related('triumphsalls',{})->search_related('registers', {})->in_club
#	return $self->result_source->schema->resultset('Triumphsall')->search({'triumph.model' => $self->id},{prefetch => 'triumph'})->in_club;
}

sub pid {
	my $self = shift;
	my $pid = $self->triumphs->first->triumphsalls->first->menus->first->parent;
	return $pid if ($pid->type eq 'model');
	$pid = $pid->parent;
	return $pid if ($pid->type eq 'model');
	$pid = $pid->parent;
	return $pid if ($pid->type eq 'model');
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
