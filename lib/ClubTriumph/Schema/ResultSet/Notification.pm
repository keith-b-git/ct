package ClubTriumph::Schema::ResultSet::Notification;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 

sub add_item {
	my ($self,$item,$user) = @_;
	return unless ($user && $item);
	my $notification = $self->find_or_create({user => $user->id, item => $item->id});
	my $now = DateTime->now;
	my $md5 = Digest::MD5->new;
	$md5->add( $user->username, $item->title, $now->datetime );
	my $code = $md5->hexdigest;
	$notification->update({denotify_code => $code});
}

sub remove_item {
	my ($self,$item,$user) = @_;
	return unless ($user && $item);
	$self->search({user => $user->id, item => $item->id})->delete;
}


sub add_menu {
	my ($self,$menu,$user) = @_;
	return unless ($user && $menu);
	my $notification = $self->find_or_create({user => $user->id, menu => $menu->id});
	my $now = DateTime->now;
	my $md5 = Digest::MD5->new;
	$md5->add( $user->username, $menu->title, $now->datetime );
	my $code = $md5->hexdigest;
	$notification->update({denotify_code => $code});
}

sub remove_menu {
	my ($self,$menu,$user) = @_;
	return unless ($user && $menu);
	$self->search({user => $user->id, menu => $menu->id})->delete;
}
 
sub due {
	my ($self,$c) = @_;
	my $me = $self->current_source_alias;
	my $last_notification = $self->result_source->schema->resultset('DbStatus')->find({id => 1})->last_notification;
	$self->result_source->schema->resultset('DbStatus')->find({id => 1})->update({last_notification => DateTime->now}); #reset the timestamp
	my $items = $self->result_source->schema->resultset('Item')->search({created => {'>' => $last_notification},contenttype => {'!=' => 7}});
	
	my @results;
	my %seen;
	

	foreach my $item ($items->all) {
		foreach my $notification ($item->notifications) {
			if ($notification->user && $notification->user->club_member && $item->viewable_by($notification->user)) {
				unless ($seen{$item->id,$notification->user->id}) {
					push (@results, {'notification' => $notification, item => $item});
					$seen{$item->id,$notification->user->id} =1
				}
			}
		}
		if ($item->thread) {
			foreach my $notification ($item->thread->notifications) {
				if ($notification->user && $notification->user->club_member && $item->viewable_by($notification->user)) {
					unless ($seen{$item->id,$notification->user->id}) {
						push (@results, {'notification' => $notification, item => $item});
						$seen{$item->id,$notification->user->id} =1
					}
				}
			}
		}
		foreach my $menu ($item->menu_items) {
			foreach my $notification ($menu->ancestors->related_resultset('notifications')->all) {
				if ($notification->user && $notification->user->club_member && $item->viewable_by($notification->user)) {
					unless ($seen{$item->id,$notification->user->id}) {
						push (@results, {'notification' => $notification, item => $item});
						$seen{$item->id,$notification->user->id} =1
					}
				}
			}
		}
		if ($item->thread) {
			foreach my $menu ($item->thread->menu_items) {
				foreach my $notification ($menu->ancestors->related_resultset('notifications')->all) {
					if ($notification->user && $notification->user->club_member && $item->viewable_by($notification->user)) {
						unless ($seen{$item->id,$notification->user->id}) {
							push (@results, {'notification' => $notification, item => $item});
							$seen{$item->id,$notification->user->id} =1
						}
					}
				}
			}
		}
	}
	return @results;
;
}
1;
	
