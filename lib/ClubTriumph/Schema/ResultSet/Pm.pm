package ClubTriumph::Schema::ResultSet::Pm;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
sub add_recipients {
	my ($self, $item, $recipients) = @_;
	my @tolist = split(/\n/,$recipients);
	foreach my $to (@tolist) {
		$to =~ s/[\000-\037]//g;
		my $recipient = $self->result_source->schema->resultset('User')->find({username => $to});
		if ($recipient) {
			$self->find_or_create({userpm => $recipient, itempm =>$self->item->id, unread => 1, folder => 'inbox'})
		}
	}
	
}
 
sub delete_pms {
	my ($self,$c,$folder) = @_;
	my $params= $c->req->params; 
	foreach my $param (keys %$params)
		{
		if ($param =~ /^pm_(\d*)$/)
			{
			my $item_id = $1;
			if ($c->req->params->{$param} eq 'on') {
				$c->log->debug ($c->req->params->{$param}.$item_id." forund &&&&&&&&&&&");
				my $pm = $self->find({userpm => $c->user->id, itempm => $item_id, folder => $folder},{key => 'user_item_folder'});
				$pm->delete;
			}
		}
	}
}

sub move_pms {
	my ($self,$c,$folder) = @_;
	my $params= $c->req->params; 
	return unless ($c->req->params->{newfolder});
	foreach my $param (keys %$params)
		{
		if ($param =~ /^pm_(\d*)$/)
			{
			my $item_id = $1;
			if ($c->req->params->{$param} eq 'on') {
				$c->log->debug ($c->req->params->{$param}.$item_id." forund &&&&&&&&&&&");
				my $pm = $self->find({userpm => $c->user->id, itempm => $item_id, folder => $folder},{key => 'user_item_folder'});
				$pm->update({folder => $c->req->params->{newfolder}})
			}
		}
	}
}

1;
