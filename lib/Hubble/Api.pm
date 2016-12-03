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

has verbose => (
    is => 'ro',
    default => 1
);

sub _build_ua {
    my ($self) = @_;
    my $ua = LWP::UserAgent->new();
    $ua->default_header("HUBBLE-DEVICE-KEY",$self->device_secret_key);
    return $ua;
}

sub update_device {
    my ($self, $data_hash) = @_;

    my $response = $self->ua->post($self->endpoint."/api/v1/devices/".$self->device_uid."/latest",$data_hash);
    print "API response : \n".$response->decoded_content."\n" if $self->verbose;
    return $response->is_success;

}

sub is_api_ok {
    my ($self) = @_;
    my $response = $self->ua->get($self->endpoint."/api/v1/healthcheck");
    #TODO Check the JSON response
    return 1;
}


1;
