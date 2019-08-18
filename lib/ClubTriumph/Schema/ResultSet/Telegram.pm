package ClubTriumph::Schema::ResultSet::Telegram;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=cut
sub send_diary {
	my ($self,$c,$diary) = @_;
my $token = $c->config->{'Model::Telegram'}->{token};
use WWW::Telegram::BotAPI;
my $api = WWW::Telegram::BotAPI->new (
    token => $token,
    force_lwp => 1
);
	my $text = $diary->menu_items->first->title."\n".$diary->content;
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $done;
	foreach my $att ($diary->items_attachments->search({contenttype => 3})) {
			$api->api_request ('sendPhoto',{
			chat_id => '-260562685',
			caption    => $text,
			photo => {
				file => $image_dir.'image'.$att->id.'.'.$att->extension
			}
		});
		$done = 1;
	}
	unless ($done) {
		$api->api_request ('sendMessage',{
			chat_id => '-260562685',
			text    => $text
		});
	}
}
=cut

sub send_channel {
	my ($self,$c,$diary) = @_;
	my $token = $c->config->{'Model::Telegram'}->{token};
	my $chat_id = $c->config->{'Model::Telegram'}->{chat_id};
	use WWW::Telegram::BotAPI;
	my $api = WWW::Telegram::BotAPI->new (
		token => $token,
		force_lwp => 1
	);
	my $text = $diary->menu_items->first->title."\n".$diary->content;
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $file_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{upload_dir}).'/';
	my $done;
	foreach my $att ($diary->items_attachments->search({contenttype => 3})) {
			$api->api_request ('sendPhoto',{
			chat_id => $chat_id,
			caption    => $text,
			photo => {
				file => $image_dir.'image'.$att->id.'.'.$att->extension
			}
		});
		$done = 1;
	}
	foreach my $att ($diary->items_attachments->search({contenttype => 4, extension => 'mp4'})) {
			$api->api_request ('sendVideo',{
			chat_id => $chat_id,
			caption    => $text,
			video => {
				file => $file_dir.'file'.$att->id.'.'.$att->extension
			}
		});
		$done = 1;
	}
	unless ($done) {
		$api->api_request ('sendMessage',{
			chat_id => $chat_id,
			text    => $text
		});
	}
}

sub new_telegram { 
	my ($self,$c) = @_;
	open (BODY, $c->req->body);
	read(BODY, my $text,99999);
	use File::Copy;
	copy($c->req->body,$c->path_to('root','static','temp').'/telegram');
	$c->log->debug($text);
	use JSON;
	my $json = JSON->new;
	my $request = $json->decode($text);
	my $telegrammer = $$request{message}{from}{id};
	$c->log->debug($telegrammer);
	my $sender = $self->find_or_create({telegramid => $telegrammer});
	$sender->new_telegram($c,$request);

}
1;
