package ClubTriumph::Controller::shop;
use Moose;
use namespace::autoclean;
use ClubTriumph::Form::Item;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ClubTriumph::Controller::shop - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub new_shop_item :Chained('/menu/base') :PathPart('new_shop_item') :Args(0) {
	my ($self, $c, $tag, $tagid) = @_;
	my $item = $c->model('ClubTriumphDB::Item')->new_result({contenttype => '8',author => $c->user->id, view => 256, reply => 128});
	
	return $self->shopform($c, $item, $tag, $tagid);
}

sub shopedit : Chained('/item/item') PathPart('shop_edit') Args(0) {
	my ( $self, $c ) = @_;
	unless ($c->user) {$c->error( "You must be logged in to access this") }
	unless ($c->stash->{item}->editable_by($c->user)) {$c->error( "You do not have permission to edit this") }
        return $self->shopform($c, $c->stash->{item});
    }

sub shopform  {
	my ( $self, $c, $item ) = @_;
#		my @field_list = $item->blogtags($c);
		my $form = ClubTriumph::Form::Item->new(
		item => $item,
#		field_list => \@field_list,
#		tags => \@field_list,
        user => $c->user,
        c => $c,
		);
        $c->stash( template => 'item/itemform.tt2', form => $form, $item );
        my $params = $c->req->params;
        my %param = %$params;
        $param{photo} = $c->req->upload('photo')  if $c->req->method eq 'POST';
        $form->process( item => $item, params => \%param, ); #, inactive => ['photo']
#       
        return unless $form->validated;
		$item->update_item($c);
#		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'item', $item->id, 'view', {mid => $c->set_status_msg("Message updated")}))
		$c->response->redirect($c->uri_for('/menu', $c->stash->{menu_item}->pid, 'view')) #, {mid => $c->set_status_msg("Shop item updated")})
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
