package ClubTriumph::Controller::advert;
use Moose;
use namespace::autoclean;
use ClubTriumph::Form::Item;

BEGIN { extends 'Catalyst::Controller'; }




sub new_advert :Chained('/menu/base') :PathPart('new_advert') :Args(0) {
	my ($self, $c) = @_;
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '9',author => $c->user->id, view => 256, reply => 128});
	return $self->advertform($c, $item);
}

sub advertform  {
	my ( $self, $c, $item ) = @_;
		my @field_list = $item->blogtags($c);
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
		field_list => \@field_list,
#		tags => \@field_list,
        user => $c->user,
        c => $c
		);
		my $params = $c->req->params;
		my %param = %$params;
		if ($c->req->upload) {
			my @attachments = grep {$_ =~ /^attachments/} keys %{$c->req->{uploads}}; 
			foreach my $attachment (@attachments) {
				$param{$attachment} = $c->req->upload($attachment)  if $c->req->method eq 'POST';
				my $filename = $c->req->upload($attachment)->filename;
				my $tempname = $c->req->upload($attachment)->tempname;
				my $type = $c->req->upload($attachment)->type;
				$param{$attachment.'name'} = $c->req->upload($attachment)->filename;
				$attachment =~ s/file$//;
				my $newtemp = $tempname;
				$newtemp =~ s/^\/tmp\///;
				use File::Copy;
				$param{$attachment.'tempname'} = $newtemp;
				$param{$attachment.'type'} = $type;
				copy($tempname,$c->path_to('root','static','temp').'/'.$newtemp); #create persistent temp file
				$param{$attachment.'tempname'} = $newtemp;
			}
		}
        $c->stash( template => 'item/itemform.tt2', form => $form, item => $item );
        $form->process( item => $item, params => \%param,no_update=>1, inactive => ['photo']);
#       
		$item->update_item($c);
        return unless $form->validated;
		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Message updated")}))
}




=encoding utf8

=head1 AUTHOR

Keith Bennett

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
