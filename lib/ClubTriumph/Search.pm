package ClubTriumph::Search;
 
use Moose;
use namespace::autoclean;
use Search::Elasticsearch;
 
has 'es_object' => (
    is       => 'ro',
    isa      => 'ElasticSearch',
    required => 1,
    lazy     => 1,
    default  =>  sub {
Search::Elasticsearch->new(
    nodes => [
        'localhost:9200'

    ]
);
    },
 
);
 
sub index_data {
    my ($self,  %p) = @_;
    $self->es_object->index(
    
     index   => 'index',
    type    => 'type',
    id      => 1,
    body    => $p{'data'}
  
);
    
    
    
  
}
 
sub execute_search {
    my ($self, %p) = @_;
    my $results =  $self->es_object->search(
        index => $p{'index'},
        type  => $p{'type'},
        query => {
            field => {
                _all => $p{'terms'},
            },
        }
    );
    $results;
}
1;
