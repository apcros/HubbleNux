package Hubble::Engine;
use Moo;

use Hubble::Stats::Generic;
use Hubble::Api;

use Data::Dumper;


has generic_stats => (is => 'ro', lazy => 1, builder => '_build_generic_stats');
has wait_time => (is => 'ro');

sub _build_generic_stats {
	my ($self) = @_;
	return Hubble::Stats::Generic->new();
}

sub get_stats_hash {
	my ($self) = @_;
	print Dumper($self);
	return {
		cpu_usage => $self->generic_stats->get_cpu_percent()
	}
}

sub run {
	my ($self) = @_;
	while (1) {
		my $stats_hash = get_stats_hash();
		print Dumper($stats_hash);
		sleep $self->wait_time;
	}
}
1;