package Hubble;

use Moo;
use LWP::UserAgent;
use Unix::Statgrab;
use Data::Dumper;

sub get_cpu_percent {
	my ($self) = @_;
	my $cpu_hash = get_cpu_stats()->fetchall_hashref->[0];
	print Dumper($cpu_hash);

	my $percent = 100-$cpu_hash->{idle};

	print "$percent - $cpu_hash->{time_taken}\n";
	#print Dumper($cpu_percent);
}

1;