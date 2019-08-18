package ClubTriumph::Controller::clubtorque;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::clubtorque - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub article :Local :Args(1)  {
	my ( $self, $c, $articleno ) = @_;
	use PDF::API2;
#	my $ctdir = "/home/Keith/ClubTriumph/data/clubtorque/";
	my $ctdir = $c->path_to('data',$c->config->{'Controller::Clubtorque'}->{clubtorque_dir}).'/';
	my $articledir = $c->path_to('data',$c->config->{'Controller::Clubtorque'}->{article_dir}).'/';
	my $article = $c->model('ClubTriumphDB::Article')->find({id => $articleno});
	unless ($article->viewable_by($c->user)) {
		$c->error("Article not viewable by user!"); return}
	if ($article) {
		my $edition = $article->articleedition->edition;
		my $startpage = $article->page;
		my $file = $ctdir.$edition.'.pdf';
		if ($startpage == 256) {
			$file = $articledir.$article->id.'.pdf';
			$startpage = 1;
		}
		my $pdf = PDF::API2->open($file);
		my $numpages = $pdf->pages;
		my $endpage = $article->articleedition->search_related('articles',{page => {'>' => $startpage}})->get_column('page')->min -1;
		unless ($endpage>0) {$endpage = $numpages}
		my $nextarticle = $article->articleedition->search_related('articles',{page => {'>' => $startpage}},{order_by => 'page'})->first;
		my $prevarticle = $article->articleedition->search_related('articles',{page => {'<' => $startpage}},{order_by => {'-desc' => 'page'}})->first;
		if ($article->page == 256) {$endpage = $numpages}
		use PDF::Reuse; 
#		open (PDFFILE, $file);
#		my $content;
#		read(PDFFILE,$content,99999999);
		
		prInitVars();
		$| = 1;
		my $tempfile = $c->path_to('data','temp','clubtorque.pdf');
		prFile($tempfile);
#		prTTFont($c->path_to('root','static','fonts','FreeSans.ttf'));
#		foreach my $ypos (5,825)
			
		my $currentpage = $startpage;
		while ($currentpage <= $endpage) {
			if ( $currentpage == $startpage) {addlinks($c,828,$startpage,$endpage,$article)}
			if ( $currentpage == $endpage) {addlinks($c,5,$startpage,$endpage,$article)}
			prSinglePage($file,$currentpage);
			$currentpage++;
		}
#		prDoc($file,$startpage,$endpage);
		prEnd(); 
		my $content;
		open (PDFFILE, $tempfile);
		read(PDFFILE,$content,99999999);
		close PDFFILE;
		unlink $tempfile;
		$c->response->content_type('application/pdf');
		$c->response->header('Content-Disposition', "inline; filename=ClubTorque.pdf");
		$c->response->body($content);
	}
}
		
		
sub addlinks {
	my ($c,$ypos,$startpage,$endpage,$article) = @_;
	my $nextarticle = $article->articleedition->search_related('articles',{page => {'>' => $startpage}},{order_by => 'page'})->first;
	my $prevarticle = $article->articleedition->search_related('articles',{page => {'<' => $startpage}},{order_by => {'-desc' => 'page'}})->first;
	my $linkpage = 1;
	use Encode qw(decode encode);
	prFontSize(8);
	if ($ypos < 100) { $linkpage = $endpage - $startpage +1}
	if ($nextarticle && $article->page < 256) 
		{
		my $xpos=430;
		 prLink( {page   => $linkpage,
		      x      => $xpos,
		      y      => $ypos,
		      width  => 130,
		      height => 15,
		
		      URI    => $c->uri_for('/clubtorque','article',$nextarticle->id) } );
		
		prText($xpos, $ypos, encode('UTF-8',$nextarticle->title).' >>');
	    }
	if ($prevarticle && $article->page < 256) 
		{
		my $xpos=30;
		prLink( {page   => $linkpage,
		     x      => $xpos,
		     y      => $ypos,
		     width  => 130,
		     height => 15,
		
		     URI    => $c->uri_for('/clubtorque','article',$prevarticle->id) } );
		
		     prText($xpos, $ypos, '<< '.encode('UTF-8',$prevarticle->title));
		 }
		my $xpos=280;
	      prLink( {page   => $linkpage,
	      x      => $xpos,
	      y      => $ypos,
	      width  => 105,
	      height => 10,
	
	      URI    => $c->uri_for('/menu',$article->articleedition->menus->first->pid,'view') } );
		prText($xpos, $ypos, "contents");         
		
}

sub gettext :Local :Args(1) {
	my ($self,$c,$article) = @_;
	my $xarticle = $c->model('ClubTriumphDB::Article')->find($article);

	$c->response->body('xx'.$xarticle->gettext);
}    

sub download :Chained('/menu/base') :PathPart('download') :Args(0) {
	my ($self, $c) = @_;
	unless ($c->user && $c->user->club_member) { 
		$c->error('no permission');
		return;
	}
	my $clubtorque = $c->stash->{menu_item}->club_torque;
	unless ($clubtorque) { 
		$c->error('not found');
		return;
	}
	
	use PDF::Reuse;
	use Encode;
	my $ctdir = $c->path_to('data',$c->config->{'Controller::Clubtorque'}->{clubtorque_dir}).'/';
	my $file = $ctdir.$clubtorque->edition.'.pdf';

	my $tempfile = $c->path_to('data','temp','clubtorque'.$clubtorque->edition.".pdf");
	prFile($tempfile);
	prDoc($file);
	my $category;
	my $catpage;
	my @pageMarks;
	my @catMarks;
	foreach my $article  ($clubtorque->articles->search({},{order_by => 'page'})) {  
		if ($category && $category ne $article->category) {
			push @pageMarks, { text => $category,
                 act  => ($catpage-1).", 40, 700" ,
				kids => [@catMarks]
			};
			@catMarks = ();
			$catpage = $article->page;
		}
		unless ($catpage) {$catpage = $article->page};
		$category = $article->category,

		my $bookMark = { text => encode('UTF8',$article->title),
                     act  => ($article->page-1).", 40, 700" };
     
		push @catMarks, $bookMark;
	}
	push (@pageMarks, { text => $category,
			kids => \@catMarks,
	        act  => ($catpage-1).", 40, 700" ,
			});
	prBookmark( { text  => encode('UTF8',$clubtorque->title),
				act  => "0, 40, 700" ,
				kids  => \@pageMarks } );
	prEnd();
	use PDF::API2;
	my $pdf = PDF::API2->open($tempfile);

	$pdf->info (
		'Title' => $clubtorque->title,
		'Author' => 'Club Triumph',
		'Creator' => 'Downloaded by '.$c->user->fullname,
		'ModDate' => 'D:'.DateTime->now->ymd('').DateTime->now->hms('')
	); 
	my $content = $pdf->stringify();
	unlink $tempfile;
	$c->response->content_type('application/pdf');
	$c->response->header('Content-Disposition', "inline; filename=ClubTorque_".$clubtorque->edition.".pdf");
	$c->response->body($content);
	
	
}


=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
