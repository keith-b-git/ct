use utf8;
package ClubTriumph::Schema::Result::Menu;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Menu

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

=head1 TABLE: C<menu>

=cut

__PACKAGE__->table("menu");

=head1 ACCESSORS

=head2 pid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 parent

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 item

  data_type: 'integer'
  is_nullable: 1

=head2 heading1

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 heading2

  data_type: 'varchar'
  is_nullable: 1
  size: 450

=head2 link

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 menu_order

  data_type: 'integer'
  is_nullable: 1

=head2 event

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 local_group

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 blog_tag

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 register

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 car

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 club_role

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 entry

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 location

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 championship

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 club_torque

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 linked_role

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 promote_child

  data_type: 'integer'
  is_nullable: 1

=head2 view

  data_type: 'integer'
  is_nullable: 1

=head2 edit

  data_type: 'integer'
  is_nullable: 1

=head2 anchor

  data_type: 'integer'
  is_nullable: 1

=head2 deletable

  data_type: 'integer'
  is_nullable: 1

=head2 add_blog

  data_type: 'integer'
  is_nullable: 1

=head2 view_blogs

  data_type: 'integer'
  is_nullable: 1

=head2 add_image

  data_type: 'integer'
  is_nullable: 1

=head2 view_images

  data_type: 'integer'
  is_nullable: 1

=head2 add_message

  data_type: 'integer'
  is_nullable: 1

=head2 view_messages

  data_type: 'integer'
  is_nullable: 1

=head2 add_event

  data_type: 'integer'
  is_nullable: 1

=head2 add_advert

  data_type: 'integer'
  is_nullable: 1

=head2 view_adverts

  data_type: 'integer'
  is_nullable: 1

=head2 add_shop

  data_type: 'integer'
  is_nullable: 1

=head2 add_news

  data_type: 'integer'
  is_nullable: 1

=head2 add_championship

  data_type: 'integer'
  is_nullable: 1

=head2 path

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 top_pic

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 content

  data_type: 'mediumtext'
  is_nullable: 1

=head2 spidered

  data_type: 'tinyint'
  is_nullable: 1

=head2 manager

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 oldforum

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 mobius_a

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 mobius_b

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 mobius_c

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 mobius_d

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 lft

  data_type: 'double precision'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 rgt

  data_type: 'double precision'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 is_inner

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 image_import_dir

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 import_start

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 import_end

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "pid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "parent",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "item",
  { data_type => "integer", is_nullable => 1 },
  "heading1",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "heading2",
  { data_type => "varchar", is_nullable => 1, size => 450 },
  "link",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "menu_order",
  { data_type => "integer", is_nullable => 1 },
  "event",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "local_group",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "blog_tag",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "register",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "car",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "club_role",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "entry",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "location",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "championship",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "club_torque",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "linked_role",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "promote_child",
  { data_type => "integer", is_nullable => 1 },
  "view",
  { data_type => "integer", is_nullable => 1 },
  "edit",
  { data_type => "integer", is_nullable => 1 },
  "anchor",
  { data_type => "integer", is_nullable => 1 },
  "deletable",
  { data_type => "integer", is_nullable => 1 },
  "add_blog",
  { data_type => "integer", is_nullable => 1 },
  "view_blogs",
  { data_type => "integer", is_nullable => 1 },
  "add_image",
  { data_type => "integer", is_nullable => 1 },
  "view_images",
  { data_type => "integer", is_nullable => 1 },
  "add_message",
  { data_type => "integer", is_nullable => 1 },
  "view_messages",
  { data_type => "integer", is_nullable => 1 },
  "add_event",
  { data_type => "integer", is_nullable => 1 },
  "add_advert",
  { data_type => "integer", is_nullable => 1 },
  "view_adverts",
  { data_type => "integer", is_nullable => 1 },
  "add_shop",
  { data_type => "integer", is_nullable => 1 },
  "add_news",
  { data_type => "integer", is_nullable => 1 },
  "add_championship",
  { data_type => "integer", is_nullable => 1 },
  "path",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "top_pic",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "content",
  { data_type => "mediumtext", is_nullable => 1 },
  "spidered",
  { data_type => "tinyint", is_nullable => 1 },
  "manager",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "oldforum",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "mobius_a",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "mobius_b",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "mobius_c",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "mobius_d",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "lft",
  {
    data_type => "double precision",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "rgt",
  {
    data_type => "double precision",
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "is_inner",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "image_import_dir",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "import_start",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "import_end",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</pid>

=back

=cut

__PACKAGE__->set_primary_key("pid");

=head1 RELATIONS

=head2 blog_menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::BlogMenu>

=cut

__PACKAGE__->has_many(
  "blog_menus",
  "ClubTriumph::Schema::Result::BlogMenu",
  { "foreign.menu" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 car

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Triumphsall>

=cut

__PACKAGE__->belongs_to(
  "car",
  "ClubTriumph::Schema::Result::Triumphsall",
  { id => "car" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 championship

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Championship>

=cut

__PACKAGE__->belongs_to(
  "championship",
  "ClubTriumph::Schema::Result::Championship",
  { id => "championship" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 club_role

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->belongs_to(
  "club_role",
  "ClubTriumph::Schema::Result::ClubRole",
  { id => "club_role" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 club_torque

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Clubtorque>

=cut

__PACKAGE__->belongs_to(
  "club_torque",
  "ClubTriumph::Schema::Result::Clubtorque",
  { edition => "club_torque" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

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

=head2 event

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "ClubTriumph::Schema::Result::Event",
  { id => "event" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 histories

Type: has_many

Related object: L<ClubTriumph::Schema::Result::History>

=cut

__PACKAGE__->has_many(
  "histories",
  "ClubTriumph::Schema::Result::History",
  { "foreign.menu" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 itemcounts

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Itemcount>

=cut

__PACKAGE__->has_many(
  "itemcounts",
  "ClubTriumph::Schema::Result::Itemcount",
  { "foreign.menu_item" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 linked_role

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->belongs_to(
  "linked_role",
  "ClubTriumph::Schema::Result::ClubRole",
  { id => "linked_role" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 local_group

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::LocalGroup>

=cut

__PACKAGE__->belongs_to(
  "local_group",
  "ClubTriumph::Schema::Result::LocalGroup",
  { id => "local_group" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 location

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Location>

=cut

__PACKAGE__->belongs_to(
  "location",
  "ClubTriumph::Schema::Result::Location",
  { id => "location" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 manager

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::ClubRole>

=cut

__PACKAGE__->belongs_to(
  "manager",
  "ClubTriumph::Schema::Result::ClubRole",
  { id => "manager" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.parent" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 new_caches

Type: has_many

Related object: L<ClubTriumph::Schema::Result::NewCache>

=cut

__PACKAGE__->has_many(
  "new_caches",
  "ClubTriumph::Schema::Result::NewCache",
  { "foreign.menu_item" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 notifications

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Notification>

=cut

__PACKAGE__->has_many(
  "notifications",
  "ClubTriumph::Schema::Result::Notification",
  { "foreign.menu" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "ClubTriumph::Schema::Result::Menu",
  { pid => "parent" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 participants

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Participant>

=cut

__PACKAGE__->has_many(
  "participants",
  "ClubTriumph::Schema::Result::Participant",
  { "foreign.menu_item" => "self.pid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 register

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Register>

=cut

__PACKAGE__->belongs_to(
  "register",
  "ClubTriumph::Schema::Result::Register",
  { id => "register" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 top_pic

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "top_pic",
  "ClubTriumph::Schema::Result::Item",
  { id => "top_pic" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
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
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "RESTRICT",
  },
);

=head2 users

Type: many_to_many

Composing rels: L</participants> -> user

=cut

__PACKAGE__->many_to_many("users", "participants", "user");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-08-16 19:16:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:msjsSEWDXlLroYqaFw6APw



#__PACKAGE__->load_components('Tree::Mobius');
#__PACKAGE__->add_mobius_tree_columns();

__PACKAGE__->many_to_many(items => 'blog_menus', 'item');

__PACKAGE__->many_to_many(user_history => 'histories', 'user');


__PACKAGE__->load_components('MaterializedPath');


sub materialized_path_columns {
	return {
	mat_path => {
		parent_column					=> 'parent',
		parent_fk_column             => 'pid',
		materialized_path_column     => 'path',
		include_self_in_path         => 1,
		include_self_in_reverse_path => 1,
		separator                    => '/',
		parent_relationship          => 'parent',
		children_relationship        => 'menus',
		full_path						=> 'ancestors',
		reverse_full_path				=> 'descendants',
		}
	}
}

sub children {
my $self = $_[0];
my @children =  $self ->menus;
#my @children =  $self ->menus_rs->search({blog_tag => 'user'});
@children = sort {$a->menu_order <=> $b->menu_order} @children;
#return  $self ->menus;
return @children
}

=cut
sub descendants {
    my $self = shift;
	if ($self->is_inner) {
		return $self->result_source->resultset->search({
			$self->result_source->resultset->current_source_alias.'.'.$self->_lft_column => { '>=' => $self->get_column($self->_lft_column) },
			$self->result_source->resultset->current_source_alias.'.'.$self->_rgt_column => { '<=' => $self->get_column($self->_rgt_column) },
		});
	}
	else {return $self->result_source->resultset->search({pid => $self->pid})}
}


sub descendants {
    my $self = shift;

	return $self->result_source->resultset->search({-or => [
		pid => $self->pid, -and => [
		$self->result_source->resultset->current_source_alias.'.'.$self->_lft_column => { '>' => $self->get_column($self->_lft_column) },
		$self->result_source->resultset->current_source_alias.'.'.$self->_rgt_column => { '<' => $self->get_column($self->_rgt_column) }]
	]});

}
=cut
#__PACKAGE__->add_unique_constraint(['register']);
#__PACKAGE__->add_unique_constraint(['event']);

sub hierachy
{
	my ($obj) = $_[0];
	my @hierachy;
	while ($obj&&($obj->pid >1))
	{
		push (@hierachy,$obj->title);
		$obj = $obj->parent;
	}
	return @hierachy
}
=cut


sub grand_children {
my $self = $_[0];
my @children =  $self ->menus_rs->menus;
#my @children =  $self ->menus_rs->search({blog_tag => 'user'});
@children = sort {$a->menu_order <=> $b->menu_order} @children;
#return  $self ->menus;
return @children
}
=cut
sub viewable_children {
my ($self,$user,$rows,$page) = @_;
unless($page) {$page = 1}
unless ($rows) {$rows =99}
my $access_level = 256;
my @children;
if ($user) {
	$access_level = $self->access_level($user) || 128;
	@children =  $self ->menus_rs->search({-or => [view => {'&' => $access_level},-and => [view => {'&' => 1}, user => $user->id]]},{rows => $rows, page => $page, order_by => 'menu_order'})
	}
else {
	@children =  $self ->menus_rs->search({view => {'&' => $access_level}},{rows => $rows, page => $page, order_by => 'menu_order'});
	}
#@children = sort {$a->menu_order <=> $b->menu_order} @children;
return @children
}

sub viewable_children_rs {
my ($self,$user) = @_;
my $access_level = 256;
my $children;
if ($user) {
	$access_level = $self->access_level($user) || 128;
	$children =  $self ->menus_rs->search_rs({-or => [view => {'&' => $access_level},-and => [view => {'&' => 1}, user => $user->id]]},{order_by => 'menu_order'})
	}
else {
	$children =  $self ->menus_rs->search_rs({view => {'&' => $access_level}},{order_by => 'menu_order'});
	}
#@children = sort {$a->menu_order <=> $b->menu_order} @children;
return $children
}

sub viewable_links {
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my @children =  $self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub viewable_link_count {
my ($self,$user) = @_;
return $self->viewable_children_rs($user)->count({type => {'!=' => 'event'}});
}

sub viewable_events {
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my @children =  $self->viewable_children_rs($user)->search({type => 'event'},{rows => $rows});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub future_events {
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now;
my @children =  $self->descendants->viewable($user)->search({"$me.type" => 'event', 
					"$me.pid" => {'!=' => $self->pid}, 
					'event.end' => {'>' =>  $dtf->format_datetime($now)}},
					{rows => $rows, prefetch => 'event', order_by => 'event.start'});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub current_future_event_count {
my ($self,$user) = @_;
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
if ($self->type eq 'user_profile' && $self->user->memno) {
	return $self->user->entrants->related_resultset('team')->related_resultset('event')
	->count({'end' => {'>=' =>  $dtf->format_datetime($now)}},{ group_by => 'id'})
}
if ($self->type eq 'register' ) {
	return $self->register->entries->related_resultset('event')
	->count({'end' => {'>=' =>  $dtf->format_datetime($now)}},{ group_by => 'id'})
}
return $self->descendants->viewable($user)->count({"$me.type" => 'event',
				"$me.pid" => {'!=' => $self->pid}, 
				'event.end' => {'>=' =>  $dtf->format_datetime($now)}},
				{prefetch => 'event'});
}


sub current_future_events { # returns events finishing either in the future or the last month, unless there isn't a future one in which case the last year
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
my @children;
if ($self->type eq 'user_profile' && $self->user->memno) {
	my @children = $self->user->entrants->related_resultset('team')->related_resultset('event')
		->search({'end' => {'>=' =>  $dtf->format_datetime($now)}},{order_by => 'start', group_by => 'id'})->related_resultset('menus')->all
		;
	return @children;
}
if ($self->type eq 'register' ) {
	my @children = $self->register->entries->related_resultset('event')
		->search({'end' => {'>=' =>  $dtf->format_datetime($now)}},{order_by => 'start', group_by => 'id'})->related_resultset('menus')->all
		;
	return @children;
}
@children =  $self->descendants->viewable($user)->search({"$me.type" => 'event', 
					"$me.pid" => {'!=' => $self->pid}, 
					'event.end' => {'>=' =>  $dtf->format_datetime($now)}},
					{rows => $rows, prefetch => 'event', order_by => 'event.start'});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub non_current_event_count {
my ($self,$user) = @_;
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
if ($self->type eq 'user_profile' && $self->user->memno) {
	return $self->user->entrants->related_resultset('team')->related_resultset('event')
	->count({'end' => {'<' =>  $dtf->format_datetime($now)}},{ group_by => 'id'})
}
if ($self->type eq 'register' ) {
	return $self->register->entries->related_resultset('event')
	->count({'end' => {'<' =>  $dtf->format_datetime($now)}},{ group_by => 'id'})
}
return $self->descendants->viewable($user)->count({"$me.type" => 'event',
				"$me.pid" => {'!=' => $self->pid}, 
				'event.end' => {'<' =>  $dtf->format_datetime($now)}},
				{prefetch => 'event'});
}


sub non_current_events { # returns events which aren't current or future
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
if ($self->type eq 'user_profile' && $self->user->memno) {
	my @children = $self->user->entrants->related_resultset('team')->related_resultset('event')
		->search({'end' => {'<' =>  $dtf->format_datetime($now)}},{order_by => {-desc => 'start'}, group_by => 'id'})->related_resultset('menus')->all
		;
	return @children;
}
if ($self->type eq 'register' ) {
	my @children = $self->register->entries->related_resultset('event')
		->search({'end' => {'<' =>  $dtf->format_datetime($now)}},{order_by => {-desc => 'start'}, group_by => 'id'})->related_resultset('menus')->all
		;
	return @children;
}
my @children =  $self->descendants->viewable($user)->search({"$me.type" => 'event', 
					"$me.pid" => {'!=' => $self->pid}, 
					'event.end' => {'<' =>  $dtf->format_datetime($now)}},
					{rows => $rows, prefetch => 'event', order_by => {-desc => 'event.start'}});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub latest_event {
my ($self,$user) = @_;

my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
if ($self->type eq 'member_profile' && $self->user->current_member) {
	return $self->user->memno->entrants->related_resultset('Entry')->related_resultset('Event')
		->search({},{order_by => {-desc => 'event.end'}})->single->menus->first
}
return  $self->descendants->viewable($user)->search({"$me.type" => 'event', 
					"$me.pid" => {'!=' => $self->pid}}, 
					{rows => 1, prefetch => 'event', order_by => {-desc => 'event.end'}})->single;
}


sub future_event_count {
my ($self,$user) = @_;
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now;
return $self->descendants->viewable($user)->count({"$me.type" => 'event',
				"$me.pid" => {'!=' => $self->pid}, 
				'event.end' => {'>' =>  $dtf->format_datetime($now)}},
				{prefetch => 'event'});
}

sub past_events {
my ($self,$user,$rows, $page) = @_;
unless ($rows) {$rows =99}
unless ($page) {$page = 1}
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now;
my @children =  $self->descendants->viewable($user)->search({"$me.type" => 'event',
				"$me.pid" => {'!=' => $self->pid}, 
				'event.end' => {'<' =>  $dtf->format_datetime($now)}},
				{rows => $rows, page => $page, prefetch => 'event', order_by => {-desc => 'event.start'}});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub past_event_count {
my ($self,$user) = @_;
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $me = $self->result_source->resultset->current_source_alias;
my $now = DateTime->now;
return $self->descendants->viewable($user)->count({"$me.type" => 'event',
				"$me.pid" => {'!=' => $self->pid}, 
				'event.end' => {'<' =>  $dtf->format_datetime($now)}},
				{prefetch => 'event'});
}


sub current_children {
my ($self,$user,$rows) = @_;
unless ($rows) {$rows =99}
my $c = ClubTriumph->ctx or die "Not in a request!";
if ($self->type eq 'groupsroot' && $user && $c->session && $c->session->{groupsinorder}) {
	my @groups;
	my $groupsinorder = $c->session->{groupsinorder};
	foreach my $child (@$groupsinorder) {
		my $group = $self->viewable_children_rs($user)->find({pid => $child});
		if ($group) { push (@groups, $group)}; 
	}
	return @groups;
}
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $now = DateTime->now->clone->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
my @children =  $self->viewable_children_rs($user)->search({-or => [type => {'!=' => 'event'},
		-and => [type => 'event', 'event.end' => {'>=' =>  $dtf->format_datetime($now)}]]},{rows => $rows, prefetch => 'event'});
#return [$self->viewable_children_rs($user)->search({type => {'!=' => 'event'}},{rows => $rows})->all];
return @children;
}

sub current_children_rs {
my ($self,$user,$rows) = @_;
my $dtf = $self->result_source->schema->storage->datetime_parser;
my $now = DateTime->now->clone->subtract(months => 1);
my $latest_event = $self->latest_event($user);
if ($latest_event && DateTime->compare($now, $latest_event->event->end)>0) {
	if (DateTime->compare($now->clone->subtract(months => 11),$latest_event->event->end) < 0) {
		$now = $latest_event->event->end }
	else {
		$now = $now->clone->subtract(months => 11)
		}
	}
return $self->viewable_children_rs($user)->search({-or => [type => {'!=' => 'event'},
		-and => [type => 'event', 'event.end' => {'>=' =>  $dtf->format_datetime($now)}]]},{ prefetch => 'event'});
}

sub viewable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->view,$user)
}

sub editable_by {
	my ($self, $user) =@_;
	unless ($user && $user->club_member) {return 0}
	if ($self->accessible($self->edit,$user)) {return 1}
	if ($user) {return $user->organiser_of($self)}
}

sub anchorable_by {
	my ($self, $user) =@_;
	unless ($user && $user->club_member) {return 0}
	if ($self->accessible($self->anchor,$user)) {return 1}
	if ($user) {return $user->organiser_of($self)}
}

sub deletable_by {
	my ($self, $user) =@_;
	unless ($user && $user->club_member) {return 0}
	return $self->accessible($self->deletable,$user)
}

sub blogs_viewable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->view_blogs,$user)
}

sub blogs_addable_by {
	my ($self, $user) =@_;
	unless ($user && $user->club_member) {return 0}
	return $self->accessible($self->add_blog,$user)
}

sub images_viewable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->view_images,$user)
}

sub images_addable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->add_image,$user)
}

sub messages_viewable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->view_messages,$user)
}

sub messages_addable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->add_message,$user)
}

sub events_addable_by {
	my ($self, $user) =@_;
	if ($self->accessible($self->add_event,$user)) {return 1}
	if ($user) {return $user->organiser_of($self)}
}

sub adverts_viewable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->view_adverts,$user)
}

sub advert_addable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->add_advert,$user)
}

sub shop_addable_by {
	my ($self, $user) =@_;
	return unless $user;
#	return $self->accessible($self->add_shop,$user)
	return $user->is_shopkeeper;
}

sub championship_addable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->add_championship,$user)
}

sub news_addable_by {
	my ($self, $user) =@_;
	if ($self->accessible($self->add_news,$user)) {return 1}
	if ($user) {return $user->organiser_of($self)}
}

sub diary_viewable_by {
	my ($self, $user) =@_;
	return (($self->type eq 'event') || ($self->type eq 'entry') || ($self->type eq 'entrylist'))
}

sub accessible {
	my ($self,$level,$user) = @_;
	unless ($level) {$level = 0}
	return ($self->access_level($user) & $level);
	unless ($user) { return ($level & 256)}
	return (($level >= $user->access_level)
		|| (($level & 1) && $self->user && $self->user->id && ($self->user->id == $user->id))
#		|| (($level ==8) && $self->manager && $user->club_member && ($self->manager->members->count({memno => $user->memno->memno}))))
		|| (($level & 8) && $user->club_member && $self->ancestors->related_resultset('manager')->count({})  
			&& ($self->ancestors->related_resultset('manager')->related_resultset('member_club_roles')->related_resultset('member')->count({memno => $user->memno->memno}))) # cascade managers
		|| (($level & 32) && $self->ancestors->related_resultset('event')->related_resultset('entries')->count({
			-or => ['entries.user' => $user->id,
					'entrants.user' => $user->id], 
			-or => [status => 'live', status => 'complimentary']},{prefetch => 'entrants'}))
		) 
	}

sub admin_by {
	my ($self, $user) = @_;
	return 0 unless ($user);
	return (($self->type eq 'user_profile' && $self->user->id == $user->id) ||
	$self->editable_by($user) || 
	$self->anchorable_by($user) || 
	$self->events_addable_by($user) || 
	$self->shop_addable_by($user))
}

sub no_siblings { #returns no of siblings
	my $self = $_[0];
	return 1 unless $self -> parent;
	my $siblings = scalar($self->parent->menus);
	return $siblings;
}

=cut
sub select_active {
	my ($self,$pid) = @_;
	return 0 unless $self;
	return 1 unless $pid ;
	return 1 unless $pid->parent;
	return 0 unless $pid->pid;
	return 0 unless $self->pid;
	if ($pid->pid == 1) {return 0}
	my $active = 1;
	if ($self->pid == $pid->pid) {$active = 0}
	while (($self->pid > 1)&&$self->parent)
	{
		$self = $self->parent;
		unless ($self) {$active =0; next}
		if ($self->pid == $pid->pid) {$active = 0}
	}
	return $active
}
=cut

sub title {
	my ($self,$user) = @_;
	my $title = ' ';
	if ($self -> type eq 'user_profile')
	{
#		if ($self->user->memno && $self->user->memno > 0) {return $self->user->memno->fullname}
#		if ($self->user->username) {return $self->user->username}
		if ($self->user && $user && ($user->id == $self->user->id)) {return 'User Profile'}
		my $c = ClubTriumph->ctx;
		if ($c && $c->user_exists) {
			$title = $self->user->fullname; 
			unless ($self->user->username eq $title) {$title .= ' "'.$self->user->username.'"'}
		}
		else {
			$title .= '"'.$self->user->username.'"'
		}
	}
	if ($self -> event)
	{
		if ($self -> event -> title) {$title =  $self -> event -> title}
	}
	if ($self -> register)
	{
		if ($self -> register -> regno) {$title = $self -> register -> known_as}
	}
	if ($self -> local_group)
	{
		if ($self -> local_group -> title) {$title = $self -> local_group -> title}
	}
	if ($self -> car)
	{
	#	if ($self -> car->triumph->model->model  && $self -> car->triumph->mark->mark) 
		{$title = $self->car->triumph->model->model.$self->car->triumph->mark->mark.' '.$self->car->body->body}
	}
	if ($self -> type eq 'model')
	{
#		if ($self -> heading1) {$self->update({heading1 => $self -> heading1})}
#		if ($self->menus->first->menus->first->car->triumph->model  && $self->menus->first->menus->first->car->triumph->mark) {
#			return $self->menus->first->menus->first->car->triumph->model->model.$self->menus->first->menus->first-> car->triumph->mark->mark
#			}
	}
	if ($self -> type eq 'mark')
	{
#		if ($self -> heading1) {return $self -> heading1}
#		if ($self -> car->model->model  && $self -> car->mark->mark) {return $self -> car->model->model.$self -> car->mark->mark}
	}
	if ($self->type eq 'club_role') {
		use Lingua::EN::Inflexion qw< noun inflect >;
		$title = inflect('<#d:'.$self->club_role->members->count({}).'><N:'.$self->club_role->description.'>') ;
	}
	if ($self->type eq 'championship') {
		$title = $self->championship->title.' '.$self->championship->year}

	if ($self->type eq 'entry') {
		if ($self->entry->title) {
			$title = $self->entry->title.'- '.$self->entry->event->title
		}
		else {
			$title = 'team '.$self->entry->entry_no.'- '.$self->entry->event->title
		}
	}
	if ($self->type eq 'location') {
		$title =  $self->location->name}
	if ($title ne ' ') {
		if ($title ne $self->heading1) {
#			$self->update({heading1 => $title});
			return $title;
			
		}
	}
	return $self->heading1;
}

sub typedesc {
	my $self = $_[0];


	if ($self -> event)
	{
		if ($self -> event -> title) {return 'event'}
	}
	if ($self -> register)
	{
		if ($self -> register -> regno) {return 'car'}
	}
	if ($self -> local_group)
	{
		if ($self -> local_group -> title) {return 'local group'}
	}
	if ($self -> car)
	{
	#	if ($self -> car->triumph->model->model  && $self -> car->triumph->mark->mark) 
		{return 'triumph'}
	}
	if ($self -> type eq 'model')
	{
		return 'model'
	}
	if ($self -> type eq 'mark')
	{
		return 'model'
	}
	if ($self->type eq 'club_role') {
		return 'club role'}

	if ($self->type eq 'entry') {
		return 'entry'}
	if ($self->type eq 'location') {
		return 'location'}
	return " ";
}





sub html {
	my $self = $_[0];
	if ($self->item) {return $self -> item -> html}
	return $self -> title;
}

sub url {
	my $self = $_[0];
	if ($self->item) {return '/menu/'.$self -> pid.'/view'}
	if ($self->type eq 'link') {return $self->link}
	return '/menu/'.$self -> pid.'/view'
}

sub order_children { #re-orders sequentialy after change
	my $self = $_[0];
	my @children = $self->children;
	my $order = 1;
	foreach my $child (@children)
	{
		$child->update({menu_order => $order});
		$order++
	}
}

sub alpha_sort_children { #re-orders alphabetically 
	my $self = $_[0];
	my @children = $self->children; 
	@children = sort {$a->title cmp $b->title} @children;
	my $order = 1;
	foreach my $child (@children)
	{
		$child->update({menu_order => $order});
		$order++
	}
}

sub make_last { #makes item moveto the end when moved to new parent
	my $self = $_[0];
	return unless $self->parent;
	my $order = $self->parent->menus->get_column('menu_order')->max + 1;
	$self->update({menu_order => $order})
}

sub blogs {
	my ($self,$user, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->items_bytype_viewable_by($user,2, $rows,$page)->all; #search({},{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => 'sortby'}});
#	return $self->items->items_viewable_by($user)
#	->search({'contenttype' => 2},{rows => $rows,page => $page,group_by => 'id', order_by => {-desc => 'created'}});

#	my $blogs = $self->search_related('blog_menus')->search_related('item' => {'contenttype' => '2'},{  order_by => {-desc => 'modified'}}); #, order_by => {-desc => 'modified'}
#	return $blogs->items_viewable_by($user)->search({},{rows => $rows,page => $page,group_by => 'id', order_by => {-desc => 'modified'}});
}

sub news {
	my ($self,$user, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
#	return $self->items_bytype_viewable_by($user,12)->within_date->search({},{rows => $rows,page => $page,group_by => 'id', order_by => {-desc => 'id'}});
	return $self->local_items->items_bytype_viewable_by($user,12)->within_date->search({},{rows => $rows,page => $page,group_by => 'id', order_by => {-desc => 'id'}});
}

sub images {
	my ($self,$user, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, contenttype => 3},
			{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
	}
	else {
#		return $self->items->items_bytype_viewable_by($user,3)->search({},{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => 'sortby'}});
		return $self->items_bytype_viewable_by($user,3,$rows,$page)->all
	}
#	return $self ->search({'contenttype' => '3'},{join => {'blog_menus' => 'item'}, rows => $rows,page => $page}); #, order_by => {-desc => 'modified'}
#	my $images = $self->search_related('blog_menus')->search_related('item' => {'contenttype' => '3'},{  order_by => {-desc => 'id'}}); #, order_by => {-desc => 'modified'}
#	return $images->items_viewable_by($user)->search({},{rows => $rows,page => $page,group_by => 'id', order_by => {-desc => 'id'}});
}

sub adverts {
	my ($self,$user, $type, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return unless ($type == 9 || $type == 10 || $type == 11);
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, contenttype => $type},
			{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
	}
	return $self->items_bytype_viewable_by($user,$type,$rows,$page)->within_date;
#	return $self ->search({'contenttype' => '3'},{join => {'blog_menus' => 'item'}, rows => $rows,page => $page}); #, order_by => {-desc => 'modified'}
	my $adverts = $self ->search_related('blog_menus')->search_related('item' => { 'contenttype' => '9'},{  order_by => {-desc => 'id'}}); #, order_by => {-desc => 'modified'}
	return $adverts->items_viewable_by($user)->search({},{rows => $rows,page => $page,group_by => 'id', order_by => ['contenttype',{-desc => 'id'}]});
}

sub shop_items {
	my ($self,$user, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->items_bytype_viewable_by($user, 8, $rows, $page);
#	return $self ->search({'contenttype' => '3'},{join => {'blog_menus' => 'item'}, rows => $rows,page => $page}); #, order_by => {-desc => 'modified'}
	my $adverts = $self ->search_related('blog_menus')->search_related('item' => {'contenttype' => '8'},{  order_by => {-desc => 'id'}}); #, order_by => {-desc => 'modified'}
	return $adverts->items_viewable_by($user)->search({},{rows => $rows,page => $page,group_by => 'id', order_by => ['contenttype',{-desc => 'id'}]});
}

sub items_viewable_by {
	my ($self,$user, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->items->items_viewable_by($user)->search({},{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => 'sortby'}});
}



sub next_image {
	my ($self, $user, $item) = @_;
	return $self->images($user,999999)->next_item($item)

}

sub next {
	my ($self, $user, $item) = @_;
	if ($item->contenttype->id ==7) { #pm
#		return ($user->pms->search({folder => $item->
	}
	else {
		return $self->items->items_viewable_by($user)->search({contenttype => $item->contenttype->id,'item.sortby' => {'>' => $item->sortby}},{order_by => 'item.sortby', rows => 1, alias => 'item'})->single;	
	}
#	if ($item->contenttype->type eq 'Image') {
#		return $self->images($user,999999)->next_item($item) }
#	if ($item->contenttype->type eq 'Thread') {
#		return $self->threads($user,999999)->next_item($item) }
}

sub previous {
	my ($self, $user, $item) = @_;
	return $self->items->items_viewable_by($user)->search({contenttype => $item->contenttype->id,'item.sortby' => {'<' => $item->sortby}},{order_by => {'-desc' => 'item.sortby'}, rows => 1, alias => 'item'})->single;
#	if ($item->contenttype->type eq 'Image') {
#		return $self->images($user,999999)->prev_item($item)}
#	if ($item->contenttype->type eq 'Thread') {
#		return $self->threads($user,999999)->prev_item($item)}
}

sub prev_image {
	my ($self, $user, $item) = @_;
	return $self->images($user,999999)->prev_item($item)

}

sub threads {
	my ($self, $user, $rows, $page, $unread) = @_;
	return unless ($self->messages_viewable_by($user));
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	my $sticky = 0;
	if ($self->add_message > 0) {$sticky = 1}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, -or => [contenttype => 5, contenttype =>6] },
			{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
	}
	else {
		return [$self->items_bytype_viewable_by($user,5,$rows,$page,$sticky,$unread)];#->search({},{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
	}
}

sub local_threads {
	my ($self, $user, $rows, $page) = @_;
	return unless ($self->messages_viewable_by($user));
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	

	return $self->search_related('blog_menus',{ancs => undef})->search_related('item')->items_bytype_viewable_by($user,5)
		->search({},{rows => $rows,page => $page,group_by => 'sortby', order_by => {-desc => ['sticky','sortby']}});
	
}

sub image_count {
	my $self = $_[0];
	return $self -> items -> count({contenttype => '3'})
}
=l
sub all_image_count {
	my $self = $_[0];
	my $count = $self -> items -> count({contenttype => '3'});
	foreach my $child ($self->children) {
#		$count += $child -> items -> count({contenttype => '3'});
		$count += $child -> all_image_count;
	}
	return $count;
}
=cut
sub all_image_count {
	my $self = $_[0];
	return $self ->search_related('blog_menus')->search_related('item')->count({'contenttype' => '3'},{group_by => 'id'});
}

sub viewable_image_count {
	my ($self,$user) = @_;
#	return scalar($self->search_related('blog_menus')->search_related('item')->items_bytype_viewable_by($user,3)->count({},{group_by => 'sortby'}));
	return $self->viewable_item_count($user,3)
}

sub viewable_blog_count {
	my ($self,$user) = @_;
#	return $self->search_related('blog_menus')->search_related('item')->items_bytype_viewable_by($user,2)->count({},{group_by => 'id'});
	return $self->viewable_item_count($user,2)
}

sub blog_count {
	my ($self,$user) = @_;
	return $self->items_bytype_viewable_count($user,2);
}

sub news_count {
	my ($self,$user) = @_;
	return $self->items_bytype_viewable_count($user,12);
}

sub thread_count {
	my ($self,$user) = @_;
	return $self->viewable_item_count($user,5);
	my $access_level = 256;
	my $userid =-1;
	if ($user) {$access_level = $user->access_level || 128; $userid = $user->id}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_bytype_viewable_by($user,5)->count({author => $user->id, contenttype => '5'},
		{group_by => 'sortby' });
	}
	else {
#		return $self -> descendants
#			->search({-or => ['me.view_messages' => {'>=' => $access_level},-and => ['me.view_messages' => 1, 'me.user' => $userid]]})
#			->search_related('blog_menus')->search_related('item')->count({contenttype => '5'},
#			{group_by => 'id'})
		return $self->items_bytype_viewable_count($user,5);
	}
}

sub viewable_advert_count {
	my ($self,$user) = @_;
	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->count({'contenttype' => '8'},{group_by => 'id'});
}

sub shop_count {
	my ($self,$user) = @_;
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->count({'contenttype' => '8'},{group_by => 'id'});
	return $self->viewable_item_count($user,8)
}

sub car_sale_count {
	my ($self,$user) = @_;
	return $self->items_bytype_viewable_by($user,9)->within_date->count({});
#	return $self->viewable_item_count($user,9)
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->count({'contenttype' => '9'},{group_by => 'id'});
}

sub part_sale_count {
	my ($self,$user) = @_;
	return $self->items_bytype_viewable_by($user,10)->within_date->count({});
#	return $self->viewable_item_count($user,10)
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->count({'contenttype' => '10'},{group_by => 'id'});
}

sub wanted_count {
	my ($self,$user) = @_;
	return $self->items_bytype_viewable_by($user,11)->within_date->count({});
#	return $self->viewable_item_count($user,11)
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->count({'contenttype' => '11'},{group_by => 'id'});
}

sub viewable_item_count { #this is the cache version
	my ($self,$user,$type) = @_;
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_bytype_viewable_by($user,$type)->count({author => $self->user->id},
		{group_by => 'sortby' });
	}
	my $access_level = $self->access_level($user) & 510;
	my $cache = $self->new_caches->search({type => $type, level => $access_level, count => {'!=' => undef}})->first;
	if ($cache) {return $cache->count} 
	else {
		my $count = $self->items_bytype_viewable_count($user,$type);
		my $cache = $self->new_caches->find_or_create({menu_item => $self->pid, type => $type, level => $access_level});
		$cache->update({count => $count});
		return $count
	}
}
	
	
sub unread_item_count { 
	my ($self,$user,$type) = @_;
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_bytype_viewable_by($user,$type)->count({author => $self->user->id},
		{group_by => 'sortby' });
	}
	my $access_level = $self->access_level($user) & 510;
	my $count = $self->items_bytype_viewable_count($user,$type,1);
	return $count
}

sub latest_item {
	my ($self,$user,$type) = @_;
	
	my $access_level = $self->access_level($user) & 510;
	my $cache = $self->new_caches->search({type => $type, level => $access_level, latest => {'!=' => undef}})->first;
	if ($cache) {return $cache->latest} 
	else {
		my $latest = $self->items_bytype_viewable_by($user,$type,1,1)->single;
		my $cache = $self->new_caches->find_or_create({menu_item => $self->pid, type => $type, level => $access_level});
		$cache->update({latest => $latest});
		return $latest
	}
}
=cut	
	return $self->items_bytype_viewable_by($user,$type,1,1)->single;
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => $type},
#	{group_by => 'sortby', sort_by => {-desc => 'sortby'}, rows =>1})->single;
	my $access_level=256;
	if ($user) {
		$access_level = $self->access_level($user) || 128;
	}
	my $level = 512;
	my $latest;
	my $cache = $self->itemcounts->find({contenttype => $type});
	if ($cache) {
		while ($level >= 1) {
			if ($access_level & $level && $cache->get_column('lat'.$level)) {
				my $item = $self->result_source->schema->resultset('Item')->find({id => $cache->get_column('lat'.$level)});
				if ($item) {
					if ($latest) {
						if ($item->sortby > $latest->sortby) {$latest = $item}
					}
					else {$latest = $item}
					}
				}
			$level = $level / 2;
		}
	}
	return $latest;

#	return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->count({contenttype => $type, 'blog_menus.menu' => $self->pid},{group_by => 'sortby', prefetch => 'blog_menus'});
}
=cut

sub local_item_count {
	my ($self,$user,$type) = @_;
#	return $self->search_related('blog_menus',{ancs => undef})->search_related('item')->items_viewable_by($user)->count({'contenttype' => $type},{group_by => 'sortby'});

	my $access_level = $self->access_level($user) & 510;
	my $cache = $self->new_caches->search({type => $type, level => $access_level, lcount => {'!=' => undef}})->first;
	if ($cache) {return $cache->lcount} 
	else {
		my $count = $self->items_bytype_local_count($user,$type);
		my $cache = $self->new_caches->find_or_create({menu_item => $self->pid, type => $type, level => $access_level});
		$cache->update({lcount => $count});
		return $count
	}
}
=cut
	return $self->items_bytype_local_count($user,$type);
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
#	my $level = 512;
	my $count = 0;
	my $cache = $self->itemcounts->find({contenttype => $type});
	if ($cache) {
#			while ($level >= $access_level) {
			$count += $cache->get_column('l'.$access_level ) || 0;
#			$level = $level / 2;
#		}
	}
	return $count;
}
=cut

sub latest_local {
	my ($self,$user,$type) = @_;
	
	my $access_level = $self->access_level($user) & 510;
	my $cache = $self->new_caches->search({type => $type, level => $access_level, latloc => {'!=' => undef}})->first;
	if ($cache) {return $cache->latloc} 
	else {
		my $latest = $self->items_bytype_viewable_local($user,$type,1,1)->single;
		my $cache = $self->new_caches->find_or_create({menu_item => $self->pid, type => $type, level => $access_level});
		$cache->update({latloc => $latest});
		return $latest
	}
}
=cut
	return $self->items_bytype_viewable_local($user,$type,1,1)->first;
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => $type},
#	{group_by => 'sortby', sort_by => {-desc => 'sortby'}, rows =>1})->single;
	my $access_level=256;
	if ($user) {
		$access_level = $self->access_level($user) || 128;
	}
	my $level = 512;
	my $latest;
	my $cache = $self->itemcounts->find({contenttype => $type});
	if ($cache) {
		while ($level >= 1) {
			if ($level & $access_level && $cache->get_column('loc'.$level)) {
				my $item = $self->result_source->schema->resultset('Item')->find({id => $cache->get_column('loc'.$level)});
				if ($item) {
					if ($latest) {
						if ($item->sortby > $latest->sortby) {$latest = $item}
					}
					else {$latest = $item}
					}
				}
			$level = $level / 2;
		}
	}
	return $latest;

#	return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->count({contenttype => $type, 'blog_menus.menu' => $self->pid},{group_by => 'sortby', prefetch => 'blog_menus'});
}
=cut
sub local_items {
	my ($self, $user, $rows, $page) = @_;
	return $self->search_related('blog_menus',{ancs => undef})->related_resultset('item');
}



sub viewable_item_position {
	my ($self,$user,$item) = @_;
	my $type = $item->contenttype->id;
	return $self->search_related('blog_menus')->search_related('item')
	->items_viewable_by($user)->count({'contenttype' => $type, 'item.created' => {'>=' => $item->created}},{group_by => 'sortby',order_by => {'-desc' => 'item.created'}});
}

sub read_item_count {
	my ($self,$user,$type) = @_;
	unless ($user && $type) {return 0}
#	return $self->search_related('blog_menus')->search_related('item')->items_read_by($user)->items_viewable_by($user)->count({'contenttype' => $type},{group_by => 'id'});
#	return $self ->items->items_bytype_viewable_by($user,$type)->search({})->related_resultset('items_read')->count({'items_read.user' => $user->id},{group_by => 'item'});
#
#	return $self ->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => $type},{group_by => 'id'})->related_resultset('items_read')->count({user => $user->id});
	return  $self->result_source->schema->resultset('BlogMenu')->search({

		type => $type,
		path => {'like' => $self->path.'%'}
	})->related_resultset('item')->related_resultset('items_read')->count({'items_read.user' => $user->id},{group_by => 'item'});
}

sub post_count {
	my ($self,$user,$type) = @_;
	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => 5},{group_by => 'sortby'})->related_resultset('items')->count({});
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => 5},{group_by => 'sortby'})->get_column('posts')->sum;
}

sub local_post_count {
	my ($self,$user,$type) = @_;
	return $self->search_related('blog_menus',{ancs => undef})->search_related('item')->items_viewable_by($user)->search({'contenttype' => 5},{group_by => 'sortby'})->related_resultset('items')->count({});
#	return $self->search_related('blog_menus')->search_related('item')->items_viewable_by($user)->search({'contenttype' => 5},{group_by => 'sortby'})->get_column('posts')->sum;
}


sub viewable_items {
	my ($self,$user,$type) = @_;
	return $self->items->items_viewable_by($user)->search({'contenttype' => $type},{group_by => 'id'});
}

sub context_related {
	my ($self,$user,$rows) = @_;
	my @menu_items;
#	if ($self->parent) {
#		push (@menu_items,{page => $self->parent, context => 'parent'})
#	}
	if (($self->type eq 'user_profile') && ($self->user->memno)) {
		foreach my $role ($self->user->memno->club_roles) {
			push (@menu_items,{page => $role->menus->first, context => 'Club Role', icon => 'role'})
		}
		foreach my $role ($self->user->memno->local_groups) {
			push (@menu_items,{page => $role->menus->first, context => 'Local Group Organiser', icon => 'role'})
		}
		foreach my $role ($self->user->memno->events) {
			push (@menu_items,{page => $role->menus->first, context => 'Organiser', icon => 'role'})
		}
		foreach my $car ($self->user->memno->registers) {
			push (@menu_items,{page => $car->menus->first, context => 'car', icon => 'car'});
		}
		if ($self->user->memno->local_group && (@menu_items < $rows)) {
			push (@menu_items,{page => $self->user->memno->local_group->menus->first, context => 'Local Group'})}
		foreach my $team ($self->user->memno->entrants) {
			last if (@menu_items >= $rows);
			push (@menu_items,{page => $team->team->menus->first, context => 'Event Entry'}) if $team->team
			}
		}
	if ($self->type eq 'register' && $self->register) {
		unless ($self->register->triumph->menus->first->parent->parent->type eq'carsroot') {
			push (@menu_items, {page =>  $self->register->triumph->menus->first->parent->parent, context => 'triumph', icon => 'car'});}
		push (@menu_items, {page =>  $self->register->triumph->menus->first->parent, context => 'model', icon => 'car'});
#		push (@menu_items, $self->register->triumph->menus->first);
		if ($self->register->memno && $self->register->memno->userid && $self->register->memno->userid->profile && $self->register->memno->userid->profile->viewable_by($user)){
			push (@menu_items, {page =>  $self->register->memno->userid->profile, context => 'Owner', icon => 'person'})};
		foreach my $entry ($self->register->entries) {
			push (@menu_items,{ page => $entry->menus->first, context => 'Event Entry', icon => 'entry'})
		}
	}
	if (($self->type eq 'localgroup') || $self->local_group) {
		push (@menu_items, {page =>  $self->local_group->organiser->userid->profile, context => 'Organiser', icon => 'incumbent'}) if ($self->local_group->organiser->userid
		&& $self->local_group->organiser->userid->profile
		 && $self->local_group->organiser->userid->profile->viewable_by($user));
		my @meetings = $self->local_group->group_meetings;
		foreach my $meeting (@meetings) {
			push (@menu_items, {page =>  $meeting->location->menus->first, context => 'meeting', icon => 'location'});
		}
		my @members =  $self->local_group->members;
		foreach my $group_member (@members){
			if ($group_member->profile && $group_member->profile->viewable_by($user)) {
				push (@menu_items, {page =>  $group_member->userid->profile, context => 'member', icon => 'person'}) #if ($user->userid->profile->viewable_by($user))
			}
		}
	}
	if ($self->type eq 'club_role') {
		my @members =  $self->club_role->members;
		foreach my $user (@members){
			if ($user->userid) {
				push (@menu_items, {page =>  $user->userid->profile, context => 'incumbent', icon => 'incumbent'}) #if ($user->userid->profile->viewable_by($user))
			}
		}
	}
	if ($self->type eq 'entry') {
	if ($self->entry->car){
		push (@menu_items, {page => $self->entry->car->menus->first, context => 'car', icon => 'car'}) }
	foreach my $user ($self->entry->entrants) {
			push (@menu_items, {page =>  $user->user->profile, context => 'team member', icon => 'person'}) if ($user->user)#if ($user->userid->profile->viewable_by($user))
		}
	}
	if ($self->type eq 'location') {
	foreach my $meeting ($self->location->group_meetings) {
			push (@menu_items, {page =>  $meeting->local_group->menus->first, context => 'Local Group Meeting', icon => 'people'}) #if ($user->userid->profile->viewable_by($user))
		}
	foreach my $event ($self->location->events->search({},{order_by => {-desc , 'start'}})) {
			push (@menu_items, {page =>  $event->menus->first, context => 'event', icon => 'event'}) #if ($user->userid->profile->viewable_by($user))
		}

	}
	
	if ($self->type eq 'event' && $self->event) {
		if ($self->event->organiser && $self->event->organiser->userid) {push (@menu_items, {page => $self->event->organiser->userid->profile, context => 'Organiser', icon => 'incumbent'})}
		my $location = $self->event->locations->first;
		if ($location) {
			if ($self->event->location_count > 1) {
				foreach my $location ($self->event->locations) {
					push (@menu_items, {page => $location->menus->first, context => 'location', icon => 'location'}) #if ($user->userid->profile->viewable_by($user))
				}
			}
			else {
				push (@menu_items, {page => $location->menus->first, context => 'location', icon => 'location'}) #if ($user->userid->profile->viewable_by($user))
			}
				
		}
	}
	
	if ($self->type eq 'eventroot') {
	my $now = DateTime->now;
	foreach my $event ($self->result_source->schema->resultset('Event')->search({end => {'>=' => $now}},{order_by => 'start'})
			->related_resultset('menus')->viewable($user)) {
			push (@menu_items, {page =>  $event, context => 'event', icon => 'event'}) #if ($user->userid->profile->viewable_by($user))
		}

	}
	elsif ($self->menus->viewable($user)->count({}) < $rows)
	{
		foreach my $child ($self->menus->viewable($user)->search({},{rows => $rows})) {
			last if (@menu_items >= $rows);
			push (@menu_items, {page => $child, context => '', icon => $child->icon_by_type}) 
		}
	}
	return \@menu_items
}

sub access_options {
	my ($self, $user, $mask, $parent) = @_;
	my $access_level = $user->access_level;
	my $level32;
#	my $localgroup = $self->ancestors->search({type => 'localgroup'},{order_by => {-desc => 'pid'}})->first;
#	if ($localgroup) {$level32 = $localgroup->title.' Members'}
	my $event = $self->ancestors->search({type => 'event'},{order_by => {-desc => 'pid'}})->first;
	if ($event) {$level32 = $event->title.' Entrants'}
	else {$mask &= 479}
	my $level8;
	if ($self->manager) {$level8 = 'Manager- '.$self->manager->description}
	else {$mask &= 504}
	my $ownername;
	if ($self->user) {$ownername = $self->user->fullname}
	else {$mask &= 510}
	my @access_options = (
#		{value => '0', label => 'None'},
		{value => '1', label => 'owner- '.$ownername},
		{value => '2', label => 'Administrators'},
		{value => '4', label => 'Moderators'},
		{value => '8', label => $level8},
#		{value => '16', label => 'Competitions Officer'},
		{value => '16', label => 'Club Officers'},
		{value => '32', label => $level32},
		{value => '64', label => 'Club Members'},
		{value => '128', label => 'Registered Users'},
		{value => '256', label => 'All'}
		);
	my @avail_options;
	foreach my $option (@access_options) {
		if (($$option{value} & $access_level)  && ($$option{value} & $mask)) {
		push (@avail_options, $option) }
		}
	return \@avail_options
}

sub top_or_random {
	my ($self, $user) =@_;
#	if ($self->top_pic && $self->top_pic->viewable_by($user)) {return $self->top_pic}
	my $count = $self->viewable_image_count($user);
	return unless $count;
	my $imageno = int(rand($count));
#	return $self->images($user,1,$imageno)->single;
	return $self->items->items_bytype_viewable_by($user,3)->search({},{rows => 1,page => $imageno,group_by => 'sortby'})->single;
	
}

sub remove {
	my $self = $_[0];
	$self->delete_related('car');
	$self->delete_related('championship');
	$self->delete_related('club_role');
	$self->delete_related('entry');
	$self->delete_related('event');
	$self->delete_related('histories');
	$self->delete_related('local_group');
	$self->delete_related('location');
	$self->delete_related('register');
	$self->delete;
}

sub strippedtext {
	my $self = $_[0];
	use HTML::Strip;
	my $hs = HTML::Strip->new();
	return $hs->parse($self->content);
}

sub searchtext {
	my $self = $_[0];
	my $text;
	if ($self->type eq 'entry') {
		foreach my $entrant ($self->entry->entrants) {
			$text = $text.$entrant->name.' ';
		}
		if ($self->entry->car) {$text .= $self->entry->car->known_as}
		$text .= "\n";
	}
	$text.= $self->strippedtext;
}


sub spider {
	my $self = shift;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my ($author,$author_id);
	if ($self->user) {$author = $self->user->username; $author_id = $self->user->id }
	my $result = $c->model('Search')->index(
        index => 'clubtriumph',
        id => 'M'.$self->id,
        type => 'clubtriumph',
        body => {
            title       => $self->title,
            display_title => $self->title,
            view => $self->view,
            author => $author,
            user_id => $author_id,
            content        => $self->searchtext,
            cttype => $self->type,
            tags => [$self->pid]
 #           created => $self->created,
 #           modified => $self->modified
        },
    );
	return $result;
}

sub icon_by_type {
	my $self = $_[0];
#	return $self->type;
	my %type = (
		'mark' => 'car',
		'model' => 'car',
		'triumph' => 'car',
		'car' => 'car',
		'register' => 'car',
		'club_role' => 'role',
		'carsroot' => 'cars',
		'eventroot' =>'event',
		'event' => 'event',
		'memberroot' => 'people',
		'localgroup' => 'people',
		'clubtorque_root' => 'magazine'
	) ;
	if ($type{$self->type}) {return $type{$self->type}} 
	else {return 'document'} 
}

sub item_type_viewable_by {
	my ($self,$type,$user) = @_;
	use Switch;
	switch ($type) {
		case 'HTML' {return $self->blogs_viewable_by($user)}
		case 'Image' {return $self->images_viewable_by($user)}
		case 'Thread' {return $self->messages_viewable_by($user)}
		case 'Message' {return $self->messages_viewable_by($user)}
		case 'PM' {return $self->user && ($self->user->id == $user->id)}
		else {return 0}
	}
	

}

sub all_cars {
	my ($self, $user, $rows, $page) = @_;
	my $me = $self->result_source->resultset->current_source_alias;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->descendants->viewable($user)->search({"$me.type" => 'register'})
		->search_related('register',{},{rows => $rows, page=> $page, order_by => 'regdate'})
}


sub all_cars_count  {
	my ($self, $user) = @_;
	my $me = $self->result_source->resultset->current_source_alias;
	return $self->descendants->viewable($user)->search({"$me.type"=> 'register'})->search_related('register',{})->count({})
}

sub club_cars {
	my ($self, $user, $rows, $page) = @_;
	my $me = $self->result_source->resultset->current_source_alias;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->descendants->viewable($user)->search({"$me.type" => 'register'})->search_related('register',{})->club_cars->search({},{rows => $rows, page=> $page, order_by => 'regdate'})
}

sub club_cars_count {
	my ($self, $user, $rows, $page) = @_;
	my $me = $self->result_source->resultset->current_source_alias;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self->descendants->viewable($user)->search({"$me.type" => 'register'})->search_related('register',{})->club_cars->count({})
}

sub count_all {
	my $menu = shift;
	my @types = $menu->items->search({},{group_by => 'contenttype'});
	foreach my $type (@types) {
		my $level = 1;
		while ($level < 1024) {
			$menu->count_items($type->contenttype->id,$level);
			if ($type->contenttype->id == 5) {
				$menu->count_items(6,$level);
			}
			$level = $level * 2;
		}
	}
}

sub count_items { # creates a cache of item counts
	my ($self,$type,$level) = @_;
	my $count;
	my $lcount;
	my $latest;
	my $loclatest;
	if ($type == 6) {
		$count = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => $level,
			type => 5,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
		},
		{group_by =>'sortby'})->get_column('replies')->sum;
		$lcount = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => {'&' => $level},
			type => 5,
			path => $self->path,
		},
		{group_by =>'sortby'})->get_column('replies')->sum;;
		$latest = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => {'&' => $level},
			type => 5,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
		},{order_by => {-desc => 'sortby'},group_by => 'sortby', rows => 1})->related_resultset('item')->first;
		$loclatest = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => {'&' => $level},
			type => 5,
			path => $self->path,
		},{order_by => {-desc => 'sortby'},group_by => 'sortby', rows => 1})->related_resultset('item')->first;
	}
	else {
		$count = $self->result_source->schema->resultset('BlogMenu')->count({
			item_view => {'&' => $level},
			type => $type,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
		},
		{group_by =>'sortby'});
		$lcount = $self->result_source->schema->resultset('BlogMenu')->count({
			item_view => {'&' => $level},
			type => $type,
			path => $self->path,
		},
		{group_by =>'sortby'});
		$latest = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => {'&' => $level},
			type => $type,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
		},{order_by => {-desc => 'sortby'},group_by => 'sortby', rows => 1})->related_resultset('item')->first;
		$loclatest = $self->result_source->schema->resultset('BlogMenu')->search({
			item_view => {'&' => $level},
			type => $type,
			path => $self->path,
		},{order_by => {-desc => 'sortby'},group_by => 'sortby', rows => 1})->related_resultset('item')->first;

#		$count = $self->items->count({contenttype => $type, view => $level},{group_by => 'id'});
#		$lcount = $self->search_related('blog_menus',{ancs => undef})->search_related('item')->count({'contenttype' => $type, view => $level},{group_by => 'id'});
#		$latest = $self->items->search({contenttype => $type, view => $level},{group_by => 'sortby',order_by =>{-desc => 'sortby'}, rows => 1})->single;
#		$loclatest =$self->search_related('blog_menus',{ancs => undef})->search_related('item')->search({'contenttype' => $type, view => $level},
#			{group_by => 'sortby',order_by =>{-desc => 'sortby'}, rows => 1})->single;
	}
	my $cache = $self->itemcounts->find_or_create({menu_item => $self->pid, contenttype => $type});
#	my $latest = $self->items->search({contenttype => $type, view => $level},{group_by => 'sortby',order_by =>{-desc => 'sortby'}, rows => 1})->single;
#	my $loclatest =$self->search_related('blog_menus',{ancs => undef})->search_related('item')->search({'contenttype' => $type, view => $level},
#		{group_by => 'sortby',order_by =>{-desc => 'sortby'}, rows => 1})->single;
	$cache->update({'c'.$level => $count});
	$cache->update({'l'.$level => $lcount});
	unless ($count) {$cache->update({'lat'.$level => undef})}
	unless ($lcount) {$cache->update({'loc'.$level => undef})}
	if ($latest) {$cache->update({'lat'.$level => $latest->id})}
	if ($loclatest) {$cache->update({'loc'.$level => $loclatest->id})}
}

sub add_to_count {
	my ($self, $item, $local) = @_;
	my $type = $item->contenttype->id;
	my $level = $item->view;
	return unless ($level > 0 );
	my $cache = $self->itemcounts->find_or_create({menu_item => $self->pid, contenttype => $type});
    my $count = $cache->get_column('c'.$level) + 1;
	$cache->update({'c'.$level => $count});
	if ($cache->get_column('lat'.$level)) {
		my $latest = $self->result_source->schema->resultset('Item')->find({id => $cache->get_column('lat'.$level)});
			if (!($latest) || ($item->sortby > $latest->sortby)) {$cache->update({'lat'.$level => $item->id})
		}
	}
	else {$cache->update({'lat'.$level => $item->id})
	}
	if ($local) {
		my $lcount = $cache->get_column('l'.$level) + 1;
		$cache->update({'l'.$level => $lcount});
		if ($cache->get_column('loc'.$level)) {
			my $latest = $self->result_source->schema->resultset('Item')->find({id => $cache->get_column('loc'.$level)});
			if (!($latest) || ($item->sortby > $latest->sortby)) {$cache->update({'loc'.$level => $item->id})
			}
		}
		else {
			$cache->update({'loc'.$level => $item->id})
		}
	}
	
}

sub content_image { # extracts an image from content
	my ($self,$user,$size) = @_;
	unless ($size) {$size = 'w-150'}
	if ($self->club_torque) {return '/static/clubtorque/'.$self->club_torque->edition.'.jpg'}
=cut
	if ($self->type eq 'shop') {
		my $shop_items = $self->items->items_bytype_viewable_by($user,8);
		my $count = $shop_items->count({});
		my $imageno = int(rand($count));
		my $pic = $shop_items->search({},{rows => 1,page =>$imageno})->single;
		return '/image/w-150/image'.$pic->id.'.jpg';
	}
=cut
	use HTML::TokeParser;
	my $content = $self->content;
	my $p = HTML::TokeParser->new(\$content);
	my @pics;
	while (my $token = $p->get_tag("img")) {
		push (@pics, $token->[1]{src});
	}
	my $count = scalar(@pics); 
	if ($count) {
		my $val = int(rand($count));
		my $url = $pics[$val];
		return $url
	}
#	else {
#		my $pic = $self->top_or_random($user);
#		if ($pic) {
#			return ('/image/w-150/image'.$pic->id.'.jpg')
#		return ('/menu/'.$self->pid.'/random_image/'.$size)
#		}
#	}
	return 0;
}

sub avatar {
	my ($self,$c,$size ) = @_;
	my $image_url;
	if ($self->top_pic && $self->top_pic->viewable_by($c->user)) {
#		$image_url = $c->uri_for('/image',$size,'image'.$self->top_pic->id.'.jpg');
#		return $image_url;
		return $self->top_pic->display_uri($c,$size);
	}
	if ($self->content_image && $self->viewable_by($c->user)) {	
		$image_url = $self->content_image($c, $size);
		if ($image_url) {
			return $image_url
		}
	}
	my $random_image = $self->random_item($c->user,3);
	if ($random_image) {
		return $c->uri_for('/image',$size,'image'.$random_image->id.'.'.$random_image->extension);
		return $random_image->display_uri($c,$size);
	}
}


sub random_item { #returns a random item of type specified
	my ($self, $user, $type) = @_;
	if ($self->type eq 'user_profile') {
		my $count = $self->user->items->items_bytype_viewable_by($user,$type)->count({});
		my $val = int(rand($count));
		return $self->user->items->items_bytype_viewable_by($user,$type)->search({},{rows =>1, page=>$val})->single;
	}
	else {
		my $count = $self->viewable_item_count($user,$type);
		my $val = int(rand($count));
#		return $self->items->items_bytype_viewable_by($user,$type)->search({},{rows =>1, page=>$val})->single;
		return $self->items_bytype_viewable_by($user,$type,1,$val)->single;
	}
}

sub calendar_entries {
	my ($self,$user) =@_;
	my $me = $self->result_source->resultset->current_source_alias;
	return $self->descendants->viewable($user)->count({-or => ["$me.type" => 'event', "$me.type" => 'localgroup']});
}

sub calendar_entries_future {
	my ($self,$user) =@_;
	my $me = $self->result_source->resultset->current_source_alias;
	my $now = DateTime->now;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	my $events = $self->descendants->viewable($user)->related_resultset('event')->count({end => {'>=' => $dtf->format_datetime($now)}});
	return $events ;
}

sub calendar_entries_past {
	my ($self,$user) =@_;
	my $me = $self->result_source->resultset->current_source_alias;
	my $now = DateTime->now;
	my $dtf = $self->result_source->schema->storage->datetime_parser;
	return $self->descendants->viewable($user)->related_resultset('event')->count({end => {'<' => $dtf->format_datetime($now)}});
}

sub calendar_entries_recurring {
	my ($self,$user) =@_;
	my $me = $self->result_source->resultset->current_source_alias;
	my $meetings = $self->descendants->viewable($user)->related_resultset('local_group')->related_resultset('group_meetings')->count({});
	return  $meetings;
}

sub baseurl {
	my $self = $_[0];
	return ['/menu',$self->pid]
}

sub default_permissions {

#		{value => '0', label => 'None'},
#		{value => '1', label => 'Owner'},
#		{value => '2', label => 'Administrator'},
#		{value => '4', label => 'Moderator'},
#		{value => '8', label => 'Manager'},
#		{value => '16', label => 'Club Officer'},
#		{value => '32', label => 'Entrant/Member'},
#		{value => '64', label => 'Club Member'},
#		{value => '128', label => 'Guest User'},
#		{value => '256', label => 'All'}

	my $self = shift;
	
	my $owner_context = 3;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	if ($c->user->memno && $self->parent && $c->user->memno->manager_of($self->parent)) {

		$owner_context = 10;
	}

	
	my $properties = ({
		view => 256,
		edit => $owner_context,
		anchor => $owner_context,
		deletable =>2,
		add_blog => 64,
		view_blogs => 256,
		add_image => 128,
		view_images => 256,
		add_message => 128,
		view_messages => 256,
		add_shop => 0,
		add_news => 8,
		add_championship =>0,
	});
	
		if ($self->type eq 'user_profile') {
		
	$properties = ({
			view => 128,
			edit => 1,
			anchor => 1,
			add_blog => 1,
			view_blogs => 128,
			add_image => 1,
			view_images => 128,
			add_message => 1,
			view_messages => 1,
			add_shop => 0,
			add_news => 0,
			add_championship =>0,
		});
	}
	
	if ($self->type eq 'register') {
		
	$properties = ({
			view => 128,
			edit => 9,
			anchor => 1,
			add_blog => 1,
			deletable => 1,
			view_blogs => 128,
			add_image => 1,
			view_images => 128,
			add_message => 1,
			view_messages => 128,
			add_shop => 0,
			add_news => 0,
			add_championship =>0,
		});
	}
	
	if ($self->type eq 'event') {
		
	$properties = ({
			view => 256,
			edit => $owner_context,
			anchor => $owner_context,
			add_blog => $owner_context,
			deletable => $owner_context,
			view_blogs => 256,
			add_image => 128,
			view_images => 256,
			add_message => 128,
			view_messages => 256,
			add_shop => 0,
			add_news => $owner_context,
			add_championship =>0,
		});
	}
	
		if ($self->type eq 'entry') {
		
	$properties = ({
			view => 256,
			edit => 1,
			anchor => 1,
			add_blog => 1,
			deletable => 2,
			view_blogs => 256,
			add_image => 128,
			view_images => 256,
			add_message => 128,
			view_messages => 256,
			add_shop => 0,
			add_news => 0,
			add_championship =>0,
		});
	}

	if ($self->parent && $self->parent->manager) {$$properties{manager} = $self->parent->manager}
	if ($self->parent && $self->parent->linked_role) {$$properties{manager} = $self->parent->linked_role}
#	if ($c->user->memno && $c->user->memno->manager_of($self)) {
#		$$properties{deletable} = 8;
#	}
#	else {
#		$$properties{deletable} = 1
#	}


	
	if ($self->type eq 'localgroup') {
		$$properties{edit} = 8;
		$$properties{manager} = 23;
	}


	$self->update($properties)
}

sub summary {
	my $self = shift;
	return unless $self->content;
	return substr($self->strippedtext,0,110).'....';
}

sub items_bytype_viewable_by { #this is the new version!
	my ($self, $user, $type, $rows, $page, $sticky, $unread) = @_; 
	my $access_level=256;
	my $me = $self->result_source->resultset->current_source_alias;
	my $sort = {'-desc' => "$me.sortby"};
	if ($sticky) {$sort = {-desc => ["me.sticky","$me.sortby"]}}
	if ($user) {
		$access_level = $self->access_level($user) || 128;
	}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, contenttype => $type },
			{rows => $rows,page => $page,group_by => 'sortby', order_by => $sort});
	}
	my @links;
	if ($unread && $user) {
		my $sortby =  0;
		if ($self->result_source->schema->resultset('Bookmark')->find({user => $user->id})) {
			$sortby = $self->result_source->schema->resultset('Bookmark')->find({user => $user->id})->latest
		}
		my $userid = $user->id;
		@links = $self->result_source->schema->resultset('BlogMenu')->search({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			"$me.type" => $type,
			-and => [-or => ["$me.path" => $self->path, "$me.path" => {'like' => $self->path.'/%'}],
			-not_exists => \"(select 1 from item_read where item_read.user = $userid and item_read.item = me.item and (item_read.last_read >= me.replies or item_read.last_read is null))"],
			"$me.sortby" => {'>' => $sortby}
		},
		{rows => $rows, page => $page, order_by => $sort, group_by => "$me.sortby"})->get_column('item')->all;
	}
	else 	{
		@links = $self->result_source->schema->resultset('BlogMenu')->search({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => $type,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}],
		},
		{rows => $rows, page => $page, order_by => $sort, group_by => "$me.sortby",join => {'item' => 'items_read'}})->get_column('item')->all;
	}
	return $self->result_source->schema->resultset('Item')->search({ id => {-in => \@links}},{order_by => $sort});
}

sub items_bytype_viewable_local { #this is the new version!
	my ($self, $user, $type, $rows, $page, $sticky) = @_;
	my $access_level=256;
	my $sort = {'-desc' => 'sortby'};
	if ($sticky) {$sort = {-desc => ['sticky','sortby']}}
	if ($user) {
		$access_level = $self->access_level($user) || 128;
	}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, contenttype => $type },
			{rows => $rows,page => $page,group_by => 'sortby', order_by => $sort});
	}
	my @links = $self->result_source->schema->resultset('BlogMenu')->search({
		menu_view => {'&' => $access_level},
		item_view => {'&' => $access_level},
		type => $type,
		path => $self->path
	},
	{rows => $rows, page => $page, order_by => $sort, group_by => 'sortby'})->get_column('item')->all;
=cut 
	if ($self->view & 32) {
		if ($self->ancestors->related_resultset('event')->related_resultset('entries')->count({user => $user->id})) {
			push (@links, $self->result_source->schema->resultset('BlogMenu')->search({
				menu_view => {'&' =>  32},
				item_view => {'&' =>  32},
				type => $type,
				path => $self->path
			},
		}
		
	}
=cut
	return $self->result_source->schema->resultset('Item')->search({ id => {-in => \@links}},{order_by => $sort})
}

sub items_bytype_viewable_count { #this is the new version!
	my ($self, $user, $type, $unread) = @_;
	my $access_level=256;
	if ($user) {
		$access_level = $self->access_level($user) || 128;
	}
	if ($type == 6) {
		return $self->result_source->schema->resultset('BlogMenu')->search({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => 5,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
			},
			{group_by => 'sortby'}
		)->get_column('replies')->sum
	}
	if ( $unread && $user) {
		my $sortby =  0;
		if ($self->result_source->schema->resultset('Bookmark')->find({user => $user->id})) {
			$sortby = $self->result_source->schema->resultset('Bookmark')->find({user => $user->id})->latest
		}
			my $userid = $user->id;
			return $self->result_source->schema->resultset('BlogMenu')->count({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => $type,
			-and => [-or => [path => $self->path, path => {'like' => $self->path.'/%'}],
			-not_exists => \"(select 1 from item_read where item_read.user = $userid and item_read.item = me.item and (item_read.last_read >= me.replies or item_read.last_read is null))"],
			sortby => {'>' => $sortby}},
			{group_by => 'sortby'}
		)
	}
	else {
		return $self->result_source->schema->resultset('BlogMenu')->count({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => $type,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
			},
			{group_by => 'sortby'}
		);
}
}

sub items_bytype_viewable_position { #this is the new version!
	my ($self, $user, $type, $item) = @_;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	if ($type == 6) {
		return $self->result_source->schema->resultset('BlogMenu')->search({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => 5,
			-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
			},
			{group_by => 'sortby'}
		)->get_column('replies')->sum
	}
	return $self->result_source->schema->resultset('BlogMenu')->count({
		menu_view => {'&' => $access_level},
		item_view => {'&' => $access_level},
		type => $type,
		-or => [path => $self->path, path => {'like' => $self->path.'/%'}],
		sortby => {'>' => $item->sortby}
		},
		{group_by => 'sortby'}
	) +1;
}

sub items_bytype_local_count { #this is the new version!
	my ($self, $user, $type) = @_;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	if ($type == 6) {
		return $self->result_source->schema->resultset('BlogMenu')->search({
			menu_view => {'&' => $access_level},
			item_view => {'&' => $access_level},
			type => 5,
			path => $self->path
		})->get_column('replies')->sum
	}
	return $self->result_source->schema->resultset('BlogMenu')->count({
		menu_view => {'&' => $access_level},
		item_view => {'&' => $access_level},
		type => $type,
		path => $self->path
	});
}

sub items_locatable_bytype_viewable_by { #this is the new version!
	my ($self, $user, $type) = @_;
	my $access_level=256;
	my $sort = {'-desc' => 'sortby'};
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	if ($self->type eq 'user_profile') {
		return $self->result_source->schema->resultset('Item')->items_viewable_by($user)->search({author => $self->user->id, contenttype => $type,
			latitude => {'!=' => undef},
			longitude => {'!=' => undef}, },
			{group_by => 'sortby'});
	}
	my @links = $self->result_source->schema->resultset('BlogMenu')->search({
		menu_view => {'&' => $access_level},
		item_view => {'&' => $access_level},
		type => $type,
		-or => [path => $self->path, path => {'like' => $self->path.'/%'}]
	},
	{ group_by => 'sortby'})->get_column('item')->all;
	return $self->result_source->schema->resultset('Item')->search({ id => {-in => \@links},
		latitude => {'!=' => undef},
		longitude => {'!=' => undef}},{order_by => $sort});
}

sub forum_category_count {
	my ($self, $user) = @_;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	my $count = $self->current_children_rs($user)->count({view_messages => {'&'  =>$access_level}, type => {-not_in => ['user_profile', 'profile_root']}});
	foreach my $child ($self->viewable_children_rs($user)->all) {
		$count += $child->current_children_rs($user)->count({view_messages => {'&'  =>$access_level}, type => {-not_in => ['user_profile', 'profile_root']}});
	}
	$count += $self->current_future_event_count;
	if ($self->view_messages > $access_level) {$count ++}
	return $count;
}

sub user_level { #return user acccess level taking account of manager and member/entrant rights 2016/09/01
	my ($self,$user) =@_;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
		if ($self->manager && $user->club_member && $self->manager->members->count({memno => $user->memno->memno}) && $access_level > 8) {
			$access_level = 8;
		}
		if ($self->local_group && $user->club_member && $self->local_group->members->count({memno => $user->memno->memno}) && $access_level > 32) {
			$access_level = 32; 
		}
	}
	return $access_level
}

sub user_level_desc { # returns description of user role by level
	my ($self, $level) =@_;
	my $event = $self->ancestors->search({type => 'event'},{order_by => {-desc => 'pid'}})->first;
	use Switch;
	switch ($level) {
		case [1] {return 'author (draft)'}
		case [2] {return 'admin'}
		case [4] {return 'moderator'}
		case [8] {
			if ($self->manager) {return $self->manager->description}
			else {return 'manager'}
		}
		case [16] {return 'club officer'}
		case [32] {
			if ($event) {return $event->title.' Entrants'}
			else {
			 return 'entrants'}
		 }
		case [64] {return 'club member'}
		case [128] {return 'guest website user'}
		case [256] {return 'all'}
	}
}

sub menu_object { # return menu as object which can be cached
	my ($self, $user, $level) = @_;
	my @children;
	my $max_items=24;
	$level --;
	if ($level >= 0 && $self->type eq 'groupsroot' && $user && $user->memno && $user->memno->location) {
		my $location = $user->memno->location;
		my @groups = $self->viewable_children($user);
		my @sorted_groups = sort {$a->local_group->distance($location)->value <=> $b->local_group->distance($location)->value} @groups;
		my @groupsinorder;
		foreach my $child (@sorted_groups) {
			push (@children, $child->menu_object($user, $level));
			push (@groupsinorder, $child->pid);
		}
		my $c = ClubTriumph->ctx or die "Not in a request!";
		$c->session(groupsinorder => [@groupsinorder]); # this is for forum order
	}
	elsif ($level >= 0 && $self->type ne 'profileroot') {
		foreach my $child ($self->current_children_rs($user)->search({},{rows => $max_items})) {
			push (@children, $child->menu_object($user, $level))
		}
	}
	my $object = {
		title => $self->title,
		pid => $self->pid,
		children => \@children
	};
	return $object;
}

sub entrylist { # just a helper method to return entry list
	my $self = shift;
	return $self->menus->find({type => 'entrylist'})
}

sub imagebank {  #create image list for MCE editor from attachments
	my ($self, $c) = @_;
	my @images;
	foreach my $pic  ($self->items_bytype_viewable_by($c->user,3,20,1)) {
		push (@images, {uri => $pic->download_uri($c), title => $pic->title})
	}
	return \@images;

		
}

sub model {
	my ($self, $c) = @_;
	my $child = $self;
	while ($child->menus->count({})) {
		$child = $self->menus->first;
		if ($child->car && $child->car->triumph && $child->car->triumph->model) {
			return 	$child->car->triumph->model;
		}
	}
	return $self->result_source->schema->resultset('Model')->find({model => $self->heading1})
}

sub mark {
	my ($self, $c) = @_;
	my $child = $self;
	while ($child->menus->count({})) {
		$child = $self->menus->first;
		if ($child->car && $child->car->triumph) {
			return 	$child->car->triumph;
		}
	}
	if ($self->parent->model) {
		my $modelname = $self->parent->model->model;
		my $markname = $self->heading1;
		$markname =~ s/^$modelname//;
		my $mark = $self->result_source->schema->resultset('Mark')->find({mark => $markname});
		return $self->result_source->schema->resultset('Triumph')->find({model => $self->parent->model, mark => $mark})
	}
}

sub menu_attachments {
	my ($self,$user) =@_;
	return $self->items_bytype_viewable_local($user,4)->search({attachment => undef});
}

sub notified {
	my ($self,$user) = @_;
	return unless $user;
	return $self->ancestors->related_resultset('notifications')->search({'notifications.user' => $user->id})->first;
}


sub access_level {
	my ($self,$user) = @_;
	unless ($user) {return 256}
	my $c = ClubTriumph->ctx;
	if ($c->session->{menu_access_level}{$self->pid}) {return $c->session->{menu_access_level}{$self->pid}}
	my $access_level = $user->access_level;
	if ($self->view & 32 && $user && $self->ancestors->related_resultset('event')->count({}) && $self->ancestors->related_resultset('event')->related_resultset('entries')->count({
		-or => ['entries.user' => $user->id,
				'entrants.user' => $user->id], 
		-or => [status => 'live', status => 'complimentary']},{prefetch => 'entrants'})) {
		$access_level |= 32;
	}
	if ( $user && $self->event && $self->event->entries->count({
		-or => ['entries.user' => $user->id,
				'entrants.user' => $user->id], 
		-or => [status => 'live', status => 'complimentary']},{prefetch => 'entrants'})) {
		$access_level |= 32;
	}
	if ($user->club_member && $self->ancestors->related_resultset('manager')->count({})  
			&& ($self->ancestors->related_resultset('manager')->related_resultset('member_club_roles')->related_resultset('member')->count({memno => $user->memno->memno}))) { # cascade managers
		$access_level |= 8}
	if ($c->session->{menu_access_level}) {$c->session->{menu_access_level}{$self->pid} = $access_level} 
	else {$c->session(menu_access_level => {$self->pid => $access_level})}
	return $access_level
}

sub link_uploaded_images {
	my ($self,$c) =@_;
	my $images = $c->session->{uploaded_images};
	foreach my $image (@$images) {
		if ($c->model('ClubTriumphDB::Item')->find({id => $image})) {
			$c->model('ClubTriumphDB::Item')->find({id => $image})->link_to_menu($self);
		}
	}
	$c->session->{uploaded_images} = undef;
}




after 'insert' => sub {
	my $self = shift;
	unless ($self->menu_order) {
		$self->make_last;
	}
#	my $c = $ClubTriumph::cat;
	$self->spider();
};

around 'update' => sub {
	my $orig = shift;
	my $self = shift;
	my $old = $self->get_from_storage;
	my $path = $old->path;
	my @oldancestors = split(/\//,$self->path);
	$self->$orig(@_);
	if ($self->path ne $path) {
		$self->blog_menus->update({path => $self->path});
#		my @newancestors = split(/\//,$self->path);
#		use List::Compare;
#		my $lc = List::Compare->new(\@newancestors, \@oldancestors);
#		foreach my $changed ($lc->get_symmetric_difference) { 
#			my $changeditem = $self->result_source->resultset->find({pid => $changed});
#			if ($changeditem) {$changeditem->count_all}
#		}
	}
	if ($self->view ne $old->view) {
		$self->blog_menus->update({menu_view => $self->view});
	}
#	my $c = $ClubTriumph::cat;
	$self->spider();
};


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
