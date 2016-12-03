package Hubble::Api;
use Moo;
use JSON;
use LWP::UserAgent;

has device_uid => (
    is => 'ro',
    required => 1
);

has device_secret_key => (
    is => 'ro',
    required => 1
);

has endpoint => (
    is => 'ro',
    required => 1
);

has ua => (
    is => 'lazy',
    builder => '_build_ua'
);

sub _build_ua {
    my ($self) = @_;
    my $ua = LWP::UserAgent->new();
    return $ua;
}

sub update_device {
    my ($self, $data_hash) = @_;

    my $response = $self->ua->post($self->endpoint."/api/v1/devices/".$self->device_uid."/latest",$data_hash);
    #TODO check for json response
    return $response->is_sucess;

}

sub is_api_ok {
    my ($self) = @_;
    my $response = $self->ua->get($self->endpoint."/api/v1/healthcheck");
    #TODO Check the JSON response
    return 1;
}


1;
