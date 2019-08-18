use utf8;
package ClubTriumph::Schema::Result::Sm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Sm

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

=head1 TABLE: C<sms>

=cut

__PACKAGE__->table("sms");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 originator

  data_type: 'text'
  is_nullable: 1

=head2 message

  data_type: 'text'
  is_nullable: 1

=head2 destination

  data_type: 'text'
  is_nullable: 1

=head2 time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 udh

  data_type: 'text'
  is_nullable: 1

=head2 messid

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "originator",
  { data_type => "text", is_nullable => 1 },
  "message",
  { data_type => "text", is_nullable => 1 },
  "destination",
  { data_type => "text", is_nullable => 1 },
  "time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "udh",
  { data_type => "text", is_nullable => 1 },
  "messid",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2018-04-16 14:20:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0QTsMscqF4fbVjVaXqUxrA

sub is_complete {
	my $self = shift;
	unless ($self->udh) {return 1};
	$self->udh =~ /^050003(..)(..)(..)/;
	my ($id,$parts,$part) = ($1,$2,$3); 
	my $count = $self->result_source->resultset->count({originator => $self->originator, udh => {like => '050003'.$id.'%'}}); 
	return ($parts == $count);
}

sub content {
	my $self = shift;
	unless ($self->udh) {return $self->message}
	$self->udh =~ /^050003(..)(..)(..)/;
	my ($id,$partcounts,$part) = ($1,$2,$3);
	my $parts = $self->result_source->resultset->search({originator => $self->originator, udh => {like => '050003'.$id.'%'}},{order_by => 'udh'});
	return join('',$parts->get_column('message')->all);
}

sub delete_parts {
	my $self = shift;
	unless ($self->udh) {
		$self->delete;
		return 
	}
	$self->udh =~ /^050003(..)(..)(..)/;
	my ($id,$partcounts,$part) = ($1,$2,$3);
	$self->result_source->resultset->search({originator => $self->originator, udh => {like => '050003'.$id.'%'}},{order_by => 'udh'})->delete;
}
	
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
