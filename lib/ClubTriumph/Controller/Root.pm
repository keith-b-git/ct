package ClubTriumph::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

ClubTriumph::Controller::Root - Root Controller for ClubTriumph

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->response->redirect($c->uri_for('/menu',1,'view'));
}

sub indexhtml  :Local :Path('index.html') :Args(0) {
	my ( $self, $c ) = @_;
	$c->response->redirect($c->uri_for('/menu',1,'view'));
}


=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub robots  :Local :Path('robots.txt') :Args(0) {
	my ( $self, $c ) = @_;
	$c->response->body( "User-agent: *\nDisallow: / " );
}


=head2 end

Attempt to render a view, if needed.

=cut

#sub end : ActionClass('RenderView') {}

=head2 auto
 
Check if there is a user and, if not, forward to login page
 
=cut
 
# Note that 'auto' runs after 'begin' but before your actions and that
# 'auto's "chain" (all from application path to most specific class are run)
# See the 'Actions' section of 'Catalyst::Manual::Intro' for more info.
sub auto :Private {
    my ($self, $c) = @_;$c->log->debug('here%%%%%%%');
    if ($c->config->{'Controller::Root'}->{require_ssl}) {
		$c->require_ssl;
	}
	$c->load_status_msgs; 
	if (!($c->user_exists) && $c->authen_cookie_value ) { # handle persistent user login
		my $user = $c->model('ClubTriumphDB::User')->find({id => $c->authen_cookie_value->{user_id}});
		if ($user) { 
			use Unicode::UTF8 qw[decode_utf8 encode_utf8];
			if ($c->authenticate({id => $user->id, password => decode_utf8($c->authen_cookie_value->{password})})) {
				my %expires;
				%expires = ( expires => '+1y' );
				$c->set_authen_cookie(
					value => { user_id => $c->user->id, password => encode_utf8($c->user->password) },
					%expires,
				);
			}
			else { $c->unset_authen_cookie } 
		}
	}
	my $mobile_detected = (($c->request->browser->mobile && !$c->session->{mobile_override}) || (!$c->request->browser->mobile && $c->session->{mobile_override}));
	my $home=$c->model('ClubTriumphDB::Menu')->find({pid => 1});
	my $db_updated = $c->model('ClubTriumphDB::DbStatus')->find({id => 1})->menu_updated;
	$c->stash(menu_start => $home,mobile => $mobile_detected); 
	if (! $c->session->{menu_object} || ! $c->session->{menu_status} ||
		(DateTime->compare($db_updated, $c->session->{menu_status}{menu_update})) ||
		$c->user && (
			($c->session->{menu_status}{user} != $c->user->id) || 
			($c->session->{menu_status}{level} != $c->user->access_level)) ||
			($c->session->{menu_status}{user} && ! $c->user_exists)
			) {
			if ($c->user_exists) {
				$c->session(menu_object => $home->menu_object($c->user,3));
				$c->session(menu_status => {user => $c->user->id, level => $c->user->access_level, menu_update => $db_updated})}
			else {
				$c->session(menu_status => {user => 0, level => 256, menu_update => $db_updated})}
		} 
	

	if ($c->user_exists) {
		$c->stash(menu_object => $c->session->{menu_object});
	}
	else {
		my $menufile = $c->path_to('root','data','menufile');
		use Storable qw(lock_store lock_retrieve); 
		if (-e $menufile && ((stat($menufile))[9] > $db_updated->epoch)) {
			my $menuobj = lock_retrieve($menufile);
			$c->stash(menu_object => $menuobj);
			}
		else {
			my $menuobj = $home->menu_object($c->user,3);
			lock_store($menuobj,$menufile);
			$c->stash(menu_object => $menuobj);
		}
	}
	
	my $userid;
	if ($c->user_exists) {
		$userid=$c->user->id;
		if (($c->user->memno && $c->user->memno->memno == 85645) && $c->req->params->{level_fake}) {
			$c->session(level_fake => $c->req->params->{level_fake});
			$c->session(menu_access_level => undef);
		}
#		if ($c->session->{level_fake}) {$ClubTriumph::access_level{$c->user->id} = $c->session->{level_fake}}
#		$ClubTriumph::access_level{$c->user->id} = $c->user->access_level;
		$c->stash(
			blogs_per_page => $c->user->blogs_per_page || 10,
			threads_per_page => $c->user->threads_per_page || 20,
			replies_per_page => $c->user->replies_per_page || 20,
			images_per_page => $c->user->images_per_page || 20,
			shop_per_page => $c->user->shop_per_page || 12,
			diary_per_page => 20 # $c->user->shop_per_page || 12
		);
	} else {
		$c->stash(access_level => 256);
		$c->stash(
			blogs_per_page => 10,
			threads_per_page => 20,
			replies_per_page => 20,
			images_per_page => 20,
			shop_per_page => 12
		);
	}
	my $active = $c->model('ClubTriumphDB::Active')->find_or_create({ip_address => $c->req->address});
	my $string = 'guest';
	if ($c->req->browser->robot_string) {$string = $c->req->browser->robot_string}
	if ($c->user_exists) {$string = $c->user->username}
	$active->update({user => $userid, robot_string => $string});
    return 1;
}


   sub end : ActionClass('RenderView') {
      my ( $self, $c ) = @_;
      # do stuff here; the RenderView action is called afterwards
       if ( scalar @{ $c->error } ) {
         $c->stash->{errors}   = $c->error;
       for my $error ( @{ $c->error } ) {
 #               $c->log->error($error);
			            $c->log->debug($error);
         }
            $c->stash->{template} = 'errors.tt2';
            
			use Data::Dumper;
			my $dump = Dumper($c->stash);
#            $c->session(dump => $dump);
             $c->forward('ClubTriumph::View::HTML');
             $c->clear_errors;
		 }
        return 1 if $c->response->status =~ /^3\d\d$/;
        return 1 if $c->response->body;

        unless ( $c->response->content_type || $c->stash->{current_view}  ) { #removed to fix duplicate csv output
            $c->response->content_type('text/html; charset=utf-8');
			$c->forward('ClubTriumph::View::HTML');
        }

  

    }

sub report_error  :Local :Path('report_error') :Args(0) {
	my ( $self, $c ) = @_;
	my $sender;
	if ($c->user && $c->user->email) {$sender = $c->user->email}
	my $email = $c->config->{'Controller::Root'}->{admin_address};
	my @templates = @ {$c->config->{'View::Email::Template'}->{multi_templates}};
	push (@templates, {
		template        => 'error_dump.tt2',
		content_type    => 'application/x-gzip',
		charset         => 'utf-8',
		encoding        => '7bit',
		view            => 'HTML', 
	});
	$c->stash->{email} = {
        to      => $email,
        from    => $sender,
        subject => 'Club Triumph Error Report',
        templates => \@templates,
		content_type => 'multipart/alternative'
    };
    use Data::Dumper;
    use Gzip::Faster;
    use MIME::Base64;
	my $dump = encode_base64(gzip(Dumper($c->session)));
	$c->session(dump => '');
	use URI::Encode;
	my $uri = URI::Encode->new( { encode_reserved => 0 } );
    my $errors = $uri->decode($c->req->params->{errors});
	$c->stash(errors => $errors, reason => $uri->decode($c->req->params->{reason}), uri => $uri->decode($c->req->params->{request}), dump => $dump, mail_template => 'error_report.tt2',);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
	$c->stash(template => 'menu/message.tt2', message => 'Thank you for reporting this');
}


=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
