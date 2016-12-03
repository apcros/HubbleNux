package Hubble::Engine;
use Moo;

use Hubble::Stats::Generic;
use Hubble::Api;

use Data::Dumper;

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

has generic_stats => (
    is => 'ro',
    lazy => 1,
    builder => '_build_generic_stats'
);

has client => (
    is => 'ro',
    lazy => 1,
    builder => '_build_client'
);

has wait_time => (
    is => 'ro'
);

sub _build_generic_stats {
    my ($self) = @_;
    return Hubble::Stats::Generic->new();
}

sub _build_client {
    my ($self) = @_;
    return Hubble::Api->new(
        device_uid => $self->device_uid,
        device_secret_key => $self->device_secret_key,
        endpoint => $self->endpoint
    );
}
sub get_data_hash {
    my ($self) = @_;
    my ($ram_total, $ram_free) = $self->generic_stats->get_memory_stats();
    my $sys_info = $self->generic_stats->get_system_info();
    return {
        cpu_usage => $self->generic_stats->get_cpu_percent(),
        ram_total => $ram_total,
        ram_free  => $ram_free,
        name => $sys_info->{hostname},
        os_version => $sys_info->{os_name}." ".$sys_info->{platform}." ".$sys_info->{os_release},
        client_version => "PRE-ALPHA/0.1/LINUX",
        drives => []
    }
}

sub run {
    my ($self) = @_;
    while (1) {
        my $stats_hash = $self->get_data_hash();
        $self->client->update_device($stats_hash);
        sleep $self->wait_time;
    }
}
1;