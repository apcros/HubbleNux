package Hubble::Engine;
use Moo;

use Hubble::Stats::Generic;
use Hubble::Api;

use Data::Dumper;

has generic_stats => (
    is => 'ro',
    lazy => 1,
    builder => '_build_generic_stats'
);

has wait_time => (
    is => 'ro'
);

sub _build_generic_stats {
    my ($self) = @_;
    return Hubble::Stats::Generic->new();
}

sub get_data_hash {
    my ($self) = @_;
    my ($ram_total, $ram_free) = $self->generic_stats->get_memory_stats();

    return {
        cpu_usage => $self->generic_stats->get_cpu_percent(),
        ram_total => $ram_total,
        ram_free  => $ram_free,
    }
}

sub run {
    my ($self) = @_;
    while (1) {
        my $stats_hash = $self->get_data_hash();
        print Dumper($stats_hash);
        sleep $self->wait_time;
    }
}
1;