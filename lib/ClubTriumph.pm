package ClubTriumph;
use Moose;
use namespace::autoclean;
use Catalyst::Runtime 5.80;
use utf8;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
-Debug     StackTrace
    ConfigLoader
    Static::Simple

    Authentication

 
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    StatusMessage

	Scheduler
/;
#    Session::Store::File     Scheduler     -Debug     StackTrace

use CatalystX::RoleApplicator;

extends 'Catalyst';
__PACKAGE__->apply_request_class_roles(qw/
    Catalyst::TraitFor::Request::ProxyBase/);
with 'CatalystX::AuthenCookie';
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in clubtriumph.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'ClubTriumph',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    ENCODING => 'utf8',
);
__PACKAGE__->config(
    # Configure the view
    'View::HTML' => {
        #Set the location for TT files
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'src' ),
        ],
#    ENCODING => 'utf8',
    },
    
);


__PACKAGE__->config('Plugin::Session' => {
        expires   => 3600,
#        dbi_dbh   => 'ClubTriumphDB', # which means MyApp::Model::DBIC
#        dbi_table => 'sessions',
#        dbi_id_field => 'id',
#        dbi_data_field => 'session_data',
#        dbi_expires_field => 'expires',
		compress => 'snappy',
		cookie_secure => 0,
    });

__PACKAGE__->config('Plugin::Session::Store' => {

		compress => 'snappy'
    });



__PACKAGE__->config(
    'Plugin::Authentication' => {
        default => {
            class           => 'SimpleDB',
            user_model      => 'ClubTriumphDB::User',
            password_type   => 'clear',
        },
    },
);



# Configure SimpleDB Authentication
__PACKAGE__->config(
    'authen_cookie' => {
     mac_secret => 'secret',
     secure => 1,
    },
);

__PACKAGE__->config(
      'Model::Search' => {
 #       transport    => 'http',
        nodes      => 'localhost:9200',
        timeout      => 60,
        max_requests => 10_000,
#		trace_to => ['File','/home/Keith/temp/elasticdebug.txt'],
      }
    );


__PACKAGE__->config(
	'Controller::Clubtorque' => {
		clubtorque_dir => 'clubtorque',
		article_dir => 'articles',
		ct_cover_dir => 'clubtorque'
	}
);

__PACKAGE__->config(
	'Controller::Root' => {
		admin_address => 'admin@club.triumph.org.uk'
	}
);

__PACKAGE__->config(
	'Model::Item' => {
		photo_dir => 'pics',
		upload_dir => 'uploads'
	}
);



__PACKAGE__->config(
      'View::JSON' => {
          allow_callback  => 1,    # defaults to 0
          callback_param  => 'cb', # defaults to 'callback'
         expose_stash    => [ qw( message resultCode data) ], # defaults to everything
      },
  );

__PACKAGE__->config(
    'View::Email' => {
        # Where to look in the stash for the email information.
        # 'email' is the default, so you don't have to specify it.
        stash_key => 'email',
        # Define the defaults for the mail
        default => {
            # Defines the default content type (mime type). Mandatory
            content_type => 'text/plain',
            # Defines the default charset for every MIME part with the 
            # content type text.
            # According to RFC2049 a MIME part without a charset should
            # be treated as US-ASCII by the mail client.
            # If the charset is not set it won't be set for all MIME parts
            # without an overridden one.
            # Default: none
            charset => 'utf-8'
        },
        # Setup how to send the email
        # all those options are passed directly to Email::Sender::Simple
        sender => {
            # if mailer doesn't start with Email::Sender::Simple::Transport::,
            # then this is prepended.
            mailer => 'SMTP',
            # mailer_args is passed directly into Email::Sender::Simple 
            mailer_args => {
  #             ssl => 1,
 #              timeout => 10,
 #              debug => 'true',
        }
      }
    }
);


__PACKAGE__->config(

'View::Email::Template' => {
	
	        # Where to look in the stash for the email information.
        # 'email' is the default, so you don't have to specify it.
        stash_key => 'email',
        # Define the defaults for the mail
        default => {
            # Defines the default content type (mime type). Mandatory
            content_type => 'text/plain',
            # Defines the default charset for every MIME part with the 
            # content type text.
            # According to RFC2049 a MIME part without a charset should
            # be treated as US-ASCII by the mail client.
            # If the charset is not set it won't be set for all MIME parts
            # without an overridden one.
            # Default: none
            charset => 'utf-8'
        },
        # Setup how to send the email
        # all those options are passed directly to Email::Sender::Simple
        sender => {
            # if mailer doesn't start with Email::Sender::Simple::Transport::,
            # then this is prepended.
            mailer => 'SMTP',
            # mailer_args is passed directly into Email::Sender::Simple 
            mailer_args => {

               debug => 1,
        }
      },
 
	
    # Optional prefix to look somewhere under the existing configured
    # template  paths.
    # Default: none
    template_prefix => 'email',
    # Define the defaults for the mail
   default =>
   
        # Defines the default view used to render the templates.
        # If none is specified neither here nor in the stash
        # Catalysts default view is used.
        # Warning: if you don't tell Catalyst explicit which of your views should
        # be its default one, C::V::Email::Template may choose the wrong one!
        {view =>  'HTML',
		content_type    =>  'text/plain',
        charset         =>  'utf-8',},
        multi_templates => [
	    {
	        template        => 'text_email.tt2',
	        content_type    => 'text/plain',
	        charset         => 'utf-8',
	        encoding        => '7bit',
	        view            => 'HTML', 
	    },    
	    {
	        template        => 'html_email.tt2',
	        content_type    => 'text/html',
	        charset         => 'utf-8',
	        encoding        => '8bit',
	        view            => 'HTML', 
	    }
	]

	}
	);



our $__ACTIVE_CTX = undef;
sub ctx { $__ACTIVE_CTX }

around 'dispatch' => sub {
  my ($orig, $c, @args) = @_;
  local $__ACTIVE_CTX = $c;
  $c->$orig(@args)
};

# Load browser detection trait (for detecting mobiles)
__PACKAGE__->apply_request_class_roles(
	'Catalyst::TraitFor::Request::BrowserDetect' 
);

__PACKAGE__->config('View::PDF::Reuse' => {
  INCLUDE_PATH => __PACKAGE__->path_to('root','src'),
  ENCODING => 'utf8',
});

__PACKAGE__->config(
'Plugin::Scheduler' => {
debug =>'1',
time_zone => 'UTC'
}
);



# Start the application
__PACKAGE__->setup();





=encoding utf8

=head1 NAME

ClubTriumph - Catalyst based application

=head1 SYNOPSIS

    script/clubtriumph_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<ClubTriumph::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
