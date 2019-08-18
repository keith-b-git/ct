use utf8;
package ClubTriumph::Schema::Result::Notification;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Notification

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

=head1 TABLE: C<notifications>

=cut

__PACKAGE__->table("notifications");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 item

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 menu

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 last_sortby

  data_type: 'integer'
  is_nullable: 1

=head2 denotify_code

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "item",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "menu",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "last_sortby",
  { data_type => "integer", is_nullable => 1 },
  "denotify_code",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "ClubTriumph::Schema::Result::Item",
  { id => "item" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 menu

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "menu",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "menu" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 user

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "ClubTriumph::Schema::Result::User",
  { id => "user" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-08-27 09:39:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Tv77sg4i+23S3Idaj0QtlQ

sub notify {
	my ($self, $c, $item) = @_;
	my $text;
	my $subject;
#	use Switch;
#	switch ($item->contenttype->id) {
#		case 5 {$subject = 'new thread '.$item->title;}
#		case 6 {$subject = 'new reply to '.$item->thread->title;}
#	}
	if ($item->contenttype->id == 6) {
		$subject = 'new reply to '.$item->thread->title;
	}
	else {
		$subject = 'new '.$item->contenttype->displaytype.' '.$item->title;
	}
	my $object = {item => $item, notification => $self};
	$self->user->send_email($c,'noreply@club.triumph.org.uk',$self->user->email,$subject,'notify_reply.tt2',$object);
	$text = $subject.'<br>'.$item->content.';;'.$item->contenttype->id;
=cut
	return unless ($self->user && $self->user->email);
	my $text;
	my $last_sortby = $self->last_sortby;
	if ($self->item && $self->item->contenttype->id == 5) {
		foreach my $reply ($self->item->items->search({sortby => {'>' => $self->last_sortby}})) {
			$text .= $reply->content;
			$self->user->send_email($c,'noreply@club.triumph.org.uk',$self->user->email,'new reply to '.$self->item->title,'notify_reply.tt2',$reply);
			$last_sortby = $self->item->sortby;
		}
	}
	if ($self-> menu) { 
		foreach my $item ($self->menu->items->search({'item.sortby' => {'>' => $self->last_sortby}})) {
			unless ($self->user->notifications->count({item => $item->id})) {
				$text .= $item->id. $item->title;
				if ($item && $item->contenttype->id == 5) {
					foreach my $reply ($item->items->search({sortby => {'>' => $self->last_sortby}})) {
						$text .= $reply->content;
						$self->user->send_email($c,'noreply@club.triumph.org.uk',$self->user->email,'new reply to '.$item->title,'notify_reply.tt2',$reply);
					}
				}
				if ($item && $item->sortby == $item->created->epoch) {
					$text .= $item->content;
					$self->user->send_email($c,'noreply@club.triumph.org.uk',$self->user->email,'new thread in '.$self->menu->title.' - '.$item->title,'notify_reply.tt2',$item);
				}
			}
		if ($item->sortby > $last_sortby) {$last_sortby = $item->sortby}
		}
	}
	$self->update({last_sortby => $last_sortby});
=cut
	return $text
}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
