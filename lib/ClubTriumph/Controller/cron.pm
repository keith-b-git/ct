package ClubTriumph::Controller::cron;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::cron - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub dostuff : Private {
	my ($self,$c) = @_;
	my $file = '/home/Keith/temp/time.txt';
	open (FILE,">$file");
	print FILE time;
	close FILE;
 $c->log->debug('*** DOING STUFF ***');
	
}

sub message_diary : Local {
	my ($self,$c) = @_;
	use MIME::Base64;
	use MIME::QuotedPrint;
	my $mount = $self->mount_triumph($c);
	my %rbrreg;
	my %entrylu;
	my (%phone,%messtime,%message,%attachs);
	my @uids1;
	my @uids;
	my @principletels;
	my %rbrdrivers;
	my %rbrcar;
	my %rbryear;
	my %rbrcc;
	my %rbrcolour;
	my (%rbrprev, %rbrtel, %rbrtown,);
	my $rbrtel;
	
#	my $messages="/mount/cgi-bin/rbrr/messages2010.txt";
#	my $teamlist="/mount/cgi-bin/rbrr/entrants2010.csv";
#	my $event = $c->model('ClubTriumphDB::Event')->find({title => '22nd Round Britain Reliability Run'});

#	my $messages="/mount/cgi-bin/rbrr/messages2012.txt";
#	my $teamlist="/mount/cgi-bin/rbrr/entrants2012.csv";
#	my $event = $c->model('ClubTriumphDB::Event')->find({title => '23rd Round Britain Reliability Run'});

#	my $messages="/mount/cgi-bin/rbrr/messages2014.txt";
#	my $teamlist="/mount/cgi-bin/rbrr/entrants2014.csv";
#	my $event = $c->model('ClubTriumphDB::Event')->find({title => '24th Round Britain Reliability Run'});

#	my $messages="/mount/cgi-bin/rbrr/messages.txt";
#	my $teamlist="/mount/cgi-bin/rbrr/entrants2016.csv";
#	my $event = $c->model('ClubTriumphDB::Event')->find({title => '25th RBRR'});
	
	my $messages=$mount."/cgi-bin/10cr/messages.txt";
	my $teamlist=$mount."/cgi-bin/10cr/entrants2017.csv";
	my $event = $c->model('ClubTriumphDB::Event')->find({title => '2017 10CR'});
	
#	my $messages="/mount/cgi-bin/rbrr/messages.txt";
#	my $teamlist="/home/Keith/ClubTriumph/data/temp/entrants2016.csv";
#	my $event = $c->model('ClubTriumphDB::Event')->find({title => 'test event1'});
	
	open (TEAMLIST,$teamlist) || die 'cant open teamlist';
	my @teamdata=<TEAMLIST>;
	close TEAMLIST;
	foreach my $teamline (@teamdata)
		{
		chomp $teamline;
		my @items=split(/,/,$teamline);
		my $i=0;
		my @strings = undef;
		while ($i<@items)
			{
			my $string=$items[$i];
	
			if ($string =~s/^"//)
				{
				until (($string =~s/"$//)||($i>=@items))
					{
					$i++;
					$string="$string,$items[$i]";
					}
				}
	
			push (@strings,$string);
			$i++;
			}
	#	($xx,$entryno,$rbrdrivers,$rbrcar,$rbryear,$rbrcc,$rbrcolour,$rbrprev,$rbrreg,$rbrtel,$rbrtown)=@strings;
	#	($xx,$entryno,$rcrew[0],$rtel[0],$rcrew[1],$rtel[1],$rcrew[2],$rtel[2],$rcrew[3],$rtel[3],$rbryear,$rbrcar,$rbrexact,$rbrreg,$rbrtown,$rbreng)=@strings;

		#$rbrcar = $rbrcar.' '.$rbrexact;
	
	
	#	($xx,$xxx,$entryno,$rcrew[0],$rcrew[1],$rcrew[2],$rcrew[3],$rbrcar,$rbryear,$rbrcolour,$rbrcc,$xstatus)=@strings;
	my ($xx,$pxx,$rbrmemno,$status,$entryno,@rcrew,$rbrcar,$rbryear,$rbrcolour,$rbreng,$rbrreg,$rbrtown,$rbrprev,$rbremail,@rtel,$ok,@rsurname,$rmemno,$address1,$address2,$city,$county,$postcode,$country,$rphone,@rfirstname);
#	($xx,$status,$entryno,$rcrew[0],$rcrew[1],$rcrew[2],$rcrew[3],$rbrcar,$rbryear,$rbrcolour,$rbreng,$rbrreg,$rbrtown,$rbrprev,$rbremail,$rtel[0],$rtel[1],$rtel[2],$rtel[3])=@strings; #25th rbrr
	($xx,$entryno,$xx,$pxx,$rcrew[0],$rcrew[1],$rcrew[2],$rcrew[3],$rbremail,$rbryear,$rbrcar,$rtel[0],$rtel[1],$rtel[2],$rbrmemno,$rbrreg,)=@strings; #2017

#	($xx,$status,$entryno,$ok,$rfirstname[0],$rsurname[0],$rmemno,$rbremail,$address1,$address2,$city,$county,$postcode,$country,$rphone,$rtel[0],$rfirstname[1],$rsurname[1],$rbrcar,$rbrreg,$rbryear)=@strings; #10Cr
#$rcrew[0] = $rfirstname[0].' '.$rsurname[0];
#$rcrew[1] = $rfirstname[1].' '.$rsurname[1];


	unless ($status) {$status = 'R'}
	if ($status eq 'Starter') {$status = 'R'}
	#		$rbrtel =~ s/ //g;
	if (($entryno =~ /\d/)&&($status =~ /R/))
			{
			foreach my $tel (@rtel)
				{
				$tel =~ s/\s//g;
				$tel =~ s/^\(/00/g;
				$tel =~ s/\)//g;
				$tel =~ s/\(//g;
				$tel =~ s/^7/07/;
				$tel =~ s/^\+44/0/;
				$tel =~ s/^0044/0/;
				$tel =~ s/^\+/00/;
				$tel =~ s/^none$//;
				$entrylu{$tel}=$entryno;
				}
			$rbrtel = join(' ',@rtel);
			push(@principletels,$rtel[0]);
			$rbremail =~s/ //g;
			$rbremail = lc($rbremail);
			$entrylu{$rbremail}=$entryno;
			my $rbrdrivers="";
			foreach my $crew (@rcrew)
				{
				unless (($crew =~/none/)||($crew eq" "))
				{$rbrdrivers="$rbrdrivers/$crew"}
				}
			$rbrdrivers =~ s/^\///;
			$rbrcolour =ucfirst($rbrcolour);
	
			($rbrdrivers{$entryno},$rbrcar{$entryno},$rbryear{$entryno},$rbrcc{$entryno},$rbrcolour{$entryno},$rbrprev{$entryno},$rbrreg{$entryno},$rbrtel{$entryno},$rbrtown{$entryno})=
		($rbrdrivers,$rbrcar,$rbryear,$rbreng,$rbrcolour,$rbrprev,$rbrreg,$rbrtel,$rbrtown);
			$entrylu{$rbrtel}=$entryno;
			$rbrreg{$entryno} =~s/\W//g;
			}
		}

		open (MESSAGES,$messages) || die 'cant open messages';
		my @messagedata=<MESSAGES>;
		close MESSAGES;
		foreach my $messageline (@messagedata)
			{
			chomp $messageline;
			my ($uid,$phone,$messtime,$message,$attachs)=split(/\|/,$messageline);
			$phone =~ s/ //g;
			$message=~ s/\^/\n/g;
			$message= decode_qp($message);
			
		#normal registration
			
			if ($message =~ /^\s*register\s*(\w*)/i)
				{
				my $reg=uc($1);
				$reg=~s/\W//g;
				foreach my $team (keys %rbrreg)
					{
					if ($reg eq $rbrreg{$team})
						{
						$entrylu{$phone}=$team;
						}
		
					}
				
				}
		
		#
		
#

#official registration
	
	elsif ($message =~ /^\s*offreg\s*(\w*)/i)
		{

		}

#
#official broadcast
	
	elsif ($message =~ /^\s*offbc\s*(.*)/i)
		{

		}

#
#
#general broadcast
	
	elsif ($message =~ /^\s*broadcast\s*(.*)/i)
		{

		}

#
		
		
			else
				{
			      $message=~ s/\n/\n<BR>/g;
				  $message=~ s/\WEOM\W.*$//s; 
				($phone{$uid},$messtime{$uid},$message{$uid},$attachs{$uid})=($phone,$messtime,$message,$attachs);
				push (@uids1,$uid);
				
				}
		
			}
		@uids = @uids1; #sort {&comparedates($messtime{$b},$messtime{$a})} 

	my $response;
	foreach my $item (@uids) {
		my ($date,$stime) = split (/ /,$messtime{$item});
		my ($year,$mon,$day) = split (/\//,$date);
		my ($hour,$min,$sec) = split (/:/,$stime);
		my $time = DateTime->new(
			year => $year,
			month => $mon,
			day => $day,
			hour => $hour,
			minute => $min,
			second => $sec,
			time_zone => 'Europe/London'
		);
		
		$response .= "<p>".$entrylu{$phone{$item}}."<br>".$message{$item}."<br>".$messtime{$item}."<br>".$time."<br>";
		if (! ($c->model('ClubTriumphDB::Item')->find({
				blogref => $item,
				contenttype => 14,
			}) )
			&& $event->entries->find({entry_no => $entrylu{$phone{$item}}})) {
			my $entry = $event->entries->find({entry_no => $entrylu{$phone{$item}}});
			$response .= 'found';
			foreach my $entrant ($entry->entrants) {
				$response .= $entrant->name;
			}
			my $diaryentry = $c->model('ClubTriumphDB::Item')->find_or_create({
				blogref => $item,
				contenttype => 14,
			});
			$diaryentry->update({
				content => $message{$item},
				view => $entry->menus->first->view});
#			$diaryentry->insert;
			$diaryentry->update({created => $time});
			$diaryentry->update({modified => $time});
			$diaryentry->link_to_menu($entry->menus->single);
			if ($attachs{$item}) {
				my @atts=split(/ /,$attachs{$item});
				foreach my $att (@atts) {
					my ($type,$fname)= split (/!/,$att);
					$fname=~s/\+/ /g;
					$response .= 'type '.$type.' filename '.$fname.'<br>';
					my $attitem = $diaryentry->items_attachments->find({title => $fname});
					my $aitem;
					if ($attitem) {$aitem = $attitem->id;}
					my $attachment = $diaryentry->attach_file($c,$fname,$mount.'/public_html/attachments/'.$fname,$type,$fname,$aitem,1,1);
					$attachment->update({created => $time});
					$attachment->update({modified => $time});
					$attachment->link_to_menu($entry->menus->single);
					if ($fname =~ /\.txt$/) {
						open (ATT, $mount.'/public_html/attachments/'.$fname);
						my $text;
						read(ATT,$text,10000000);
						close ATT;
						if ($text =~ /Latitude:(.*?),Longitude:(.*?)\n/ig) {
							$diaryentry->update({latitude => $1, longitude => $2});
							$diaryentry->update({modified => $time})
						}
					}
						
				}
			}
		}

		$response .= "<p>";
	}
	$c->stash(template => 'menu/message.tt2', message => $response);
	$self->unmount_triumph($c);
}



sub mount_triumph {
	my ($self,$c) = @_;
#	open(SSH,"sshfs -o password_stdin  triumph\@triumph.org.uk: /mount |");
#	print SSH 'AYz9gV0NFK';
	my $mount =$c->path_to('cmount');
	`echo AYz9gV0NFK | sshfs -o password_stdin  triumph\@triumph.org.uk: $mount`;
;#	`/home/Keith/ClubTriumph/mount.sh`;
	return $mount;

}


sub unmount_triumph {
	my ($self,$c) = @_;
	my $mount =$c->path_to('cmount');
	`fusermount -u $mount`;
}


=cut
ClubTriumph->schedule(
	at => '* * * * *',
	event => \&do_stuff,
    );
    



=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
