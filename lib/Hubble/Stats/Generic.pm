package Hubble::Stats::Generic;

use Moo;
use Unix::Statgrab;
use Math::Round;
use Data::Dumper;

sub get_cpu_percent {
    my ($self) = @_;
    my $stat_init = get_cpu_stats();
    
    #We have to wait in order to get an "instant" result
    select(undef, undef, undef, 0.25);

    my $cpu_hash = get_cpu_stats()->get_cpu_stats_diff($stat_init)->get_cpu_percents()->fetchall_hashref->[0];
    my $percent = 100-$cpu_hash->{idle};
    
    return 0 if $percent eq 'NaN';
    return round($percent);
}

sub get_memory_stats {
    my ($self) = @_;
    my $ram_hash = get_mem_stats()->fetchall_hashref->[0];

    return (round($ram_hash->{total}/1024/1024),round($ram_hash->{free}/1024/1024));
}

sub get_drives_stats {}

sub get_system_info {
    my ($self) = @_;
    return get_host_info()->fetchall_hashref->[0];
}

1;