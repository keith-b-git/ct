package ClubTriumph::Schema::ResultSet::Searchable;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub viewable_by {
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
		my @sumsquarearray;
		my $total_items= $c->model('ClubTriumphDB::Searchable')->count({});
		foreach my $keywordid (@keywordids) { 
			my $count = $keywordid->wordcounts->search_related('searchable',{},{distinct => 1});
			my $idf=0;
			if ($count>0) {$idf = log($total_items / $count)};
			my $stuff = '';
			if ($i > 1) {$stuff = "_$i"}
			push(@searchlist,"wordcounts$stuff.word",$keywordid->id); 
			push (@joinarray, 'wordcounts');
			push (@orderarray,"(wordcounts$stuff.wcount*$idf)");
			push (@sumsquarearray,"(wordcounts$stuff.wcount*wordcounts$stuff.wcount)");
			$i++
		}
		my $orderstring = join('+',@orderarray);
		my $sumsquarestring = join('+',@sumsquarearray);
		$orderstring = "($orderstring)/sqrt($sumsquarestring)";
		return $self->viewable_by($c->user)-> #result containing any word
				search_rs({'-and',\@searchlist},{join => \@joinarray, order_by => [{'-desc' => $orderstring}]});#, order_by => {'-desc' => $orderstring},{'-desc' => 'views'}
		}
}


1;
