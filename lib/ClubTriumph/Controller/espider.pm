package ClubTriumph::Controller::espider;
use Moose;
use namespace::autoclean;
use ClubTriumph::Search;
use Search::Elasticsearch;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::espider - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
=cut
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $search = ClubTriumph::Search->new;
	my $e = Search::Elasticsearch->new(
		nodes    => '127.0.0.1:9200',
		cxn_pool => 'Sniff'
	);
	my $response= 'words';
#	$response .= "Search obj: " . Dumper $search;
	my @items = $c->model('ClubTriumphDB::Item')->search({},{rows => 100000});
	foreach my $item (@items) {
		if ($item->known_as) {
			
		$response .= "Indexing " . $item->known_as . "\n";
		my $result = $e->index(
        index => 'deimos',
        id => $item->id,
        type => $item->contenttype->type,
        body => {
            title       => $item->title,
 #           display_title => $item->known_as,
 #           author      => $entry->author->name,
 #           created     => $entry->created_at ."",
 #           updated     => $entry->updated_at ."",
            content        => $item->content,
 #           attachments => \@attachments,
        },
    );
			
			

#			$item->update({spidered => 1});
		}
	}
    $c->response->body($response);
   
}



sub clubtorque :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response= 'words';
	my $search = ClubTriumph::Search->new;
	my $e = Search::Elasticsearch->new(
		nodes    => '127.0.0.1:9200',
		cxn_pool => 'Sniff'
	);
	my @articles = $c->model('ClubTriumphDB::Article')->search({}); #{[{'!=' => '1'},undef],{rows => 1000}
	foreach my $item (@articles) {
		if ($item->page) {
		my $result = $e->index(
        index => 'deimos',
        id => $item->id,
        type => 'clubtorque',
        body => {
            title       => $item->title,
            display_title => $item->title,
 #           author      => $entry->author->name,
 #           created     => $entry->created_at ."",
 #           updated     => $entry->updated_at ."",
            content        => $item->gettext,
 #           attachments => \@attachments,
        },
    );

			}



#	$item->update({spidered => 1});
}
    $c->response->body($response);
    
}
=cut
sub ctnew :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response= ' ';
    my @articles = $c->model('ClubTriumphDB::Article')->all;
	foreach my $item (@articles) {
		if ($item->page) {
			$item->spider($c);
			$c->log->debug('*** Spidered '.$item->title.' ***');
			$response .= 'Spidered '.$item->title.'\n';
		}
	}
	$c->response->body($response);
}


sub itemnew :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response= ' ';
    my @articles = $c->model('ClubTriumphDB::Item')->all;
	foreach my $item (@articles) {
		$item->spider($c);
		$c->log->debug('*** Spidered '.$item->title.' ***');
		$response .= 'Spidered '.$item->title.'\n';
	}
	$c->response->body($response);
}

sub menunew :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response= ' ';
    my @articles = $c->model('ClubTriumphDB::Menu')->all;
#    my @articles = $c->model('ClubTriumphDB::Menu')->search({type => 'entry'});
	foreach my $item (@articles) {
		$item->spider($c);
		$c->log->debug('*** Spidered '.$item->title.' ***');
		$response .= 'Spidered '.$item->title.'\n';
	}
	$c->response->body($response);
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
