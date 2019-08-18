package ClubTriumph::Schema::ResultSet::Article;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub articles_viewable_by {
	my $self= shift;
	return $self
}
 
sub searchwords {
	my ($self,$c,$searcharray) = @_;

	my @searchwords= @$searcharray;
	my @keywordids;
	my @searchlist;
	my $resultset;
	my @contentcounts;
	foreach my $searchword (@searchwords) {
		my $keyword = $c->model('ClubTriumphDB::Keyword')->find({word => $searchword});
		if ($keyword) {push (@keywordids, $keyword)} else {last}
	}
	if (@keywordids) {
		my $i = 1;
		my @joinarray;
		my @orderarray;
		foreach my $keywordid (@keywordids) {
			my $stuff = '';
			if ($i > 1) {$stuff = "_$i"}
			push(@searchlist,"wordcounts$stuff.word",$keywordid->id); 
			push (@joinarray, 'wordcounts');
			push (@orderarray,"wordcounts$stuff.wcount");
			$i++
		}
		my $orderstring = join('+',@orderarray);
		return $self->articles_viewable_by($c->user)-> #result containing any word
				search_rs({'-and',\@searchlist},{join => \@joinarray, order_by => [{'-desc' => $orderstring}]});#, order_by => {'-desc' => $orderstring},{'-desc' => 'views'}
		}
}


1;
