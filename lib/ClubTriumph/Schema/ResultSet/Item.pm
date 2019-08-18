package ClubTriumph::Schema::ResultSet::Item;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 

 sub new_item
{
	my ($self, $new, $c) = @_;
	$$new{author}= $c->user->id;
	my $result = $self -> new_result($new);
	return $result;
}

sub new_html
{
	my ($self, $new, $c) = @_;
	$$new{author}= $c->user->id;
	$$new{contenttype} = $c->model('ClubTriumphDB::ContentType')->find({type => 'HTML'});

	my $result = $self -> new_result($new);
	return $result;
}

sub new_thread
{
	my ($self, $new, $c) = @_;
	$$new{author}= $c->user->id;
	$$new{contenttype} = $c->model('ClubTriumphDB::ContentType')->find({type => 'Thread'});

	my $result = $self -> new_result($new);
	return $result;
}

sub new_message
{
	my ($self, $new, $c) = @_;
	$$new{author}= $c->user->id;
	$$new{contenttype} = $c->model('ClubTriumphDB::ContentType')->find({type => 'Message'});
	$$new{thread} = $c->stash->{object};
	my $result = $self -> new_result($new);
	return $result;
}

sub new_image
{
	my ($self, $new, $c) = @_;
	$$new{author}= $c->user->id;
	$$new{contenttype} = $c->model('ClubTriumphDB::ContentType')->find({type => 'Image'});

	my $result = $self -> new_result($new);
	return $result;
}

sub upload_images {
	my ($self, $c) = @_;
	my @files;
	my @image_ids;
	my $view = 511;
	if ($c->stash->{menu_item}) {$view = $c->stash->{menu_item}->view};
	if ($c->stash->{item}) {$view = $c->stash->{item}->view};
	my $n =0;
	while ($c->req->upload('file'.$n)) {
		my $item = $self->create({contenttype => 3, author => $c->user->id, view => $view}); 
		$item->add_image_to_item($c->req->upload('file'.$n));
		$item->title($c->req->upload('file'.$n)->filename);
		$n++;
		push (@files, $item->display_uri($c)->path);
		push (@image_ids, $item->id);
	} 
	$c->log->debug(@image_ids); 
	$c->session(uploaded_images => \@image_ids);
	return @files;
}

=cut
sub html {
    my ($self, $obj) = @_;
    my %content;
    my $id  = $obj ->id;
    $content{id} = $obj ->id;
	$content{contenttype} = $obj->contenttype;
	$content{title} = $obj->title;
	$content{heading1} = $obj->heading1;
	$content{heading2} = $obj->heading2;
#	$content{parent} = $obj->parent;
#	$content{hierachy} = hierachy($self,$obj);
	if (($obj->contenttype->type) eq 'HTML')
	{
		$content{content} = &gethtmlcontent($id);
	}
	if (($obj->contenttype->type) eq 'text')
	{
		$content{content} = &gettextcontent($id);
	}
	if (($obj->contenttype->type) eq 'Image')
	{
		$content{content} = &getimagecontent($obj);
	}
	return %content;
}

#sub content {
#    my ($self,) = @_;
 #   my %content;
 #   my $id  = $self ->id;
 #   $content{id} = $obj ->id;
#	$content{contenttype} = $obj->contenttype;
#	$content{title} = $obj->title;
#	$content{heading1} = $obj->heading1;
#	$content{heading2} = $obj->heading2;
#	$content{parent} = $obj->parent;
#	$content{hierachy} = hierachy($self,$obj);
#	my $content;
#	if (($self->contenttype->type) eq 'HTML')
#	{
#		$content = &gethtmlcontent($id);
#	}
#	if (($self->contenttype->type) eq 'text')
#	{
#		$content = &gettextcontent($id);
#	}
#	if (($self->contenttype->type) eq 'Image')
#	{
#		$content = &getimagecontent($self);
#	}
#	return $content; 
#return "bollocks";
#}


sub thumbnail {
    my ($self, $obj) = @_;
    my %content;
    my $pid  = $obj ->pid;
    $content{pid} = $obj ->pid;
	$content{pagetype} = $obj->pagetype;
	$content{title} = $obj->pagetitle;
	$content{heading1} = $obj->heading1;
	$content{heading2} = $obj->heading2;
	$content{parent} = $obj->parent;
	if ($content{pagetype} eq 'manhtml')
	{
		$content{content} = &gethtmlcontent($pid);
	}
	if ($content{pagetype} eq 'manimage')
	{
		$content{content} = &getimagecontent($obj,1);
	}
	return %content;
}

sub gethtmlcontent
{	
	my $pid = $_[0];
	my $content;
	my $datadir = "/home/Keith/ClubTriumph/root/data";
	my $contentdir = "$datadir/html/";
	open(TEXT, $contentdir.$pid.'.htm');
	read(TEXT,$content,99999);
	close(TEXT);
	return $content;
}

sub savehtmlcontent
{	
	my ($self,$pid,$content) = @_;
	my $datadir = "/home/Keith/ClubTriumph/root/data";
	my $contentdir = "$datadir/html/";
	open(TEXT, '>'.$contentdir.$pid.'.htm')|| print 'unable to open >'.$contentdir.$pid.'.htm';
	print TEXT $content;
	close(TEXT);
	return $content;
}


sub savetextcontent
{	
	my ($self,$pid,$content) = @_;
	my $datadir = "/home/Keith/ClubTriumph/root/data";
	my $contentdir = "$datadir/text/";
	open(TEXT, '>'.$contentdir.$pid.'.txt')|| print 'unable to open >'.$contentdir.$pid.'.htm';
	print TEXT $content;
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


sub saveimagecontent
{	
	my ($self,$pid,$photo) = @_;
	my $image_dir = "/home/Keith/ClubTriumph/root/static/pics/";
	my $image_url = "/static/pics/";
	my $filename = "image".$pid.'jpg'; $filename =~ tr/ /_/;
	
#	$photo->copy_to('/path/to/target');
	
#	my $upload_filehandle = $photo; 
#	open ( UPLOADFILE, ">$image_dir/$filename" ) or print( "$!");
#	binmode UPLOADFILE;
#	while ( <$upload_filehandle> ) 
#		{ print UPLOADFILE; } 
#	close UPLOADFILE; 
	my $imageroot = $image_dir.'image'.$pid.'_*.*';
	system "rm $imageroot";
	open(TEXT, '>'.$image_dir.'image'.$pid.'.jpg')||print  'unable to open >'.$image_dir.'image'.$pid.'.jpg';
	binmode TEXT;
	print TEXT $photo;
	close(TEXT);
	return 1;
}

sub getimagecontent
{
	my ($obj,$thumbnail) = @_;
	my ($url, $filename);
	my $image_dir = "/home/Keith/ClubTriumph/root/static/pics/";
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


sub getimagethumb
	{
	my ($obj) = @_;
	my ($url, $filename);
	my $image_dir = "/home/Keith/ClubTriumph/root/static/pics/";
	my $image_url = "/image/";
	my $dynamic_resize=0;
	my $heading1= $obj ->heading1;
	my $pid= $obj ->pid;
	my $width= $obj ->width;
	my $height= $obj ->height;
	my $alignment= $obj ->alignment;
	my $html;

	my @extensions = ('.jpg','.gif','.png');
	foreach my $extension (@extensions)
		{
		if (-e $image_dir.'image'.$pid.$extension)
			{$url='image'.$pid.$extension; $filename= $image_dir.'image'.$pid.$extension}
		}
	
#	my ($width,$height) = &cminheritsize($pid);
	my $size = 'w-1000/';
	if ($width) {$size = "w-$width"}
	if ($height) {$size = "h-$height"}
	if ($width&&$height) {$size = "w-$width-h-$height"}
	$url =  $size.'/'.$url;
	$html .= "<IMG SRC=\"$image_url$url\" ALT=\"$heading1\"";
		if ($url) 
		{ 
			if ($width) {$html .= " WIDTH=\"$width\""}
			if ($height) {$html .= " HEIGHT=\"$height\""}
		}
	if ($alignment) {$html .= " ALIGN=\"$alignment\""}
	$html .= ">";
	
	
	return $html
}
sub delete_content
{
	
}
=cut
sub blogs {
	my ($self, $rows, $page) = @_;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self ->search({contenttype => '2'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}
sub images {
	my ($self, $rows, $page) = @_;
	return $self->all;
	unless ($rows) {$rows = 10}
	unless ($page) {$page = 1}
	return $self ->search({contenttype => '3'},{rows => $rows,page => $page, order_by => {-desc => 'modified'}});
}
=cut
sub items_viewable_by {
	my ($self, $user) = @_;
	my $me = $self->current_source_alias;
	if ($user) {
	my $access_level = $user->access_level || 128;
	my @levels;
	while ($access_level <1024) {
		push (@levels,$access_level);
		$access_level = $access_level * 2
	}
	return $self->search({-or => ["$me.view" => {'=' => [@levels]},-and => ["$me.view" => 1, "$me.author" => $user->id]]});
	}
	else {
	my @levels = (256,512); 
	return $self->search({"$me.view" => {'=' => [@levels]}});
	}
}
=cut
sub items_viewable_by {
	my ($self, $user) = @_; #return $self;
	my $me = $self->current_source_alias;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	my @terms;
	while ($access_level <1024) {
		push (@terms,'-and' => ["$me.view" => {'&' => $access_level}]);
		$access_level = $access_level * 2
	}
	if ($user) {push (@terms,'-and' => ["$me.view" => {'&' => 1}, "$me.author" => $user->id])}
	return $self->search({-or => \@terms,});
	
}


sub items_bytype_viewable_by {
	my ($self, $user, $type) = @_; #return $self->search({contenttype => $type});
	my $me = $self->current_source_alias;
	my $access_level=256;
	if ($user) {
		$access_level = $user->access_level || 128;
	}
	my @terms;
	while ($access_level <1024) {
		push (@terms,'-and' => ["$me.view" => {'&' => $access_level},"$me.contenttype" => $type]);
		$access_level = $access_level * 2
	}
	if ($user) {push (@terms,'-and' => ["$me.view" => {'&' => 1}, "$me.author" => $user->id,"$me.contenttype" => $type])}
	return $self->search({-or => \@terms,});
	
}

sub items_editable_by {
	my ($self, $user) = @_;
	if ($user) {
	my $access_level = $user->access_level;
	return $self->search({-or => ['me.edit' => {'>=' => $access_level},-and => ['me.edit' => 1, 'me.user' => $user->id]]});
	}
	else {
	my $access_level = 256; 
	return $self->search({'me.edit' => {'>=' => $access_level}});
	}
}

sub next_item {
	my ($self,$item) = @_;
	return unless $item;
	return $self->search({'item.sortby' => {'>' => $item->sortby} },{order_by => {-asc => 'sortby'}})->first;
}

sub prev_item {
	my ($self,$item) = @_;
	return unless $item;
	return $self->search({'item.sortby' => {'<' => $item->sortby} },{order_by => {-desc => 'sortby'}})->single;
}

sub latest {
	my ($self, $user, $rows) = @_;
	my @items = $self->items_viewable_by($user)->search({}, {order_by => {-desc => 'sortby'}, rows => $rows});
	return @items;
	
}

sub latest_forum {
	my ($self, $user, $rows) = @_;
	my @items = $self->items_viewable_by($user)->search({-or => [contenttype => 5, contenttype => 6]}, {order_by => {-desc => 'created'}, rows => $rows});
	return @items;
	
}

sub latest_blogs {
	my ($self, $user, $rows) = @_;
	my @items = $self->items_bytype_viewable_by($user,2)->search({}, {order_by => {-desc => 'sortby'}, rows => $rows});
	return @items;
	
}

sub searchwords {
	my ($self,$c,$searcharray) = @_;

	my @searchwords= @$searcharray;
	my @keywordids;
	my @searchlist;
	my $resultset;
	my @contentcounts;
	foreach my $searchword (@searchwords) {
		my $keyword = $c->model('ClubTriumphDB::Keyword')->find({word => $searchword});
		if ($keyword) {push (@keywordids, $keyword)} else {last}
	}
	if (@keywordids) {
		my $i = 1;
		my @joinarray;
		my @orderarray;
		foreach my $keywordid (@keywordids) {
			my $stuff = '';
			if ($i > 1) {$stuff = "_$i"}
			push(@searchlist,"wordcounts$stuff.word",$keywordid->id); 
			push (@joinarray, 'wordcounts');
			push (@orderarray,"wordcounts$stuff.wcount");
			$i++
		}
		my $orderstring = join('+',@orderarray);
		return $self->items_viewable_by($c->user)-> #result containing any word
				search_rs({'-and',\@searchlist},{join => \@joinarray, order_by => [{'-desc' => $orderstring},{'-desc' => 'views'}]});#, order_by => {'-desc' => $orderstring}
		}
}

sub items_locatable {
	my $self = shift;
	return $self->search({latitude => {'!=' =>undef}});
}

sub within_date {
	my $self = shift;
	my $now = DateTime->now;
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
#	my $zero = DateTime->new(year => 0000,month => 00, day => 00);
	return $self->search({-and => [
			-or => [start_date => undef, start_date => '0000-00-00', start_date => {'<=' => $dtf->format_datetime($now)}],
			-or => [end_date => undef, end_date => '0000-00-00', end_date => {'>=' => $dtf->format_datetime($now)}]
			] } );
}

sub remove_old_ads {
	my $self = shift;
	my $now = DateTime->now;
	my $dtf =  $self->result_source->schema->storage->datetime_parser;
	my $oldads = $self->search({-and => [end_date => {'!=' => undef}, end_date => {'<' => $now}],
			contenttype => {-in => [9,10,11]},
			view => {'>' =>2}});
	$oldads->update({view => 1});
}

sub diaryfeed {
	my ($self,$c) = @_;
	my @entries;
	foreach my $entry ($self->search({content => {'!=' => undef}})) {
		push( @entries, {title => $entry->menu_items->first->entry->teamdesc, 
			content => $entry->content,
			link  => $entry->uri($c)} ) ;$c->log->debug('@@@@@@@@@@@@@@@'.$entry->title);
	}
	return {
    format      => 'RSS 1.0',
    id          => $c->req->base,
    title       => 'Message Diary',
    description => $c->stash->{menu_item}->title,
    link        => $c->req->base,
    modified    => DateTime->now,
    entries => \@entries
	};
}

sub mark_all_read { #mark a resultset item as read
	my ($self, $user) = @_;
	return unless ($user);
	my @readtags;
	foreach my $item ($self->get_column('item')) {
		push (@readtags, {user => $user->id, item => $item->id});
	}
	my $read =  $self->result_source->schema->resultset('ItemRead')->populate(\@readtags);
	return 1;
}

1;
