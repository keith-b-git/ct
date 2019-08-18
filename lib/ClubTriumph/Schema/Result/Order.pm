use utf8;
package ClubTriumph::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ClubTriumph::Schema::Result::Order

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

=head1 TABLE: C<orders>

=cut

__PACKAGE__->table("orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 forename

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 surname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 address1

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 address2

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 address3

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 address4

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 address5

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 tel

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 country

  data_type: 'text'
  is_nullable: 1

=head2 user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 memform

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 pandp

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 total

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 paid

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 tandcs

  data_type: 'integer'
  is_nullable: 1

=head2 time_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 approval_code

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 ref_number

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 status

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 txndate_processed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 tdate

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 fail_reason

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 response_hash

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 processor_response_code

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 fail_rc

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 terminal_id

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 ccbin

  data_type: 'text'
  is_nullable: 1

=head2 cccountry

  data_type: 'text'
  is_nullable: 1

=head2 ccbrand

  data_type: 'text'
  is_nullable: 1

=head2 response_code_3dsecure

  data_type: 'integer'
  is_nullable: 1

=head2 oid

  data_type: 'text'
  is_nullable: 1

=head2 ct_status

  data_type: 'text'
  is_nullable: 1

=head2 last_four

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "forename",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "surname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "address1",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "address2",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "address3",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "address4",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "address5",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "postcode",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "tel",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "country",
  { data_type => "text", is_nullable => 1 },
  "user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "memform",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "pandp",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "total",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "paid",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "tandcs",
  { data_type => "integer", is_nullable => 1 },
  "time_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "approval_code",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "ref_number",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "status",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "txndate_processed",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "tdate",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "fail_reason",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "response_hash",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "processor_response_code",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "fail_rc",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "terminal_id",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "ccbin",
  { data_type => "text", is_nullable => 1 },
  "cccountry",
  { data_type => "text", is_nullable => 1 },
  "ccbrand",
  { data_type => "text", is_nullable => 1 },
  "response_code_3dsecure",
  { data_type => "integer", is_nullable => 1 },
  "oid",
  { data_type => "text", is_nullable => 1 },
  "ct_status",
  { data_type => "text", is_nullable => 1 },
  "last_four",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 baskets

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Basket>

=cut

__PACKAGE__->has_many(
  "baskets",
  "ClubTriumph::Schema::Result::Basket",
  { "foreign.orderno" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<ClubTriumph::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "ClubTriumph::Schema::Result::Entry",
  { "foreign.orderno" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 member

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Member>

=cut

__PACKAGE__->belongs_to(
  "member",
  "ClubTriumph::Schema::Result::Member",
  { memno => "member" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 memform

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::Memform>

=cut

__PACKAGE__->belongs_to(
  "memform",
  "ClubTriumph::Schema::Result::Memform",
  { id => "memform" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 user

Type: belongs_to

Related object: L<ClubTriumph::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "ClubTriumph::Schema::Result::User",
  { id => "user" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-10-16 15:48:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cpy1ID7dZqSCMk3a23veyQ

sub total_up {
	my ($self,$c) =@_;
	my $total =0;
	if ($c->session->{application}) {
		my $application = $c->model('ClubTriumphDB::Memform')->find({id => $c->session->{application}->id});
		$total += $application->total;
	}
	$total += $c->model('ClubTriumphDB::Basket')->basket_total($c);
	if ($c->user) {
		if ($c->user->memno) {
			foreach my $entry ($c->user->memno->draft_entries) {
				if ($entry->amount_payable > $entry->paid) {
					$total += ($entry->amount_payable - $entry->paid)
				}
			}
		}
		else {
			foreach my $entry ($c->user->draft_entries) {
				if ($entry->amount_payable > $entry->paid) {
					$total += ($entry->amount_payable - $entry->paid)
				}
			}
		}
	}
	foreach my $entry ($self->entries->search({status => 'in_payment'})) {
		$total += ($entry->amount_payable - $entry->paid)
	}
#	if ($self->in_storage) {$self->update({total => $total})};
	$self->total($total);
	return $total;
}

sub formatteddate {
	my $self = shift;
#	unless ($self->time_date) #
#$self->update({time_date => DateTime->now});
	return $self->time_date->strftime ('%Y:%m:%d-%H:%M:%S');
}

sub sha256_string {
	my ($self,$c) =@_;
	my $storename = $c->config->{'Model::Order'}->{'storename'};
	my $sharedsecret = $c->config->{'Model::Order'}->{'shared_secret'};
	my $stringtohash = $storename.$self->formatteddate.$self->total.'826'.$sharedsecret;
	my $ascii = unpack('H*', $stringtohash);
	use Crypt::Digest::SHA256 qw( sha256 sha256_hex sha256_b64 sha256_b64u
                             sha256_file sha256_file_hex sha256_file_b64 sha256_file_b64u );;
	return sha256_hex($ascii);
}

sub response_sha256_string {
	my ($self,$c) =@_;
	my $storename = $c->config->{'Model::Order'}->{'storename'};
	my $sharedsecret = $c->config->{'Model::Order'}->{'shared_secret'};
	my $stringtohash = $sharedsecret.$c->req->params->{approval_code}.$self->total.'826'.$self->formatteddate.$storename;
	my $ascii = unpack('H*', $stringtohash);
	use Crypt::Digest::SHA256 qw( sha256 sha256_hex sha256_b64 sha256_b64u
                             sha256_file sha256_file_hex sha256_file_b64 sha256_file_b64u );;
	return sha256_hex($ascii);
}

sub process_payment {
	my ($self,$c) =@_;
	unless ($c->req->params->{response_hash} && $c->req->params->{response_hash} eq $self->response_sha256_string($c)) {
		die 'communication error, please contact an administrator'
	}
	$self->update({
		approval_code => $c->req->params->{approval_code},
		ref_number => $c->req->params->{refnumber},
		status => $c->req->params->{status},
		txndate_processed => $c->req->params->{txndate_processed},
		tdate => $c->req->params->{tdate},
		fail_reason => $c->req->params->{fail_reason},
		response_hash => $c->req->params->{response_hash},
		processor_response_code => $c->req->params->{processor_response_code},
		fail_rc => $c->req->params->{fail_rc},
		terminal_id => $c->req->params->{terminal_id},
		ccbin => $c->req->params->{ccbin},
		cccountry => $c->req->params->{cccountry},
		ccbrand => $c->req->params->{ccbrand},
		response_code_3dsecure => $c->req->params->{response_code_3dsecure},
		oid => $c->req->params->{oid}
	});
	if ($self->status eq 'APPROVED') {$self->update({paid => $c->req->params->{chargetota}, ct_status => 'submitted'})}
}

sub email_customer { #send message e-mail to customer
	my ($self,$c,$message,$subject,$sender,$template) = @_;
	$c->stash(message => $message);
	$c->stash->{email} = {
        to      => $self->email,
        from    => $sender,
        subject => $subject,
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };
	$c->stash(order => $self, mail_template => $template);
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}

sub email_official { #send message e-mail to treasurer
	my ($self,$c,$recipient) = @_;
	$c->stash->{email} = {
        to      => $recipient,
        from    => 'admin@club.triumph.org.uk',
        subject => 'new Club Triumph order',
        templates => $c->config->{'View::Email::Template'}->{multi_templates},
		content_type => 'multipart/alternative'
    };
	$c->stash(order => $self, mail_template => 'order_details.tt2');
	$c->forward( $c->view( 'Email::Template' ) );
	if ( scalar( @{ $c->error } ) ) {
#	    $c->error(0); # Reset the error condition if you need to
	    $c->log->debug('Oh noes!'.$c->last_error);
	} else {
	    $c->log->debug('Email sent A-OK! (At least as far as we can tell)');
	}
}

sub email_notifications { #send email s to treasurer and relevant parties
	my ($self, $c) = @_; 
	$self->email_official($c,'payments@club.triumph.org.uk');
	if ($self->memform) {
		$self->email_official($c,'membership@club.triumph.org.uk');
	}
	foreach my $entry ($self->entries) {
		$self->email_official($c,$entry->event->email)
	}
	if ($self->baskets->count({})) {
		$self->email_official($c,'shop@club.triumph.org.uk')
	}
}


sub is_open {
	my ($self,$c) = @_;
	return (($self->ct_status eq 'draft') && 
		($c->session->{order} && ($c->session->{order}->id == $self->id)
		|| !($self->in_storage))
		)
}

sub application {
	my ($self,$c) = @_;
	if ($self->is_open($c)) {
		if ($c->session->{application}) {
			return $c->model('ClubTriumphDB::Memform')->find({id => $c->session->{application}->id})
		}
	}
	else {
		if ($self->memform) {
			return $self->memform
		}
	}
}

sub purchases {
	my ($self,$c) = @_;
	if ($self->is_open($c))  {
		return $c->model('ClubTriumphDB::basket')->all_items($c)
	}
	else
	{
		my @purchases =  [$self->baskets];
		return @purchases
	}
}

sub entries_attached {
	my ($self,$c) = @_;
	if ($self->is_open($c))  {
		if ($c->user && $c->user->memno) {
			my $halfhourago = DateTime->now->subtract(minutes => 30);
			return [$c->user->memno->draft_entries];
		}
	else {
			if ($c->user) {
				my $halfhourago = DateTime->now->subtract(minutes => 30);
				return [$c->user->draft_entries];
			}
		}
	}
	else {
		return [$self->entries]
	}
}

sub summary {
	my ($self,$c) = @_;
	my $summary;
	if ($self->memform) {
		$summary .= "membership £".$self->memform->total."\n";
	}
	foreach my $entry ($self->entries) {
		$summary .= "entry- ".$entry->teamdesc."\n"; 
	}
	foreach my $purchase ($self->baskets) {
		if ($purchase->item) {
			$summary .= 'shop - '.$purchase->item->title." £".$purchase->price.' * '.$purchase->quantity."\n";
		}
	}
	return $summary
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
