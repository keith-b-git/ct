use utf8;
package ClubTriumph::Schema::Result::Article;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Article

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

=head1 TABLE: C<articles>

=cut

__PACKAGE__->table("articles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 category

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 articleedition

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 page

  data_type: 'integer'
  is_nullable: 1

=head2 spidered

  data_type: 'tinyint'
  is_nullable: 1

=head2 view

  data_type: 'integer'
  is_nullable: 1

=head2 standalone

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "category",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "articleedition",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "page",
  { data_type => "integer", is_nullable => 1 },
  "spidered",
  { data_type => "tinyint", is_nullable => 1 },
  "view",
  { data_type => "integer", is_nullable => 1 },
  "standalone",
  { data_type => "tinyint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 articleedition

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Clubtorque>

=cut

__PACKAGE__->belongs_to(
  "articleedition",
  "ClubTriumph::Schema::Result::Clubtorque",
  { edition => "articleedition" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-03 12:54:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UzE8/FcrJNpbtcG6GPQzhQ

sub viewable_by {
	my ($self,$user) = @_;
	return unless ($user);
	return ($user->club_member);
}

sub endpage {
	my $self = $_[0];
	unless ($self->page) {return}
	if ($self->page == 256) {
		my $c = ClubTriumph->ctx or die "Not in a request!";
		my $articledir = $c->path_to('data','articles');
		my $file = $articledir.$self->id.'.pdf';
		unless (-e $file) { return }
		my $pdf = PDF::API2->open($file);
		return $pdf->pages;
	}
	my $endpage = $self->articleedition->search_related('articles',{page => {'>' => $self->page}})->get_column('page')->min -1;
	if ($endpage) {return $endpage}
	else {
		my $edition = $self->articleedition->edition;
		my $c = ClubTriumph->ctx or die "Not in a request!";
		my $ctdir = $c->path_to('data','clubtorque');
		my $file = $ctdir.$edition.'.pdf';
		my $pdf = PDF::API2->open($file);
		return $pdf->pages;
	}
}

sub gettext {
	my $self = $_[0];;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my $articledir = $c->path_to('data','articles').'/';
	my $ctdir = $c->path_to('data','clubtorque').'/';
	my $file;
	my $page = $self->page;
	if ($self->page == 256) {
		$file = $articledir.$self->id.'.pdf';
		$page = 1;
	}
	else
	{
		$file = $ctdir.$self->articleedition->edition.'.pdf';
	}
	
	my $endpage = $self->endpage;
	unless (-e $file) { return }
	my $text = `pdftotext -f $page -l $endpage $file -`;
#	use PDF::OCR2;
#	my $pdf = PDF::OCR2->new($file);
#	my $text = $pdf->page($page)->text;
#	use CAM::PDF::PageText;
#	use CAM::PDF;
#	my $pdf = CAM::PDF->new($file);
#	my $pdfpage = $pdf->getPageContentTree($page);
#	return unless $pdfpage;
#	my $text = CAM::PDF::PageText->render($pdfpage);
	return $text;
	}


sub spider {
	my ($self,$c) = @_;
	my $edition = $self->articleedition->edition + 2;
	my $volume = int(($edition - 1) / 6);
	my $month = ($edition % 6) + 1;
	if ($month < 10) {$month = '0'.$month}
	my $year = $volume + 1968;
	my $result = $c->model('Search')->index(
        index => 'clubtriumph',
        id => 'C'.$self->id,
        type => 'clubtriumph',
        body => {
            title			=> $self->title.' ',
            display_title 	=> $self->articleedition->title.' '.$self->title,
            view 			=> 64,
            content        	=> $self->gettext.' ',
            cttype 			=> 'club_torque_article',
            created			=> "$year-$month-15T00:00:00",
            modified		=> "$year-$month-15T00:00:00",
            tags			=> [$self->articleedition->menus->first->pid]
        },
    );
	return $result;
}



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
