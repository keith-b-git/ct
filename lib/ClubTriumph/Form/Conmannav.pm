    package ClubTriumph::Form::Conmannav;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    use namespace::autoclean;
#    my $self = shift;
#        my $pids = $self->schema->get_column('pid');
    has '+item_class' => ( default =>'content' );
	has 'resultset' => ( isa => 'DBIx::Class::ResultSet', is => 'rw',
        trigger => sub { shift->set_resultset(@_) } );
sub set_resultset {
    my ( $self, $resultset ) = @_;
    $self->schema( $resultset->result_source->schema );
}
sub init_object {
    my $self = shift;
    my $rows = [$self->resultset->all];
    return { content => $rows };
}
    has_field 'pid' => ( type => 'Select',
        empty_select => '---Select---',);   
#	has_field 'pid_options';
#    sub options_pid
 #  {
 #     my $self = shift;
 #     return unless $self->schema;
 #     my $content = $self->schema ;
  #    my @rows =
     #    $self->schema->all;
 #     my @selections;      
  #    while ( my $license = $licenses->next ) {
  #       push @selections, { value => $license->id, label => $license->label,
  #            note => $license->note };
  #    }
  #    return @;
 #  } 
 
#options => $pids 
    __PACKAGE__->meta->make_immutable;
    1;
