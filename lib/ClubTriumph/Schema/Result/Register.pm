use utf8;
package ClubTriumph::Schema::Result::Register;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Register

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

=head1 TABLE: C<register>

=cut

__PACKAGE__->table("register");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 memno

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 triumph

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 commno

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 engno

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 engsize

  data_type: 'integer'
  is_nullable: 1

=head2 tx

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 regno

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 colour

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 trim

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 regdate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 mandate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 entdate

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 acquired

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sold

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 currmem

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 currcar

  data_type: 'integer'
  is_nullable: 1

=head2 photo

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 allowcar

  data_type: 'integer'
  is_nullable: 1

=head2 allowmem

  data_type: 'integer'
  is_nullable: 1

=head2 comments

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 oldid

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "memno",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "triumph",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "commno",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "engno",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "engsize",
  { data_type => "integer", is_nullable => 1 },
  "tx",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "regno",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "colour",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "trim",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "regdate",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "mandate",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "entdate",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "acquired",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "sold",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "currmem",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "currcar",
  { data_type => "integer", is_nullable => 1 },
  "photo",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "allowcar",
  { data_type => "integer", is_nullable => 1 },
  "allowmem",
  { data_type => "integer", is_nullable => 1 },
  "comments",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "oldid",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entries

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "ClubTriumph::Schema::Result::Entry",
  { "foreign.car" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 memno

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "memno",
  "ClubTriumph::Schema::Result::Member",
  { memno => "memno" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.register" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 triumph

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Triumphsall>

=cut

__PACKAGE__->belongs_to(
  "triumph",
  "ClubTriumph::Schema::Result::Triumphsall",
  { id => "triumph" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-01 14:38:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xJh2OW2MWkJtlkhn2kubdw



sub blogs {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '2'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}
sub images {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self -> items->search({contenttype => '3'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}

sub image_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '3'})
}

sub blog_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '2'})
}
sub known_as {
	my $self = $_[0];
	if ($self->triumph && $self->triumph->triumph && $self->triumph->triumph->model->model && $self->triumph->triumph->mark->mark) {
#		my $reg = $self->regno;
#		$reg =~ /(^.)(.*)(.$)/;
#		my ($beg,$mid,$end) = ($1,$2,$3);
#		$mid =~ s/\S/\*/g;
#		$reg = $beg.$mid.$end;
		my $year ='';
		if ($self->regdate) {$year = $self->regdate->year}
		if ($self->mandate) {$year = $self->mandate->year}
		return $year.' '.$self->colour.' '.$self->triumph->fullname;
	}
}

sub blank_reg {
	my $self = $_[0];
	my $reg = $self->regno;
	$reg =~ /(^.)(.*)(.$)/;
	my ($beg,$mid,$end) = ($1,$2,$3);
	$mid =~ s/\S/\*/g;
	return $beg.$mid.$end;
}

sub blank_engno {
	my $self = $_[0];
	my $engno = $self->engno;
	return unless $engno;
	$engno =~ /(^[A-Z]*.)(.*?)([A-Z]*$)/;
	my ($beg,$mid,$end) = ($1,$2,$3);
	$mid =~ s/\S/\*/g;
	return $beg.$mid.$end;
}

sub blank_commno {
	my $self = $_[0];
	my $commno = $self->commno;
	return unless $commno;
	$commno =~ /(^[A-Z]*.)(.*?)([A-Z]*$)/;
	my ($beg,$mid,$end) = ($1,$2,$3);
	$mid =~ s/\S/\*/g;
	return $beg.$mid.$end;
}

sub is_sold {
	my $self = $_[0];
	return ($self->sold && ($self->sold < DateTime->now))
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
