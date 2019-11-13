package ClubTriumph::Schema::ResultSet::Menu;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 associates
 

 
=cut
 
sub children {
	my ($self, $pid) = @_;
	my @children = $self->search({parent => $pid->pid});
	return @children
	}

sub anchorable {
	my ($self,$user,$item) = @_;
	return unless $user;
	my $menu_item = ($item->menus)[0];
	my $access_level = $user->access_level;
	my @pids = $self->search({-or => [anchor => {'&' => $access_level},-and => [anchor => {'&' => 1}, user => $user->id]]}); 
	my @anchorable; 
	foreach my $pid (@pids)
	{
		if ($pid->select_active($menu_item))
		{push (@anchorable,$pid)}
#		push (@options,{value =>$pid->pid, label => $pid->select_active($current)})
	}
	return @anchorable;
}

sub viewable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level || 128;
		return $self->search({-or => ["$me.view" => {'&' => $access_level},-and => ["$me.view" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.view" => {'&' => $access_level}});
	}
}

sub messages_viewable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level || 128;
		return $self->search({-or => ["$me.view_messages" => {'&' => $access_level},-and => ["$me.view_messages" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.view_messages" => {'&' => $access_level}});
	}
}


sub messages_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level;
		if ($access_level < 64) {$access_level = 64}
		return $self->search({-or => ["$me.add_message" => {'&' => $access_level},-and => ["$me.add_message" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.add_message" => {'&' => $access_level}});
	}
}

sub images_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level;
		if ($access_level < 64) {$access_level = 64}
		return $self->search({-or => ["$me.add_image" => {'&' => $access_level},-and => ["$me.add_image" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.add_image" => {'&' => $access_level}});
	}
}

sub blogs_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level;
		if ($access_level < 64) {$access_level = 64}
		return $self->search({-or => ["$me.add_blog" => {'&' => $access_level},-and => ["$me.add_blog" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.add_blog" => {'&' => $access_level}});
	}
}

sub news_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level;
		if ($access_level < 64) {$access_level = 64}
		return $self->search({-or => ["$me.add_news" => {'&' => $access_level},-and => ["$me.add_news" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.add_news" => {'&' => $access_level}});
	}
}

sub adverts_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
		my $access_level = $user->access_level || 128;
		return $self->search({-or => ["$me.add_advert" => {'&' => $access_level},-and => ["$me.add_advert" => {'&' => 1}, "$me.user" => $user->id]]});
	}
	else {
		my $access_level = 256; 
		return $self->search({"$me.view_messages" => {'&' => $access_level}});
	}
}

sub shop_addable {
	my ($self,$user) = @_;
	my $me = $self->current_source_alias;
	return unless $user && $user->is_shopkeeper;
	return $self->search({-or => [type => 'html',
				type => 'event',
				type => 'model'
				]});

}
 

1;
