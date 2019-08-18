use utf8;
package ClubTriumph::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Item

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

=head1 TABLE: C<items>

=cut

__PACKAGE__->table("items");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 contenttype

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 heading1

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 heading2

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 author

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 status

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 blahref

  data_type: 'integer'
  is_nullable: 1

=head2 replyref

  data_type: 'integer'
  is_nullable: 1

=head2 replycount

  data_type: 'integer'
  is_nullable: 1

=head2 start_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 end_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 modified

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 width

  data_type: 'integer'
  is_nullable: 1

=head2 height

  data_type: 'integer'
  is_nullable: 1

=head2 content

  data_type: 'mediumtext'
  is_nullable: 1

=head2 thread

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 attachment

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 views

  data_type: 'integer'
  is_nullable: 1

=head2 view

  data_type: 'integer'
  is_nullable: 1

=head2 edit

  data_type: 'integer'
  is_nullable: 1

=head2 reply

  data_type: 'integer'
  is_nullable: 1

=head2 price

  data_type: 'decimal'
  is_nullable: 1
  size: [6,2]

=head2 pandp

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 price_text

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 spidered

  data_type: 'tinyint'
  is_nullable: 1

=head2 blahboard

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sticky

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sizes

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 blogref

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 sortby

  data_type: 'integer'
  is_nullable: 1

=head2 latitude

  data_type: 'float'
  is_nullable: 1

=head2 longitude

  data_type: 'float'
  is_nullable: 1

=head2 storage

  data_type: 'integer'
  is_nullable: 1

=head2 posts

  data_type: 'integer'
  is_nullable: 1

=head2 extension

  data_type: 'mediumtext'
  is_nullable: 1

=head2 licence

  data_type: 'mediumtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "contenttype",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "heading1",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "heading2",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "author",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "status",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "blahref",
  { data_type => "integer", is_nullable => 1 },
  "replyref",
  { data_type => "integer", is_nullable => 1 },
  "replycount",
  { data_type => "integer", is_nullable => 1 },
  "start_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "end_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "modified",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "width",
  { data_type => "integer", is_nullable => 1 },
  "height",
  { data_type => "integer", is_nullable => 1 },
  "content",
  { data_type => "mediumtext", is_nullable => 1 },
  "thread",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "attachment",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "views",
  { data_type => "integer", is_nullable => 1 },
  "view",
  { data_type => "integer", is_nullable => 1 },
  "edit",
  { data_type => "integer", is_nullable => 1 },
  "reply",
  { data_type => "integer", is_nullable => 1 },
  "price",
  { data_type => "decimal", is_nullable => 1, size => [6, 2] },
  "pandp",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "price_text",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "spidered",
  { data_type => "tinyint", is_nullable => 1 },
  "blahboard",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sticky",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sizes",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "blogref",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "sortby",
  { data_type => "integer", is_nullable => 1 },
  "latitude",
  { data_type => "float", is_nullable => 1 },
  "longitude",
  { data_type => "float", is_nullable => 1 },
  "storage",
  { data_type => "integer", is_nullable => 1 },
  "posts",
  { data_type => "integer", is_nullable => 1 },
  "extension",
  { data_type => "mediumtext", is_nullable => 1 },
  "licence",
  { data_type => "mediumtext", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 attachment

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "attachment",
  "ClubTriumph::Schema::Result::Item",
  { id => "attachment" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 author

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "author",
  "ClubTriumph::Schema::Result::User",
  { id => "author" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 baskets

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Basket>

=cut

__PACKAGE__->has_many(
  "baskets",
  "ClubTriumph::Schema::Result::Basket",
  { "foreign.item" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 blog_menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::BlogMenu>

=cut

__PACKAGE__->has_many(
  "blog_menus",
  "ClubTriumph::Schema::Result::BlogMenu",
  { "foreign.item" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contenttype

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Contenttype>

=cut

__PACKAGE__->belongs_to(
  "contenttype",
  "ClubTriumph::Schema::Result::Contenttype",
  { id => "contenttype" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 items

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items",
  "ClubTriumph::Schema::Result::Item",
  { "foreign.thread" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items_attachments

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->has_many(
  "items_attachments",
  "ClubTriumph::Schema::Result::Item",
  { "foreign.attachment" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 items_read

Type: has_many

Related object: L<ClubTriumph::Schema::Result::ItemRead>

=cut

__PACKAGE__->has_many(
  "items_read",
  "ClubTriumph::Schema::Result::ItemRead",
  { "foreign.item" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 menus

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Menu>

=cut

__PACKAGE__->has_many(
  "menus",
  "ClubTriumph::Schema::Result::Menu",
  { "foreign.top_pic" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 new_cache_latests

Type: has_many

Related object: L<ClubTriumph::Schema::Result::NewCache>

=cut

__PACKAGE__->has_many(
  "new_cache_latests",
  "ClubTriumph::Schema::Result::NewCache",
  { "foreign.latest" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 new_cache_latlocs

Type: has_many

Related object: L<ClubTriumph::Schema::Result::NewCache>

=cut

__PACKAGE__->has_many(
  "new_cache_latlocs",
  "ClubTriumph::Schema::Result::NewCache",
  { "foreign.latloc" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 notifications

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Notification>

=cut

__PACKAGE__->has_many(
  "notifications",
  "ClubTriumph::Schema::Result::Notification",
  { "foreign.item" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pms

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Pm>

=cut

__PACKAGE__->has_many(
  "pms",
  "ClubTriumph::Schema::Result::Pm",
  { "foreign.itempm" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 status

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Contentstatuse>

=cut

__PACKAGE__->belongs_to(
  "status",
  "ClubTriumph::Schema::Result::Contentstatuse",
  { id => "status" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 thread

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "thread",
  "ClubTriumph::Schema::Result::Item",
  { id => "thread" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-05 17:38:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uIPVGj0/b6kP4GZHhBg1mA


#__PACKAGE__->many_to_many(registers => 'blog_registers', 'register');

__PACKAGE__->many_to_many("userpms", "pms", "userpm");

__PACKAGE__->many_to_many(events => 'blog_events', 'event');

__PACKAGE__->many_to_many(groups => 'blog_groups', 'local_group');

__PACKAGE__->many_to_many(menu_items => 'blog_menus', 'menu');

__PACKAGE__->many_to_many("users", "items_read", "user");


__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1, timezone => "UTC"},
	"modified",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1, timezone => "UTC" },
);

sub tags {
	my ($self,$user) = @_;
	if (($self->contenttype->id == 6) && $self->thread) {
		$self=$self->thread
	}
#	my $access_level = 256;
#	if ($user) {$access_level = $user->access_level}
	my @tags =  $self->blog_menus->search({ancs => undef})->related_resultset('menu')->viewable($user)->search({},{group_by => 'pid'});
#	my @tags =  $self->blog_menus->search({menu_view => {'>=' => $access_level}})->related_resultset('menu')->search({},{group_by => 'pid'});
	return @tags;
=cut
	my @tags;
	foreach my $tag ($self->menu_items) {
		if ($tag->viewable_by($user)) {push (@tags,$tag)}
	}
	return @tags
=cut
}

sub html {
    my ($self) = $_[0];
    unless ($self && ($self->contenttype)) {return ''};
    my %content;
    my $id  = $self ->id;
	my $content = $self->content;
	if (($self->contenttype->type) eq 'HTML')
	{
		return $self->content;
	}
	if (($self->contenttype->type) eq 'text')
	{
		return $self->content;
	}
	if (($self->contenttype->type) eq 'Image')
	{
		$content = &getimagecontent($self);
	}
	return $content; 
}

sub image_exists { #returns 1 if image file is present for item. Requires $c as argument
	my ($self,$c) = @_;
	unless ($c) {$c = ClubTriumph->ctx or die "Not in a request!"};
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
#	my @extensions = ('.jpg','.gif','.png');
#	foreach my $extension (@extensions)
#		{
		if (-e $image_dir.'image'.$self->id.'.'.$self->extension)
			{return 1}
#		}
	return 0
}

sub getimagecontent
{
	my ($obj,$thumbnail) = @_;
	my ($url, $filename);
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $image_url = "/image/";
	my $dynamic_resize=0;
	my $heading1= $obj ->heading1;
	my $pid= $obj ->id;
	my $width= $obj ->width;
	my $height= $obj ->height;
#	my $alignment= $obj ->alignment;
	my $html;

	
	my @extensions = ('.jpg','.gif','.png');
	foreach my $extension (@extensions)
		{
		if (-e $image_dir.'image'.$pid.$extension)
			{$url='image'.$pid.$extension; $filename= $image_dir.'image'.$pid.$extension}
		}
	
#	my ($width,$height) = &cminheritsize($pid);
 

	my $size = 'w-1000';
	if ($width) {$size = "w-$width"}
	if ($height) {$size = "h-$height"}
	if ($width&&$height) {$size = "w-$width-h-$height"}
	if ($thumbnail) {$size = "thumbnail"}
	$url =  $size.'/'.$url;

	$html .= "<IMG SRC=\"$image_url$url\" ALT=\"$heading1\"";
		if ($url) 
		{ 
			if ($width&&!$thumbnail) {$html .= " WIDTH=\"$width\""}
			if ($height&&!$thumbnail) {$html .= " HEIGHT=\"$height\""}
		}
#	if ($alignment) {$html .= " ALIGN=\"$alignment\""}
	$html .= ">";
	
	
	return $html
}
sub gethtmlcontent
{	
	my $pid = $_[0];
	my $content;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $datadir = "/home/Keith/ClubTriumph/root/data";
	my $contentdir = "$datadir/html/";
	open(TEXT, $contentdir.$pid.'.htm');
	read(TEXT,$content,99999);
	close(TEXT);
	return $content;
}

sub gettextcontent
{	
	my $pid = $_[0];
	my $content;
	my $datadir = "/home/Keith/ClubTriumph/root/data";
	my $contentdir = "$datadir/text/";
	open(TEXT, $contentdir.$pid.'.txt');
	read(TEXT,$content,99999);
	close(TEXT);
	$content ="<pre>$content</pre>";
	return $content;
}




sub thumbnail {
    my ($self,$size) = @_;
    my %content;
    my $id  = $self ->id;
	my $content;
	unless ($self->contenttype) {return 0};
	if (($self->contenttype->type) eq 'HTML')
	{
		$content = &gethtmlthumb($self);
	}
	if (($self->contenttype->type) eq 'text')
	{
		$content = &gettextcontent($id);
	}
	if (($self->contenttype->type eq 'Image') || ($self->contenttype->type eq 'shop'))
	{
		$content = &getimagethumb($self,$size);
	}
	return $content; 


sub getimagethumb
	{
	my ($obj,$size) = @_;
	my ($url, $filename);
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $image_url = "/image/";
	my $dynamic_resize=0;
	my $heading1= $obj ->heading1;
	my $pid= $obj ->id;
	my $width= $obj ->width;
	my $height= $obj ->height;
#	my $alignment= $obj ->alignment;
	my $html;

	my @extensions = ('.jpg','.gif','.png');
	foreach my $extension (@extensions)
		{
		if (-e $image_dir.'image'.$pid.$extension)
			{$url='image'.$pid.$extension; $filename= $image_dir.'image'.$pid.$extension}
		}
	return unless $url;
#	my ($width,$height) = &cminheritsize($pid);
	unless ($size) {$size = 'thumb'}

	$url =  $size.'/'.$url;
	$html .= "<IMG SRC=\"$image_url$url\" ALT=\"$heading1\"";

#	if ($alignment) {$html .= " ALIGN=\"$alignment\""}
	$html .= ">";
	
	
	return $html
}

sub gethtmlthumb
{	
	my $self = $_[0];
	my $content = $self ->content;
	$content =~ s/<.*?>//g;
	return $content;
}


}



sub update_item
{
	my ($self,$c) = @_;
	my $updates = $c->req->params;
	my %updates = %$updates;
	unless ($$updates{submit}) {return 0}
	my $photo = $c->req->upload('photo');

	my @newblogs;
	my $modified;
	if ($self->in_storage) { $modified = $self->modified} 
	else {$self->insert};
#	$self->tags_from_request($c->req->params);

	my $recipients = $$updates{recipients};

	my @attachments = grep {$_ =~ /^attachments/} keys %$updates; 
	my @attachmentids = grep {$_ =~ /^attachments.*id$/} keys %$updates;;
	foreach my $attachment ($self->items_attachments) { #deal with attachment removals
		unless (grep {$$updates{$_} == $attachment->id} @attachmentids) {$attachment->remove($c)}
	}
	foreach my $attachment (@attachmentids) {
		my $id = $$updates{$attachment};
		$attachment =~ s/id$//;
		my $title = $$updates{$attachment.'title'};
		my $filename = $$updates{$attachment.'filename'};
		my $type = $$updates{$attachment.'type'};
		my $licence = $$updates{$attachment.'licence'};
		my $tempname = $c->path_to('root','static','temp').'/'.$$updates{$attachment.'tempname'};
		if ($c->req->upload($attachment.'file')) { #newly uploaded file overides persistant 
			$filename = $c->req->upload($attachment.'file')->filename;
			$tempname = $c->req->upload($attachment.'file')->tempname;
			$type = $c->req->upload($attachment.'file')->type;
		}
		unless ($title) {$title = $filename}
		my $att = $self->attach_file($c,$filename,$tempname,$type,$title,$id,$licence);
		if ($filename) {
		$$updates{content} = $self->update_embedded_uri($c, $tempname, $$updates{content}, $att);
		}
	}

	$self->update({content => $self->update_images($c,$$updates{content})});

	if ($self->contenttype->id ==7) { # if pm
		$self->add_recipients($recipients)
	}
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';#"/home/Keith/ClubTriumph/root/static/pics/";
	my $image_url = $c->uri_for('/static',$c->config->{'Model::Item'}->{photo_dir}).'/';
	my $id = $self->id;
	my $filename = $image_dir.'image'.$id;
	unless (($self->contenttype->type eq "Image") || ($self->contenttype->type eq "shop")) {system "rm $filename.*"}
	if ((($self->contenttype->type eq "Image") || ($self->contenttype->type eq "shop"))) {
		my $n = 0;
		foreach my $upload ( $c->request->upload('photo')) {
			if ($upload->size) {
				if ($n == 0) {
					$self->add_image_to_item($upload);
					if ($self->title eq '') {$self->update({title => $upload->filename})}
				}
				else {
					my $sibling = $self->result_source->resultset->new_result({
						title => $upload->filename,
						contenttype => $self->contenttype->id,
						content => $self->content,
						view => $self->view,
						author => $self->author,
						licence => $self->licence,
					});
					$sibling->insert;
					$sibling->discard_changes;
					$sibling->add_image_to_item($upload);
					$sibling->tags_from_request(\%updates);
				}
				$n ++;
			}
		}
	}
	if (($self->contenttype->id >= 9) && ($self->contenttype->id <=11)) { # if advert
		my $date = DateTime->today->add(months => 1);
		$self->update({end_date => $date});
	}
	if ($modified) {$self->update({modified => $modified})} #keep date the same after edit
	$self->set_storage;
	$self->set_sortby;
	if ($self->author) {$self->author->count_posts};
}


sub tags_from_request {
	my ($self, $updates) = @_;
	my @newblogs;
	foreach my $param (keys (%$updates))
	{
	if ($param =~ /^menu_(\d*)$/)
		{
		if ($$updates{$param} eq '1' || $$updates{$param} eq 'on') {
			push (@newblogs,$1);
			my $link = $self->result_source->schema->resultset('BlogMenu')->find_or_create({menu => $1,item => $self -> id});
#			$link->set_ancestor_links;
			}
#			delete $$updates{$param}
		}
	}
	my @currentblogs = $self->blog_menus->all;
	foreach my $blog (@currentblogs)
	{
		unless (grep {$_ eq $blog->menu->id} @newblogs) {$blog->delete}
	}
}

sub add_image_to_item {
	my ($self,$photo) = @_;
	if ((($self->contenttype->type eq "Image") || ($self->contenttype->type eq "shop"))&& $photo && $photo->size) {
		my $c = ClubTriumph->ctx or die "Not in a request!";
		my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
		use Imager;
		my $image = Imager->new;
		$image->read(data => $photo->slurp);
		if ($photo->size > 1000000) {
			$image = $image->scale(xpixels => 1000, ypixels => 1000, type=>'min');
		}
		my $oldfn = $photo->filename;
		my $id = $self->id;
		$oldfn =~ /\.(\w*)$/;
		my $extension = $1;
		my $filename = "image".$id.'.'.$extension; 
		$self->update({extension => $extension});
		my $imageroot = $image_dir.'image'.$id.'.*';
		system "rm $imageroot";
		$image->write(file => $image_dir.'image'.$id.'.'.$extension);
		$self->set_storage;
	}
}

sub add_file_to_item {
	my ($self,$file) = @_;
	if (($self->contenttype->id == 4)&& $file && $file->size) {
		my $c = ClubTriumph->ctx or die "Not in a request!";
		my $file_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{upload_dir}).'/';
		my $oldfn = $file->filename;
		my $id = $self->id;
		$oldfn =~ /\.(\w*)$/;
		my $extension = $1;
		my $filename = "file".$id.'.'.$extension; 
		$self->update({extension => $extension});
		my $fileroot = $file_dir.'file'.$id.'.*';
		system "rm $fileroot";
		use File::Copy;
		copy ($file->tempname, $file_dir.'file'.$id.'.'.$extension);
		$self->set_storage;
	}
}

sub resize_picture {
	my $picture = shift;
	if (length($$picture) || 1) {
		use Imager;
		my $image = Imager->new;
		$image->read(data => $$picture);
		$image->scale(xpixels => 1000, ypixels => 1000, type=>'min');
		$image->write(data => $picture);
	}
	return $picture;
}

sub blogtags {
	my ($item,$c) = @_;
	my @field_list;
	my $tagid;
	my @menu_items;
	foreach my $menu_item ($item->tags) {
#	foreach my $menu_item ($item->search_related('blog_menus',{ancs => undef})->search_related('menu',{})) {
		push (@menu_items, $menu_item);
	}
	if ($c->stash->{menu_item}) {
		$tagid = $c->stash->{menu_item}->pid;
		push (@menu_items, $c->user->profile);
		push (@menu_items, $c->stash->{menu_item});
#		push (@menu_items, $c->stash->{menu_item}->context_related($c->user,10))
		foreach my $men_item (@{$c->stash->{menu_item}->context_related($c->user,10)}) {
			push (@menu_items, $$men_item{page})}
	}
	push (@menu_items, $c->user->histories_rs->search_related('menu',{},{order_by => {-desc => 'time'}, rows => 30}));
	if ($c->user) {
		foreach my $user (@{ $c->user->profile->context_related($c->user,10)}) {
		push (@menu_items, $$user{page})}
	}

	my @pids;
	foreach my $menu (@menu_items)
	{
		if ($menu && (
			($item->contenttype->type eq ('Image')) && $menu->images_addable_by($c->user) ||
			($item->contenttype->type eq ('HTML')) && $menu->blogs_addable_by($c->user) ||
			($item->contenttype->type eq ('Thread')) && $menu->messages_addable_by($c->user) ||
			($item->contenttype->type eq ('shop')) && $menu->shop_addable_by($c->user) ||
			($item->contenttype->type eq ('carforsale')) && $menu->advert_addable_by($c->user) ||
			($item->contenttype->type eq ('partsforsale')) && $menu->advert_addable_by($c->user) ||
			($item->contenttype->type eq ('wanted')) && $menu->advert_addable_by($c->user) ||
			($item->contenttype->type eq ('news')) && $menu->news_addable_by($c->user)
			) 
			) {
			my $pid = $menu->pid;
			my $default=(grep {$_->menu->pid eq $menu->pid} $item->search_related('blog_menus',{ancs => undef}));
			if (!$item->tags && ($pid == $tagid)) {$default =1}
#			if ($pid == $c->user->menus->first->pid) {$default =1}
			$pid = 'menu_'.$pid;
#			push (@field_list, {name => $pid, type => 'Boolean', 
#					label => $menu->title, 
#					default => $default, 
#					wrapper_class => 'form-tags',
#					element_attr => {onChange =>'countTags(this)'}});
			unless (grep(/$pid/, @pids)) {
				push (@field_list, {label => $menu->title, value => $menu->pid });
				push (@pids, $pid)
			}
		}
	}
	my @added;
	if ($c->flash->{added_options}) {
		my $options  = $c->flash->{added_options};
		@added = @$options;
	}
	if ($c->req->params->{more_tags}) {
		my $menit = $c->model('ClubTriumphDB::Menu')->find({pid => $c->req->params->{more_tags}});
		if ($menit) {
			push( @added,{label => $menit->title, value => $menit->pid });
			my @menu_items = $c->req->params->{menu_items};
			push (@menu_items, $menit->pid);
			$c->req->params->{menu_items} = \@menu_items;
		}
	};
	$c->log->debug('added_options'.@added);
	$c->flash->{added_options} = \@added;
	foreach my $thing (@added) {
		my $pid = $thing->{pid};
		unless (grep(/$pid/, @pids)) {
			push (@field_list, $thing);
			push (@pids, $pid)
		}
	}
	@field_list = sort {$$b{default} <=> $$a{default}} @field_list;
	return @field_list;
}

sub count_replies {
	my $self = $_[0];
	my $replies = $self->items;
	return $replies;
}

sub thread_modified {
	my $self = $_[0];
=cut
	my $modified = $self->created;
	my @replies = $self->items;
	if ($replies[-1]) {$modified = $replies[-1]->created}
	return $modified;
=cut
	return $self->last_post->created
}

sub last_post {
	my $self = $_[0];
	if ($self->items->count) {return $self->items->search({},{order_by => {-desc => 'created'}, rows => 1})->first}
	else { return $self}
}

sub viewable_by {
	my ($self, $user) =@_;
	if (($self->contenttype->type eq 'PM') && $self->userpms->find($user->id)) {return 1}
	else {return $self->accessible($self->view,$user)}
}

sub replyable_by {
	my ($self, $user) =@_;
	return $self->accessible($self->reply,$user)
}

sub editable_by {
	my ($self, $user) =@_;
	unless ($self && $user) {return 0}
		my $halfhourago = DateTime->now->clone->subtract(minutes => 30);
	if ($self->author && ($user->id == $self->author->id) && ($self->contenttype->id <5 || $self->contenttype->id > 7 ||$self->created > $halfhourago)) {return 1} # message only editable for half an hour
	return $self->accessible($self->edit,$user)
}

sub accessible {
	my ($self,$level,$user) = @_;
	unless ($level) {$level = 0}
	unless ($user) { return ($level & 256)}
	return (($level & $user->access_level)
		|| (($level & 1) && $self->author && ($self->author->id == $user->id))
		|| ($user->club_member && $user->memno->club_roles->search({editor_of => $self->contenttype->id})))
	}

sub replies {
	my ($self,$rows,$page) =@_;
	return $self->items->search({},{rows => $rows, page => $page, order_by => {'-asc' => 'created'}})
}

sub no_replies {
	my ($self) =$_[0];
	return $self->items->count({})
}

sub display_context { 
	my ($self, $menu_item, $user) = @_; 
	if ($self->contenttype->id ==8) { # if shop item redirect to Club Shop page
		my $shoppage = $menu_item->result_source->resultset->find({type => 'shop'});
		return unless $shoppage;
		return $shoppage;
	}
	if ($self->contenttype->id == 7) { return $user->profile}
	unless ($menu_item) {
		my @tags = $self->tags($user);
		my $first = $tags[0];#$self->menu_items->viewable($user)->first;
		if ($first) {return $first}
		else { return $self->result_source->schema->resultset('Menu')->find({pid => 1}) }
	}
	if ($self->thread) {$self = $self->thread}
	if ($self->attachment) {$self = $self->attachment}
	unless ($menu_item->item_type_viewable_by($self->contenttype->type,$user)) {
		return $self->menu_items->viewable($user)->first}
#	if ($self->menu_items_rs->descendants->find($menu_item)) {return $menu_item}
	if ($self->contenttype->id ==8) { # if shop item redirect to Club Shop page
		my $shoppage = $menu_item->result_source->resultset->find({type => 'shop'});
		return unless $shoppage;
		return $shoppage;
	}
	if ($self->contenttype->type eq 'PM') {return $user->profile}
	foreach my $menu ($self->menu_items) {
		if ($menu_item->descendants->find($menu->pid)) {return $menu_item}
	}
	return $self->menu_items->viewable($user)->first
}

sub uri {
	my ($self,$c) = @_;
	my $page = $self->display_context($c->stash->{menu_item},$c->user);
	return unless $page; 
	return $c->uri_for('/menu',$page->pid,'item',$self->id,'view')
}

sub unread {
	my ($self, $user) = @_; #determines if pm has been read by user
	return $self->search_related('pms', {userpm => $user->id})->first->unread
}

sub replied {
	my ($self, $user) = @_; #flags if pm has been replied to by user
	return $self->items->find({'author', $user->id})
}

sub read { # has item been read by user?
	my ($self, $user) = @_; 
	unless ($user) {return 0}
	if ($user->bookmarks->first && $user->bookmarks->first->latest >= $self->sortby) {return 1}
	if (($self->contenttype->id == 5) ) { #if message
		my $read = $self->items_read->find({user => $user->id});
		return 0 unless ($read);
		my $replies = $self->items->count({});
		return $replies <= $read->last_read;
	}
	return 0
}

sub replyno {
	my $self =$_[0];
	return unless ($self->thread && $self->sortby);
	return $self->thread->items->count({sortby => {'<=' => $self->sortby}});
}
sub known_as {
	my $self =$_[0];
	if ($self->title) {return $self->title}
#	if ($self->register) {return $self->register->known_as}
	if ($self->thread) {return 'reply to '.$self->thread->title}
	
	
}

sub strippedtext {
	my ($self,$c) = @_;
	if (($self->contenttype->id == 4) && ($self->extension eq 'pdf')) { #handle pdf attachments
		my $filename = $c->path_to('root','static',$c->config->{'Model::Item'}->{upload_dir}).'/file'.$self->id.'.'.$self->extension;
		my $text = `pdftotext  $filename -`;
		return $text;
	}
	use HTML::Strip;
	my $hs = HTML::Strip->new();
	return $hs->parse($self->content);
}

sub summary {
	my $self = shift;
	return substr($self->strippedtext,0,110).'....';
}

sub spider {
	my $self = shift;
	my $c = ClubTriumph->ctx or die "Not in a request!";
	my $tagged = $self;
	if ($self->thread) {$tagged = $self->thread}
	if ($self->attachment) {$tagged = $self->attachment}
	my @tags = $tagged->blog_menus->related_resultset('menu')->get_column('pid')->all;
	my $tags = join (' ',@tags);
	my ($author,$created,$modified,$author_id);
	if ($self->author) {$author = $self->author->username; $author_id = $self->author->id }
	if ($self->created) {$created = $self->created}
	if ($self->modified) {$modified = $self->modified}
	my $result = $c->model('Search')->index(
        index => 'clubtriumph',
        id => 'I'.$self->id,
        type => 'clubtriumph',
        body => {
            title       => $self->title,
            display_title => $self->known_as,
            view => $self->view,
            user_id => $author_id,
            tags => [@tags],
            author => $author,
            content  => $self->strippedtext($c),
            cttype => $self->contenttype->search_cat,
            created => $self->created->datetime(),
            modified => $self->modified->datetime(),
        },
    );
	return $result;
}

sub remove { #deletes and removes from search engine requires c
	my ($self,$c) = @_;
	if ( $self->items->count({})) { #handle replies to threads
		foreach my $item ($self->items) {
			$item->remove($c)
		}
	}
	if ( $c->model('Search')->exists(
			index => 'clubtriumph',
			id => 'I'.$self->id,
			type => 'clubtriumph')) {
			my $result = $c->model('Search')->delete(
			index => 'clubtriumph',
			id => 'I'.$self->id,
			type => 'clubtriumph');
		}
	if ($self->contenttype->type eq 'image') {
		my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
		my $filename = 'image'.$self->id;
		system "rm $image_dir$filename.*";
		my $cache_dir = $c->path_to('root','cache');
		system "rm -R $cache_dir/*/$filename.*";
	}
	if ($self->contenttype->id eq 4) { #attachment
		my $upload_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{upload_dir}).'/';
		my $filename = 'file'.$self->id;
		system "rm $upload_dir$filename.*";
	}
	foreach my $attachment ($self->items_attachments) {
		$attachment->remove($c)
	}
	foreach my $link ($self->blog_menus) {$link->delete}
	$self->delete;
}


sub update_without_timestamp {
my ($self,$data) = @_;
$self->result_source->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 0 },
	"modified",
    { data_type => 'timestamp', set_on_create => 0, set_on_update => 0 },
	);
$self->update($data);
$self->result_source->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
	"modified",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
	);
}
=cut
sub set_sortby {
	my $self = $_[0];
	return unless ($self && $self->created);
	my $created = $self->created;
	$self->update({modified => $created});
	if (($self->contenttype->id == 6) && $self->thread && $self->thread->contenttype && ($self->thread->contenttype->id == 5 )) {
		$self->thread->update({modified => $created})
	}
}


sub set_sortby {
	my $self = $_[0];
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
	return unless ($self && $self->modified);
	my $created = $self->created;
#	my $contenttype = $self->contenttype->id;
	my $sortby = 0;
	if ($self->sortby) {$sortby = $self->sortby}
	my $previous;
	if ($sortby && $self->result_source->resultset->count({ modified =>  $dtf->format_datetime($created), sortby => {'<' => $sortby}},{rows => 1, order_by => {'-desc' => 'sortby'}})) {
		$previous = $self->result_source->resultset->search({ modified =>  $dtf->format_datetime($created), sortby => {'<' => $sortby}},{rows => 1, order_by => {'-desc' => 'sortby'}})->single
	}
	elsif (!$sortby && $self->result_source->resultset->count({id => {'!=' => $self->id}, modified =>  $dtf->format_datetime($created)})) {
		$previous = $self->result_source->resultset->search({id => {'!=' => $self->id}, modified =>  $dtf->format_datetime($created)},{rows => 1, order_by => {'-desc' => 'sortby'}})->single;
	}
	else {
		$previous = $self->result_source->resultset->search({ modified => {'<' => $dtf->format_datetime($created)}, id => {'!=' => $self->id}},{rows => 1, order_by => {'-desc' => 'sortby'}})->single;
	}
#	unless ($previous) {return; print $self->id.' '.$self->sortby.' '.$self->modified};
	my $next;
	if ($sortby && $self->result_source->resultset->count({ modified =>  $dtf->format_datetime($created)})) {
		$next = $self->result_source->resultset->search({ modified =>  $dtf->format_datetime($created), sortby => {'>' => $sortby}},{rows => 1, order_by => 'sortby'})->single
	}
	else {
		$next = $self->result_source->resultset->search({ modified => {'>' => $dtf->format_datetime($created)}, id => {'!=' => $self->id}},{rows => 1, order_by => 'sortby'})->single;
	} print $self->id."%%%%%%%\n";
#	if ($previous) 
		{$sortby = $previous->sortby +8; }
	if ($next) {
		if (($next->sortby - $previous->sortby)  == 1) {$next ->shuffle}
		$sortby = int(($next->sortby + $previous->sortby)/2);
		my @duplicates = $self->result_source->resultset->search({ sortby => $sortby, id => {'!=' => 'id'}});
		foreach my $duplicate (@duplicates) {
			$duplicate->shuffle
		}
	}
#	print ('previous '.$previous->sortby.' ' .$previous->modified."\n next ".$next->sortby.' '.$next->modified."\n current ".$self->sortby.' '.$self->modified.' new '.$sortby. "\n\n");
	unless ($self->sortby == $sortby) { print "\n CHANGED !!!!!!!!!!!!!!!!\n"};
#	unless ($self->sortby && ($previous->modified <= $self->modified) && ($next->sortby > $self->sortby)) {
		$self->update({sortby => $sortby});
		$self->update({modified => $created});
#	}
	if (($self->contenttype->id == 6) && $self->thread && $self->thread->contenttype && ($self->thread->contenttype->id == 5 )) {
		$self->thread->update({sortby => $sortby});
		$self->thread->update({modified => $created});
	}
}

sub shuffle {
	my $self = $_[0];
	my $sortby = $self->sortby;
	my $modified = $self->modified;
#	return unless ($self && $self->sortby);
	while (my $next = $self->result_source->resultset->search({ sortby => ($sortby +1)},{rows => 1, order_by => 'sortby'})->single)
		{$next->shuffle}
#	my $modified = $self->modified;
	$self->update({sortby => $sortby+1});
	$self->update({modified => $modified});
}

=cut 

sub set_sortby {
return 1; #this has been replaced by trigger in db
	my $self = $_[0];
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
	return unless ($self && $self->modified);
#	if (($self->contenttype->id == 5) && $self->items->count({})) {
#		$self->update({modified => $self->items->get_column('modified')->max})
#	}
	my $modified = $self->modified;
	my $sortby = $self->modified->epoch;
	while ($self->result_source->resultset->count({id => {'!=' => $self->id}, sortby => $sortby})) {
		$sortby ++
	}
	$self->update({sortby =>$sortby});
	$self->update({modified => $modified});
	if (($self->contenttype->id == 6) && $self->thread && $self->thread->contenttype && ($self->thread->contenttype->id == 5) && ($self->sortby > $self->thread->sortby)) {
#		if ($self->sortby > $self->thread-> sortby) {
			$self->thread->update({sortby => $sortby});
			$self->thread->update({modified => $modified});
#		}
	}
	if (($self->contenttype->id == 5) && $self->items->count({}))  {
		my $replymax = $self->items->search({},{order_by => {-desc => 'sortby'}, rows => 1})->single;
		$self->update({sortby => $replymax->sortby});
		my $replycount = $self->items->count({},{order_by => {-desc => 'sortby'}});
		$self->update ({replies => $replycount});
		$self->update({modified => $replymax->modified});
	}
}

sub set_sortby_no_ud {
	return 1;
	my $self = $_[0];
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
#	if (($self->contenttype->id == 5) && $self->items->count({})) {
#		$self->update({modified => $self->items->get_column('modified')->max})
#	}
	my $modified = $self->modified;
	my $sortby = $self->created->epoch;
	while ($self->result_source->resultset->count({id => {'!=' => $self->id}, sortby => $sortby})) {
		$sortby ++
	}
	$self->blog_menus->update({sortby =>$sortby});
	if (($self->contenttype->id == 6) && $self->thread && $self->thread->contenttype && ($self->thread->contenttype->id == 5) && ($self->sortby > $self->thread->sortby)) {
		my $thread = $self->thread;
		my $replymax = $thread->items->search({},{order_by => {-desc => 'sortby'}, rows => 1})->single;
		my $replycount = $thread->items->count({});
		$thread->blog_menus->update({sortby => $replymax->sortby, replies => $replycount});
		$thread->blog_menus->update({modified => $replymax->modified});

	}
#	if (($self->contenttype->id == 5) && $self->items->count({}))  {
#		my $replymax = $self->items->search({},{order_by => {-desc => 'sortby'}, rows => 1})->single;
#		if ($replymax->sortby > $self->sortby) {
#		$self->sortby($replymax->sortby);
#		$self->modified($replymax->modified);
#		}
#	}
}


sub link_to_menu { #attaches item to menu item
	my ($self,$menu,$user) =@_;
	return unless ($menu && $menu->pid);
	my $link;
#	if ($user) {
#		$link = $self->result_source->schema->resultset('BlogMenu')->find_or_create({item => $self->id, menu => $menu->pid, user => $user->id})
#	}
#	else {
#		$link = $self->result_source->schema->resultset('BlogMenu')->find_or_create({item => $self->id, menu => $menu->pid})
#	}
#	$link->set_ancestor_links;
	$link = $self->result_source->schema->resultset('BlogMenu')->find_or_create({
			item => $self->id,
			 menu => $menu->pid,
		 });
	$link->update({
			 type => $self->contenttype->id,
			 user => $self->author,
			 path => $menu->path,
			 menu_view => $menu->view,
			 item_view => $self->view,
			 sortby => $self->sortby,
			 sticky => $self->sticky});
}

sub remove_links {
	my $self = shift;
	foreach my $link ($self->blog_menus) {
		$link->delete
	}
}
			
sub blog_image { # extracts an image from blog content
	my $self =$_[0];
#	return unless ($self->contenttype->type eq 'HTML' );
	use HTML::TokeParser;
	my $content = $self->content;
	my $p = HTML::TokeParser->new(\$content);
	my @pics;
	while (my $token = $p->get_tag("img")) {
		push (@pics, $token->[1]{src});
	}
	my $count = scalar(@pics); 
	my $val = int(rand($count));
	my $url = $pics[$val];
	return $url
}



sub set_storage {
	my $self = shift;
	my $storage = 200 + length($self->content) + length($self->title);
	my $image_dir = "/home/Keith/ClubTriumph/root/static/pics/";
	if (($self->contenttype && ($self->contenttype->id == 3)) && (-e $image_dir.'image'.$self->id.'.jpg')) {
		$storage += (-s $image_dir.'image'.$self->id.'.jpg')
	}
	my $modified = $self->modified;
	$self->update({storage => $storage});
	$self->update({modified => $modified})

}

sub set_storage_no_ud {
	my $self = shift;
	my $storage = 200 + length($self->content) + length($self->title);
	my $image_dir = "/home/Keith/ClubTriumph/root/static/pics/";
	if (($self->contenttype && ($self->contenttype->id == 3)) && (-e $image_dir.'image'.$self->id.'.jpg')) {
		$storage += (-s $image_dir.'image'.$self->id.'.jpg')
	}
	$self->storage($storage);
}

sub report { #creates moderator forum thread for reported item
	my ($self,$c,$user,$reason) = @_;
	my $content = '<p>'.$user->fullname.' ('.$user->username.') has reported the following '.$self->contenttype->displaytype.' to be looked over and reviewed<br>';
	$content .= '<a href = "'.$c->uri_for('/item',$self->id).'">'.$c->uri_for('/item',$self->id).'</a><br>';
	$content .= '<blockquote>'.$self->content.'</blockquote>';
	$content .= 'The user gave the following reason for sending reporting this '.$self->contenttype->displaytype.'<br>';
	$content .= '<blockquote>'.$reason.'</blockquote></p>';
	my $report = $self->result_source->resultset->create({
		title => 'Reporting '.$self->contenttype->displaytype.' '.$self->title,
		contenttype => 5,
		view => 4,
		reply => 4,
		author => $user->id,
		content => $content
	});
	my $moderators_disc = $self->result_source->schema->resultset('Menu')->find({heading1 => 'Moderators Private'});
	$report->link_to_menu($moderators_disc);
	# send the e-mail
	$c->stash->{email} = {
        to      => 'forumadmin@club.triumph.org.uk',
        from    => 'forumadmin@club.triumph.org.uk',
        subject => 'Reporting '.$self->contenttype->displaytype,
		template => 'report.tt2',
    };
	$c->stash(user => $user, item => $self, reason => $reason, report => $report);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}

sub view_uri { # generate the correct url to view an item in context
	my ($item, $c,$context) = @_;
	my $num = '';
	my $params = {};
	if ($c->req->params->{search}) {
		$params = {search => $c->req->params->{search}}
	}
#	unless ($context->{baseurl}[0] eq '/menu' )
#	{$context = $item->display_context(0,$c->user)}
=cut
	if (($item->contenttype->id == 5) && $item->items->count({}) && $c->user) { #redirect to latest reply
		my $lastviewed = $item->items->items_read->find({user => $c->user->id});
		if ($lastviewed) {
			my $firstunviewed = $item->items->search({sortby => {'>' => $lastviewed->item->sortby}},{rows => 1})->single;
			if ($firstunviewed) {$item = $firstunviewed}
			else {$item = $lastviewed->item}
		}
	}
=cut
	if ($item->contenttype->id == 6 && $item->thread) {
		my $replyno = $item->replyno;
		my $pageno =  int(($replyno - 1)/$c->stash->{replies_per_page}) + 1 ;
		$$params{messagepage} = $pageno;
		$num = '#num'.$replyno;
		$item = $item->thread;
		return $c->uri_for('/menu', $context->pid, 'item',$item->id,'view',$params).$num;
	}
	if ($item->contenttype->id == 2) {
		$item->discard_changes;
		my $me = $item->result_source->resultset->current_source_alias;
		my $blogno =  $context->items_bytype_viewable_position($c->user,2,$item);
		my $pageno = int(($blogno - 1)/$c->stash->{blogs_per_page}) + 1 ;
		$$params{blogpage} = $pageno;
		my $num = $blogno - $c->stash->{blogs_per_page}*($pageno-1);
		$num = '#num'.$num;
		return $c->uri_for('/menu', $context->pid, 'blog',$params).$num;
	}
	if ($item->contenttype->id == 8) { # club shop
		$item->discard_changes;
		my $me = $item->result_source->resultset->current_source_alias;
		my $shopno = $context->items->items_bytype_viewable_by($c->user,8)->count({"$me.sortby" => {'>=' => $item->sortby}});
		my $pageno =  int(($shopno - 1)/$c->stash->{shop_per_page}) + 1 ;
		$$params{shoppage} = $pageno;
		$num = '#num'.$shopno;
		return $c->uri_for('/menu', $context->pid, 'shop',$params).$num;
	}
		if ($item->contenttype->id >=9 && $item->contenttype->id <=11) { # market
		return $c->uri_for('/menu', $context->pid, 'market');
	}
	if ($item->contenttype->id == 12) { # news
		return $c->uri_for('/menu', $context->pid, 'view');
	}
	if ($item->contenttype->id == 14) { # diary
		my $diaryno = $context->items->items_bytype_viewable_by($c->user,14)->count({sortby => {'>=' => $item->sortby}});
		my $pageno =  int(($diaryno - 1)/$c->stash->{diary_per_page}) + 1 ;
		$$params{diarypage} = $pageno;
		$num = '#num'.$item->id;
		return $c->uri_for('/menu', $context->pid, 'view',$params).$num;
	}
	return $c->uri_for('/menu', $context->pid, 'item',$item->id,'view',$params).$num;
}

sub mark_read { #mark item as read
	my ($self, $user) = @_;
	return unless ($user);
	my $thread = $self;
	my $read =  $self->result_source->schema->resultset('ItemRead')->find_or_create({user => $user->id,item => $self->id});
	if ($self->contenttype->id == 6 && $self->thread) {   #if reply
		$thread = $self->thread;
		my $thread_read = $self->result_source->schema->resultset('ItemRead')->find_or_create({user => $user->id,item => $thread->id});
		my $replyno = $self->replyno;
		unless ($thread_read->last_read && ($thread_read->last_read > $replyno)) {
			$thread_read->update({last_read => $replyno})
		}
	}
#	foreach my $bm ($thread->blog_menus) {
#		$self->result_source->schema->resultset('BmRead')->find_or_create({user => $user->id, bm => $bm->id});
#	}
	return 1;
}

sub last_read { #returns the last reply read by user
	my ($self, $user) = @_;
	unless ($user) {return $self};
	unless ($self->items) { return $self}
	my $last =  $self->items->search_related('items_read',{user => $user->id})->search_related('item',{},{order_by => {-desc, 'sortby'}, rows => 1})->single;
	return $last || $self
}

sub first_unread { #returns the first reply unread by user
	my ($self, $user) = @_;
	unless ($user) {return $self};
	unless ($self->items) { return $self}
	my $last_read = $self->last_read($user);
	my $next = $self->items->search({sortby => {'>' => $last_read->sortby}},{order_by => {-desc => 'sortby'}, rows =>1})->single;
	if ($next) {return $next} 
	elsif ($last_read ) {return $last_read}
	else {return $self}
}

sub inc_views {
	my $self = shift;
	my $modified = $self->modified;
	$self->update({views => $self->views + 1});
	$self->update({modified => $modified});
}

sub attachments_addable_by {
	my ($self,$user) = @_;
	return unless $user;
	return (($self->contenttype->id == 5) || ($self->contenttype->id == 6) || ($self->contenttype->id == 2) ||
	 ($self->contenttype->id == 9) || ($self->contenttype->id == 10) || ($self->contenttype->id == 11) || ($self->contenttype->id == 12))
}



sub attach_file {
	my ($self,$c,$filename,$tempfile,$type,$title,$item,$licence,$leaveon) = @_;
	my $upload_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{upload_dir}).'/';
	my $image_dir = $c->path_to('root','static',$c->config->{'Model::Item'}->{photo_dir}).'/';
#	my $file = $c->req->upload($attachment);
#	$c->log->debug('*****basename = '.$file->basename.' raw '.$file->raw_basename.'temp '.$file->tempname);
#	$attachment =~ s/file$/id/;
#	my $oldfn = $filename;

#;	$c->log->debug('$$$$$$$$$$'. $id.'ffff'.$file->filename.'tttt'.$file->type);
	my $contenttype=4;
	if ($type =~ /^image\//) {$contenttype = 3}
	my $attachitem;
	if ($item) {$attachitem = $self->items_attachments->find({id => $item})}
	unless ($attachitem) {
		return unless (-e $tempfile && -f $tempfile) ;
		$attachitem = $self->result_source->resultset->create({
				attachment => $self->id,
				contenttype =>$contenttype,
			});
		} 
	$attachitem->update({
		view => $self->view,
		edit => $self->edit,
		author => $self->author,
		title => $title,
		licence => $licence
		});
	

	if (-e $tempfile && -f $tempfile)
	{
		my $newfilename;
		$tempfile =~ /.*\.(.*$)/;
		my $extension = $1;
		if ($contenttype == 4) {$newfilename = "file".$attachitem->id; }
		else {$newfilename = "image".$attachitem->id; }
		my $filepath = $upload_dir.$newfilename;
		system "rm $upload_dir.$newfilename.*";
		system "rm $image_dir.$newfilename.*";
		use File::Copy;
		if ($contenttype == 4) {
			copy ($tempfile, $upload_dir.$newfilename.'.'.$extension)||print  'unable to open >'.$upload_dir.$newfilename.$extension;}
		else {
			copy($tempfile, $image_dir.$newfilename.'.'.$extension)||print  'unable to open >'.$upload_dir.$newfilename.$extension;}
		$attachitem->update({
			extension => $extension
			});
		unless ($leaveon) {`rm $tempfile`};
	} else {$c->log->debug("can't find $tempfile")}
	$attachitem->spider($c);
	return $attachitem;
}


sub download_uri {
	my ($self,$c) = @_;
	if ($self->contenttype->id == 4) {
		my $upload_url = $c->uri_for('/static',$c->config->{'Model::Item'}->{upload_dir}).'/';
		return $upload_url.'file'.$self->id.'.'.$self->extension
	}
	if ($self->contenttype->id == 3) {
		my $image_url = $c->uri_for('/static',$c->config->{'Model::Item'}->{photo_dir}).'/';
		return $image_url.'image'.$self->id.'.'.$self->extension
	}
}

sub display_uri {
	my ($self,$c,$size) = @_;
	unless ($size) {$size = 'w-500'}
	if ($self->contenttype->id == 3) {
		my $extension = 'jpg';
		if ($self->extension) {$extension = $self->extension}
		return $c->uri_for('/image',$size,'image'.$self->id.'.'.$extension);
	}
	else {
		return $self->download_uri($c);
	}
}

sub new_uploads { #returns attachments that are associated with an upload request.
	my ($self,$c) = @_;
	my $updates = $c->req->params;
	my @attachments;
	my @attachmentids = grep {$_ =~ /^attachments.*id$/} keys %$updates;
	foreach my $attachment (@attachmentids) {
		my $id = $$updates{$attachment};
		$attachment =~ s/id$//;
		my $title;
		my $filename;
		my $type;
		my $tempname ;
		my $uri;
		my $contenttype = 4;
		if ($self->items_attachments->find({id => $id})) {
			my $attach = $self->items_attachments->find({id => $id});
			$title = $attach->title;
			$contenttype = $attach->contenttype->id;
			$uri = $attach->download_uri($c);
		}
		$title = $$updates{$attachment.'title'} if $$updates{$attachment.'title'};
		$filename = $$updates{$attachment.'filename'};
		$type = $$updates{$attachment.'type'};
		$tempname = $c->path_to('root','static','temp').'/'.$$updates{$attachment.'tempname'} if $$updates{$attachment.'tempname'};
		$uri = $c->uri_for('/static','temp').'/'.$$updates{$attachment.'tempname'} if $$updates{$attachment.'tempname'};
		if ($c->req->upload($attachment.'file')) { #newly uploaded file overides persistant 
			$filename = $c->req->upload($attachment.'file')->filename;
			$tempname = $c->req->upload($attachment.'file')->tempname;
			$tempname =~ s/\/tmp//;
			$uri = $c->uri_for('/static','temp').'/'.$tempname;
			$tempname = $c->path_to('root','static','temp').$tempname; #convert to persistant filename
			$type = $c->req->upload($attachment.'file')->type;
		}
		if ($type =~ /^image/) {$contenttype = 3}
		if ($type =~ /^video/) {$contenttype = 13}
		unless ($title) {$title = $filename}
		push(@attachments,{filename => $filename, tempname => $tempname,type => $type, uri => $uri, contenttype => $contenttype, title => $title, id => $id});
	}
	return @attachments;
}

sub imagebank {  #create image list for MCE editor from attachments
	my ($self, $c) = @_;
	my @images;
	if ($c->req->method eq 'POST') {
		my @attachments = $self->new_uploads($c);
		foreach my $attachment (@attachments) {
			if ($$attachment{contenttype} == 3) {push (@images,{uri => $$attachment{uri}, title => $$attachment{title}})}
		}
		return @images;
	}
	else {
		foreach my $pic  ($self->items_attachments->search({contenttype => 3})) {
			push (@images, {uri => $pic->display_uri($c), title => $pic->title})
		}
		return \@images;
	}
		
}

sub update_embedded_uri { # updates the content replacing a temporary image with the permenant one
	my ($self, $c, $temp, $content, $item) = @_;
	return $content unless ($item && $temp);
	$temp =~ s/^.*\///;
	$c->log->debug('$$$$$$$$$$$$$$$$$$@'.$temp.'  '.$content);
	my $newuri = $item->display_uri($c);
	$content =~ s/(<img.*src.*").*$temp(".*>)/$1$newuri$2/g;
	return $content;
}
	
sub unembedded_attachments { #returns attachments that aren't in the content
	my ($self, $c) = @_;
	my @attachments;
	my $content = $self->content;
	my $imageroot = $c->uri_for('/image');
	foreach my $attachment ($self->items_attachments) {
		my $download_uri = $attachment->download_uri($c);
		next if ($content =~ /<.*"$download_uri".*>/g);
		if ($attachment->contenttype->id == 3) {
			my $filename = 'image'.$attachment->id.'.'.$attachment->extension;
			next if ($content =~ /<img.*src.*".*$filename".*/g);
		}
	push (@attachments,$attachment);
	}
	return \@attachments
}
	
sub update_images { # updates image urls to resize them correctly
	my ($self, $c, $content) = @_;
	my $newcontent;
	while ($content =~ /(.*?)(<img.*?>|$)/igs) {
	$newcontent .= $1;
	my $tag = $2;
	my ($src, $alt, $width, $height, $style);
	if ($tag =~ /img/) {
	
		if ($tag =~ /src="(.*?)"/i) {
			$src = $1;
		}
		if ($tag =~ /width="(.*?)"/i) {
			$width = $1;
		}
		if ($tag =~ /height="(.*?)"/i) {
			$height = $1;
		}
		if ($tag =~ /alt="(.*?)"/i) {
			$alt = $1;
		}
		if ($tag =~ /style="(.*?)"/i) {
			$style = $1;
		}
		my $image_url = '/image/';
		if ($width || $height) {
			$src =~ s/($image_url)w-500(.*?)/$1h-$height-w-$width$2/;
		}
		if ($src =~ /^data:(.*?);(.*?),(.*)$/s ) {
			my $type = $1;
			my $encoding = $2;
			my $data = $3;
			if ($c->user->club_member) {
				if ($encoding eq 'base64') {
					use MIME::Base64;
					my $binary = decode_base64($data); 
					if ($type =~ /image\/(.*?)$/) {
						my $extension = $1;
						my $tempname = $c->path_to('root','static','temp').'/'.'embedded'.$self->id.'.'.$extension;
						open(TEMPFILE, ">$tempname");
						print TEMPFILE $binary;
						close TEMPFILE;
						my $att = $self->attach_file($c,$tempname,$tempname,$type,'image',,$self->licence);
						$src = $c->uri_for('/image','w-500','image'.$att->id.'.'.$extension);
						}
					}
				}
			else {
				$src = '';
				}
			}
		my $newtag = "<img src=\"$src\" alt=\"$alt\" width=\"$width\" height=\"$height\" style=\"$style\">";
		$newcontent .= $newtag;
		}
	}
	return substr($newcontent,0,100000);
}


sub item_to_link {
	my ($self, $c) = @_;
#	my $me = $self->result_source->resultset->current_source_alias;
#	if ($c && $c->stash->{menu_item} 
#			&& $c->stash->{menu_item}->pid ==1
#			&& $self->menu_items->viewable($c->user)->count({pid => {'!=' => 1}}) == 1) {
#		return $self->menu_items->search({pid => {'!=' => 1}})->single
#	}
	my $link;
	my $count = 0;
	foreach my $menu_item ($self->menu_items->viewable($c->user)) {
		if (scalar $menu_item->ancestors > $count) {
			$count = scalar $menu_item->ancestors;
			$link = $menu_item;
		}
	}
	return $link if ($link && $link-> pid != $c->stash->{menu_item}->pid)
#	if ($self->menu_items && ( $self->menu_items->count({"menu.type" => 'event'}) == 1)) {
#		return $self->menu_items->search({"menu.type" => 'event'})->single
#	}
}

sub headline_date {
	my $self = $_[0];
	my $me = $self->result_source->resultset->current_source_alias;
	if ($self->menu_items && ( $self->menu_items->count({"menu.type" => 'event'}) == 1)) {
		return $self->menu_items->search({"menu.type" => 'event'})->single->event->start
	}
}

sub add_recipients { # add recipients to a pm
	my ($self, $recipients) = @_;
	my @tolist = split(/\n/,$recipients);
	foreach my $to (@tolist) {
		$to =~ s/[\000-\037]//g;
		my $recipient = $self->result_source->schema->resultset('User')->find({username => $to});
		if ($recipient) {
			$self->result_source->schema->resultset('Pm')->find_or_create({userpm => $recipient, itempm =>$self->id, unread => 1, folder => 'inbox'},{ key => 'user_item_folder' });
			if ($recipient->profile) {
				$self->link_to_menu($recipient->profile)
			}
		}
	}
	$self->result_source->schema->resultset('Pm')->find_or_create({userpm => $self->author->id, itempm =>$self->id, unread => 0, folder => 'sent'},{ key => 'user_item_folder' })
}


sub pm_info { #helper method to get relevant pm info
	my ($self,$user) = @_;
	return $self->pms->search({userpm => $user->id})->first;
}
	
sub update_sms { #for handling incomind SMSs
	my ($self, $c) = @_;
#	$self->update(content => $c->req->params->{message});
}

=cut
sub licence_expanded {
	my ($self, $c) = @_;
	use Switch;
	switch ($self->licence) {
		case 'CC BY' {return "<a href = 'https://creativecommons.org/licenses/by/4.0/'>Attribution</a>"}
		case 'CC BY-SA' {return "<a href = 'https://creativecommons.org/licenses/by-sa/4.0/'>Attribution ShareAlike</a>"}
		case 'CC BY-ND' {return "<a href = 'https://creativecommons.org/licenses/by-nd/4.0/'>Attribution-NoDerivs</a>"}
		case 'CC BY-NC' {return "<a href = 'https://creativecommons.org/licenses/by-nc/4.0/'>/Attribution-NonCommercial</a>"}
		case 'CC BY-NC-SA' {return "<a href = 'https://creativecommons.org/licenses/by-nc-sa/4.0/'>Attribution-NonCommercial-ShareAlike</a>"}
		case 'CC BY-NC-ND' {return "<a href = 'https://creativecommons.org/licenses/by-nc-nd/4.0/'>Attribution-NonCommercial-NoDerivs</a>"}
		case 'reserved' {return 'All Rights Reserved'}
		case 'public' {return 'Public Domain'}
		case 'other' {return 'Other'}
	}
}
=cut

sub notified {
	my ($self,$user) = @_;
	return $self->notifications->search({'user' => $user->id})->first;
}


sub link_uploaded_images {
	my ($self,$c) =@_;
	my $images = $c->session->{uploaded_images};
	foreach my $image (@$images) {
		if ($c->model('ClubTriumphDB::Item')->find({id => $image})) {
			$c->model('ClubTriumphDB::Item')->find({id => $image})->update({attachment => $self->id});
		}
	}
	$c->session->{uploaded_images} = undef;
}

#after 'insert' => sub { #refresh cache for message replies
#	my $self = shift;
#	if ($self->contenttype == 6 && $self->thread) {
#		$self->thread->update({modified => $self->modified});
#	}
#	unless ($self->sortby) {
#		$self->set_sortby;
#	}
#	$self->set_storage;
#	return unless ($self->contenttype->id == 6  && $self->thread);
#	foreach my $menu_item ($self->thread->menu_items) {
#		while ($menu_item) {
#			$menu_item->count_items(6,$self->view);
#			$menu_item->count_items(5,$self->view);
#			$menu_item = $menu_item->parent;
#		}
#	}
#;

#after 'update' => sub { #refresh cache for message replies
#	my $self = shift;
#	if ($self->contenttype->id == 6 && $self->thread) {
#		$self->thread->update({modified => $self->modified});
#	}
#};

after 'insert' => sub {
#	my $orig = shift;
	my $self = shift;
#	$self->set_sortby_no_ud;
#	$self->set_storage_no_ud;
#	$self->$orig(@_);

	my $thread = $self->thread;
	if ($thread) {
		$self->thread->update({replycount => $self->thread->items->count({})});
		$thread->discard_changes;
		$thread->blog_menus->update_all({replies => $thread->replycount, sortby => $thread->sortby});
		foreach my $blog_menu (	$thread->blog_menus) {
			$blog_menu->bms_read->delete;
			}
		};
	$self->spider;
};

around 'update' => sub {
	my $orig = shift;
	my $self = shift;
	my $view = $self->view;
	my $type = $self->contenttype->id;
	my $sticky =$self->sticky;
	my $sortby = $self->sortby;
	my $replies = $self->replycount;
	my $modified = $self->modified;
	my $old = $self->get_from_storage;
	my $views = $old->views;
	my $modified = $old->modified;

#	$self->set_sortby_no_ud;
#	$self->set_storage_no_ud;

#	$self->set_storage_no_ud;
#	unless ($self->sortby) {$self->set_sortby};
#	$self->set_storage;
#	$self->discard_changes;
	if ($self->is_column_changed('sortby') || $self->is_column_changed('view') || $self->is_column_changed('contenttype') || $self->is_column_changed('sticky') || $self->is_column_changed('replies')) {
#	if (!$self->sortby || ($self->sortby != $sortby) || ($self->view != $view) || ($type != $self->contenttype->id) || ($self->sticky != $sticky) || ($self->replycount != $replies)) {
		$self->blog_menus->update_all({sortby => $self->sortby, item_view => $self->view, type => $self->contenttype->id, sticky => $self->sticky}, replies => $self->replycount);
	}
	$self->$orig(@_);
	unless (($self->views == $views + 1) || ($self->modified <= $modified)) { # we're just incrementing the count
		$self->spider;
	}
};

around 'delete' => sub { #refresh count cache.
	my $orig = shift;
	my $self = shift;
#	my @menu_items = $self->menu_items;
#	my $type = $self->contenttype->id;
#	my $level = $self->view;
	my $author = $self->author;
	my $thread = $self->thread;
	$self->blog_menus->delete;
	$self->$orig(@_);
#	if ($self->thread) {$thread->set_sortby};
	if ($thread) {
		$thread->update({replycount => $self->thread->items->count({})});
		$thread->discard_changes;
		$thread->blog_menus->update({replies => $thread->replycount, sortby => $thread->sortby});
		};
#	if (($type == 6) && $self->thread) {
#		@menu_items = $thread->menu_items;
#			foreach my $menu_item (@menu_items) {
#				$menu_item->count_items($type,$level)
#			}
#	}
	if ($author) {$author->count_posts};
};

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
