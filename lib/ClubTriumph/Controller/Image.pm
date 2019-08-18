package ClubTriumph::Controller::Image;

use Moose;
BEGIN { extends 'Catalyst::Controller::Imager'; }

__PACKAGE__->config(
    # the directory to look for files (inside root)
    # defaults to 'static/images'
    root_dir => 'static/pics',
        
    # specify a cache dir if caching is wanted
    # defaults to no caching (more expensive)
    cache_dir => 'root/cache',
        
    # specify a maximum value for width and height of images
    # defaults to 1000 pixels
    #max_size => 1000,
    
	# specify a typical size for thumnnails (/thumbnail/ in URI-path)
	# defaults to 80 x 80 square
	#thumbnail_size => 80,
        
    # specify a default format
    # default: jpg
    #default_format => 'jpg',

    # in case of jpeg, specify quality in percent
	# default: 95%
	# jpeg_quality => 95,
);

=head1 NAME

ClubTriumph::Controller::Image - Imager Controller for ClubTriumph

=head1 DESCRIPTION

Imager Controller for ClubTriumph. 

=head1 METHODS

=cut

# uncomment if you like to change default behavior
# =head2 index
# 
# generate an image
# 
# =cut
# 
# sub index :Local :Args() {
#     my ( $self, $c, @args ) = @_;
#     # whatever we need to do here
#     
#     $c->detach('generate_image', @args);
# }

sub want_thumb :Action :Args(0) {
	my ($self, $c) = @_;      
	$c->stash(scale => {w => 120, h => 80, mode => 'min'});
}

=head1 SEE ALSO

L<ClubTriumph>

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
