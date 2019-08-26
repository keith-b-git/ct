package ClubTriumph::Schema::ResultSet::Entrant;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub sendsms {
my ($self, $message, $sender) = @_;
my @numbers = $self->search({mobile => {'!=' => undef}})->get_column('mobile')->all;
use Phone::Number;
use LWP::Simple;
my @recipients;
foreach my $number (@numbers) {
	my $recipient = new Phone::Number($number);
	if ($recipient) {
		push (@recipients, $recipient->plain);
	}
}
my $sender_number = new Phone::Number($sender);
$sender = $sender_number->plain;
my $recipients = join(',',@recipients);
my $c = ClubTriumph->ctx or die "Not in a request!";
my $password = $c->config->{'Schema::Result::SMS'}->{aql_password};
my $username = $c->config->{'Schema::Result::SMS'}->{aql_username};
my $querystring= "https://gw.aql.com/sms/sms_gw.php?username=triumph&password=$password&originator=$sender&destination=$recipients&message=$message";
my $response = get($querystring);


my $logfile = $c->path_to('root','log').'/messagelog.log';
open (LOG,">>$logfile");
print LOG "$querystring $response\n";
close LOG; 

$querystring= "https://gw.aql.com/sms/sms_gw.php?username=$username&password=$password&originator=$sender&destination=$sender&message=$response";
my $receipt = get($querystring);
return $response;
}

sub smscredit {
use LWP::Simple;
my $c = ClubTriumph->ctx or die "Not in a request!";
my $password = $c->config->{'Schema::Result::SMS'}->{aql_password};
my $username = $c->config->{'Schema::Result::SMS'}->{aql_username};
my $response = get("http://gw1.aql.com/sms/postmsg.php?username=$username&password=$password&cmd=credit");
return $response;

}

1;
