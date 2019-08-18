package ClubTriumph::Schedule::Schedtest;
use Moose;
use namespace::autoclean;
=cut
BEGIN { extends 'Catalyst::Plugin::Scheduler'; }


    __PACKAGE__->schedule(
        at    => '* * * * *',
        event => \&do_stuff,
    );
    
sub do_stuff {
	my $file = '/home/Keith/temp/time.txt';
	open (FILE,">$file");
	print FILE time;
	close FILE;
	
	
}
=cut
