use utf8;
package ClubTriumph::Schema::Result::Telegram;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Telegram

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

=head1 TABLE: C<telegram>

=cut

__PACKAGE__->table("telegram");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 entry

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 telegramid

  data_type: 'text'
  is_nullable: 1

=head2 latitude

  data_type: 'float'
  is_nullable: 1

=head2 longitude

  data_type: 'float'
  is_nullable: 1

=head2 locationtime

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "entry",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "telegramid",
  { data_type => "text", is_nullable => 1 },
  "latitude",
  { data_type => "float", is_nullable => 1 },
  "longitude",
  { data_type => "float", is_nullable => 1 },
  "locationtime",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entry

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "entry",
  "ClubTriumph::Schema::Result::Entry",
  { id => "entry" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 11:39:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZefCiFWHmaxu0qkIrEy61Q

sub new_telegram {
	my ($self,$c,$telegram) = @_;
	if ($$telegram{message}{location}) {
		$self->update({latitude => $$telegram{message}{location}{latitude}, longitude => $$telegram{message}{location}{longitude}, locationtime => DateTime->now});
	}
	if ($$telegram{message}{text} =~ /^\/register (.*)$/i) {
		my $team = $c->stash->{event}->entries->search({'me.status' => 'live','car.regno' => $1},{prefetch => 'car'})->first;
		if ($team) {
			$self->update({entry => $team->id});
			$self->message($c,'Thank you, you are now registered as '.$team->menus->first->title);
		}
		else {
			$self->message($c,'I\'m sorry, I can\'t find that registration number. Please check that your entry details are correct on the CT website');
		}
	}
	elsif ($$telegram{message}{contact}{phone_number} && ($$telegram{message}{contact}{user_id} eq $self->telegramid) ) {
		use Phone::Number;
		my $number = new Phone::Number($$telegram{message}{contact}{phone_number});
		my $formatted = $number->formatted;
		my $entry = $c->stash->{event}->entries->search({status => 'live','entrants.mobile' => $formatted},{prefetch => 'entrants'})->first;
		if ($entry) {
			$self->update({entry => $entry->id});
			$self->message($c,'Thank you, you are now registered as '.$entry->menus->first->title.'. Send text, pictures, videos or your location or type \'/help\' for a list of commands');
		} else {
			$self->message($c,'I\'m sorry, I can\'t find that mobile number. Please check that your entry details are correct on the CT website');
		}
	}
	elsif ($self->entry) {
		if ($$telegram{message}{text} =~ /^\//) {
			$self->handle_command($c,$telegram) 
		} 
		else { #it's a message
			$self->entry->new_telegram($c,$telegram);
		}
	}
	elsif (!($$telegram{message}{text} =~/^Cancel/)) {
#		$self->message($c,'please register your team'); 
		$self->request_number($c);
	}
}

sub request_number {
	my ($self, $c) = @_;
	use WWW::Telegram::BotAPI;
	my $api = WWW::Telegram::BotAPI->new (
		token => $c->config->{'Model::Telegram'}->{token},
		force_lwp => 1
	);
	$api->api_request ('sendMessage',{
		chat_id => $self->telegramid,
		text => "Please agree to share your contact details to integrate with the Message Diary",
		reply_markup => {
			keyboard => [
                    [
                        {
                            text => "Share contact details",
                            request_contact => \1
                        },
                        "Cancel"
                    ]
                ],
                one_time_keyboard => \1
            }
        })
}

sub message {
	my ($self,$c,$message) = @_;
	use WWW::Telegram::BotAPI;
	my $api = WWW::Telegram::BotAPI->new (
		token => $c->config->{'Model::Telegram'}->{token},
		force_lwp => 1
	);
	$api->api_request ('sendMessage',{
		chat_id => $self->telegramid,
		text    => $message
	});
}

sub handle_command {
	my ($self,$c,$telegram) =@_;
	if ($$telegram{message}{text} =~ /^\/help/i) {
		my $message = <<EOF;
/whois - [team no or name] get info on a teeam from its name or number
/whereis - [team no or name] get location info for a team if available
EOF
		$self->message($c,$message)
	}
	if ($$telegram{message}{text} =~ /^\/whois (.*)$/i) {
		my $text = $1;
		my $message;
		my $found = 0;
		foreach my $team ($self->entry->event->entries->find_team($text)) {
			$message .= $team->teamdesc;
			$found = 1;
		}
		unless ($found) {$message = "I'm sorry I can't find '$text', please enter a team number or name"}
		$self->message($c,$message)
	}
	if ($$telegram{message}{text} =~ /^\/whereis (.*)$/i) {
		my $text = $1;
		my $message;
		my $found = 0;
		foreach my $team ($self->entry->event->entries->find_team($text)) {
			if ($team->location) {
				$message .= $team->menus->first->title.' is at ';
				$message .= 'latitude '.$team->location->{latitude}.' longitude '.$team->location->{longitude};
				if ($self->entry->location) {
					use GIS::Distance;
					my $gis = GIS::Distance->new();
					my $distance = $gis->distance($self->entry->location->{latitude},$self->entry->location->{longitude} => $team->location->{latitude}, $team->location->{longitude});
					$message .=  "\n".$distance->value('miles').' miles away';
				}
				$self->send_location($c,$team->location)
			} 
			else {
				$message .= "I'm sorry I don't know where ".$team->menus->first->title.' is';
			}
		$found = 1;
		}
		unless ($found) {$message = "I'm sorry I can't find '$text', please enter a team number or name"}
		$self->message($c,$message)
	}
}

sub send_location {
	my ($self,$c,$location) = @_;
	use WWW::Telegram::BotAPI;
	my $api = WWW::Telegram::BotAPI->new (
		token => $c->config->{'Model::Telegram'}->{token},
		force_lwp => 1
	);
	$api->api_request ('sendlocation',{
		chat_id => $self->telegramid,
		latitude    => $location->{latitude},
		longitude    => $location->{longitude},
	});
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
