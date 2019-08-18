package ClubTriumph::Controller::search;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::search - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



=cut
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $searchterm =  lc($c->request->params->{search});
    if ($searchterm) {
		my $response = '';
		my $item_rs;
		my $ct_rs;
		my $search_rs;
		my @searchwords= $searchterm =~ /(\w+(?:[-'\/]\w+)*)/g;
	
#		$item_rs = $c->model('ClubTriumphDB::Item')->searchwords($c,\@searchwords);
		my @contenttypes = (2,3,5,6,7);
		my @contentcounts;
#		foreach my $contenttype (@contenttypes) {
#			push (@contentcounts, {name => $c->model('ClubTriumphDB::Contenttype')->find($contenttype)->displaytype, count => $item_rs->count({contenttype=>$contenttype})});
#		}
#		push (@contentcounts, {name => 'all', count => $item_rs->count({})});
#		$ct_rs = $c->model('ClubTriumphDB::Article')->searchwords($c,\@searchwords);
#		push (@contentcounts, {name => 'Club Torque', count => $ct_rs->count({})});
		$search_rs = $c->model('ClubTriumphDB::Searchable')->searchwords($c,\@searchwords);
	
	#display results section
		my @wordresults;
		my @imageresults;
		my @results;
		use HTML::Strip;
		my $hs = HTML::Strip->new();
#		if ($item_rs) {
#			@wordresults = $item_rs->search({contenttype => {'!=' =>  3}},{rows => 10});
#			@imageresults = $item_rs->search({contenttype => 3},{rows => 10});
#		}
#		my @ct_results = $ct_rs->search({},{rows => 10});
		my @search_results = $search_rs->search({},{rows => 10});
#		my $searchword = $searchwords[0];
		#	if ($keyword) {@wordresults = $keyword->wordcounts->search({},{order_by => {'-desc' =>'count'}})->related_resultset('item')}
#		foreach my $result (@wordresults) {
	
#			my $text = $hs->parse($result->content);
#			utf8::encode($text);
#			$hs->eof;
				
#			push (@results,{title => $result->known_as, item => $result, content => $text}); #->first->wcount, count => $keywordcount
#		}
		
		
		
		my $count = $search_rs->count({});
		$c->stash(search_results => \@search_results,  search => $searchterm, contentcounts => \@contentcounts, count => $count,);
#results => \@results, imageresults => \@imageresults, ct_results => \@ct_results, count => $count,
	}
	$c->stash(template => 'search/search.tt2');



}

sub elasticsearch :Chained('/menu/base') :PathPart('oldsearch') :Args(0) { #:Local :Args(0) {
    my ( $self, $c ) = @_;
    my $searchterm =  $c->request->params->{search};
    my $searchpage =  $c->request->params->{searchpage};
    unless ($searchpage) {$searchpage = 1 }
    my $filter =  $c->request->params->{filter};
    my $accesslevel = 256;
    my $user_id = -1;
    if ($c->user) {$accesslevel = $c->user->access_level; $user_id = $c->user->id}
    my $filterterm ={};
	if ($filter) {$filterterm = {term => {'cttype' => $filter}}}


#			push (@results,{title => $result->known_as, item => $result, content => $text}); #->first->wcount, count => $keywordcount
#		}

      my $search = $c->model('Search');
      my $results = $search->search(
        index => 'clubtriumph',
#		type  => ['HTML','Image','Thread','Message','PM','shop','carforsale','partsforsale','wanted','news','clubtorque'],
    size => 10,
    from => ($searchpage -1) *10,
	body => {
		aggs => {groups_by_type =>  { terms => {field => 'cttype'}}},
		query => {
			filtered => {
				query => {bool => {must => { multi_match => { query => $searchterm, fields => ['content','title'] } }}},
				filter => {'or' => [ {'and' => [{ range => {'view' => {'gte' => $accesslevel}}},$filterterm ]},
									{'and' => [{ range => {'view' => {'gte' => 1,'lte' => 1}}},{ range => {'user_id' => {'gte' => $user_id,'lte', => $user_id}}}]}
								]
					}
				}
			}
		}
      );
      
          my @results;
          my $took = $results->{took};
          my $hits = $results->{'hits'}->{'total'};
          my $aggs = $results->{'aggregations'}{'groups_by_type'}{'buckets'};
    for my $result ( @{$results->{'hits'}{'hits'}} ) {
        my $r = $result->{'_source'};
        my $body = $r->{'content'};
       utf8::encode($body);
        push @results, {
            display_title => $r->{'display_title'},
            title   => $r->{'title'},
            id   => $result->{'_id'},
            type   => $r->{'cttype'},
            created => $r->{'created'},
            updated => $r->{'updated'},
            author  => $r->{'author'},
            view  => $r->{'view'},
            tags  => $r->{'tags'},
            content   => $body,
        };
 
    }
    $c->stash( results => \@results, search => $searchterm, searchpage => $searchpage, hits => $hits, took => $took,
    aggs => $aggs, item_rs =>$c->model('ClubTriumphDB::Item'));

		
		
#		my $count = $search_rs->count({});
#		$c->stash(search_results => $results,  search => $searchterm,);# contentcounts => \@contentcounts, count => $count,
#results => \@results, imageresults => \@imageresults, ct_results => \@ct_results, count => $count,
	
	$c->stash(template => 'menu/content.tt2');



}
=cut

sub pagesearch :Chained('/menu/base') :PathPart('search') :Args(0) { #:Local :Args(0) {
    my ( $self, $c ) = @_;
    use HTML::Scrubber;
    my $scrubber = HTML::Scrubber->new;
    my $searchterm =  $scrubber->scrub($c->request->params->{search});
    unless ($searchterm) {$c->response->redirect($c->uri_for('/menu',$c->stash->{menu_item}->pid,'view'))}
    my $searchpage =  $c->request->params->{searchpage};
    my @descendants = $c->stash->{menu_item}->descendants->viewable($c->user)->get_column('pid')->all;
    my $webpage = join(' ',@descendants);
    unless ($searchpage) {$searchpage = 1 }
    my $filter =  $c->request->params->{filter};
    my $accesslevel = 256;
    my $user_id = -1;
    if ($c->user) {
		if ($c->user->access_level & 128) {$accesslevel = 128}
		if ($c->user->access_level & 64) {$accesslevel = 64}
		$accesslevel = $c->user->access_level;
		$user_id = $c->user->id 
	}
    my $filterterm ={};
	if ($filter) {$filterterm = {term => {'cttype' => $filter}}}


#			push (@results,{title => $result->known_as, item => $result, content => $text}); #->first->wcount, count => $keywordcount
#		}

	my $search = $c->model('Search');
	my $results;
	if (0 && $c->stash->{menu_item}->pid == 1) { # simplified global search??
		$results = $search->search(
		index => 'clubtriumph',
	    size => 10,
	    from => ($searchpage -1) *10,
		body => {
			aggs => {groups_by_type =>  { terms => {field => 'cttype'}}},
			query => {
				filtered => {
					query => {bool => {must => { multi_match => { query => $searchterm, fields => ['content','title'] } }}},
					filter => 
							 {'and' => [{ range => {'view' => {'gte' => $accesslevel}}},$filterterm ]} 
					}
				}
			}
	      );
	  }
	  else {
		$results = $search->search(
		index => 'clubtriumph',
	    size => 10,
	    from => ($searchpage -1) *10,
		body => {
			aggs => {groups_by_type =>  { terms => {field => 'cttype'}}},
			query => {
				filtered => {
					query => {bool => {must => { multi_match => { query => $searchterm, fields => ['content','title'] } }}},
					filter => {'and' => [
							{'terms' => {'tags' => [@descendants]}},
							{'and' => [{ range => {'view' => {'gte' => $accesslevel}}},$filterterm ]}
						] }
					}
				}
			}
	      );
	  }

      
          my @results;
          my $took = $results->{took};
          my $hits = $results->{'hits'}->{'total'};
          my $aggs = $results->{'aggregations'}{'groups_by_type'}{'buckets'};
    for my $result ( @{$results->{'hits'}{'hits'}} ) {
        my $r = $result->{'_source'};
        my $body = $r->{'content'};
       utf8::encode($body);
       my $created= '';
       if ($r->{'created'}) {$created = DateTime::Format::ISO8601->parse_datetime($r->{'created'})}
        push @results, {
            display_title => $r->{'display_title'},
            title   => $r->{'title'},
            id   => $result->{'_id'},
            type   => $r->{'cttype'},
#            created => $r->{'created'},
            created => $created,
            updated => $r->{'updated'},
            author  => $r->{'author'},
            view  => $r->{'view'},
            tags  => $r->{'tags'},
            content   => $body,
        };
 
    }
    $c->stash( results => \@results, search => $searchterm, searchpage => $searchpage, hits => $hits, took => $took,
    aggs => $aggs, item_rs =>$c->model('ClubTriumphDB::Item'), menu_rs =>$c->model('ClubTriumphDB::Menu'), title2 => ' - Search Results - \''.$searchterm.'\'');

		
		
#		my $count = $search_rs->count({});
#		$c->stash(search_results => $results,  search => $searchterm,);# contentcounts => \@contentcounts, count => $count,
#results => \@results, imageresults => \@imageresu	lts, ct_results => \@ct_results, count => $count,
	
	$c->stash(template => 'search/search.tt2');



}





sub wordcounts :Local {
	my ($self, $c) = @_;
	
	my $rs = $c->model('ClubTriumphDB::Keyword')->search(
    undef,
    {
		join => 'wordcounts', distinct => 1,
      '+select' => ['word',
       { sum =>  'wordcounts.item' , -as =>  'wrdcount'  }],
 #       '+as' => [qw/word wrdcount1 /],
#        group_by => 'word'   
			 }
  );
  my @words = $rs->search({},{rows => 300, order_by => {'-desc' => 'wrdcount'} });#
	my $response ;
	foreach my $word (@words) {
		$response .= $word->word."  "."\n";
	}
	
	
	
	$c->response->body($response);
}


sub create_index :Local {
	my ($self, $c) = @_;
	my $search = $c->model('Search');
	$search->create_index({
		clubtriumph1 => {
			"settings" => {
				"number_of_shards" => 5
				},
    "mappings" => {
        "clubtriumph1" => {
            "_source" => { "enabled" => "true" },
            "properties" => {
                "title" => { "type" => "string", "index" => "analyzed" },
                "content" => { "type" => "string", "index" => "analyzed" },
                "display_title" => { "type" => "string", "index" => "analyzed" },
					}
				}
			}
		}
	});
}


=cut
#	my @searchwords = split (/\s+/,$searchterm);


	my $firstsearch = 1;
	use HTML::Strip;
	my $hs = HTML::Strip->new();
	my @keywordids;
	my @searchlist;


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
#		$item_rs = $c->model('ClubTriumphDB::Item')->items_viewable_by($c->user)-> #result containing any word
#				search_rs({'-and',\@searchlist},{join => \@joinarray, order_by => [{'-desc' => $orderstring},{'-desc' => 'views'}]});#, order_by => {'-desc' => $orderstring}
=cut
=cut
			my $keywordcount ;#= $result->search_related('wordcounts',{word => \@searchlist},{distinct => 1});
#			$response .= $result->known_as.$result->count."\n";
			my $text = $hs->parse($result->content);
			utf8::encode($text);
			$hs->eof;
			my $match = join('|',@searchwords);#.'|$';
			my $finaltext = '';
			my $done = 0;
			while ($text =~ /$match/ig) {
				$text =~ s/(^.*?)(.{0,50}?\W)($match)(\W.*?$)/$4/sig; #(.*?$)
				if ($1) {
					if ($finaltext) { $finaltext .= substr ($1,0,50) }
					if (length($1) > 50) {$finaltext .= '...'}
				}
				$finaltext .= "$2<STRONG>$3<\/STRONG>";


			}
			$text =~ /(.{0,50})(.*?$)/sig;
			$finaltext .=$1;
			if ($2) {$finaltext .= '...'}
			my $title = $result->known_as;
			$title =~s /($match)/<EM>$1<\/EM>/ig;
=cut
=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
