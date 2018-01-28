#!/usr/bin/perl

use strict;
use warnings;

my $i = 0;
my $max = 62345;

for ($i=0; $i<$max; $i++) {
	my $r = sprintf("%0.2f", rand());
	if ($r eq "0.00") {
		$r = "0.01";
	}
	print $i . ' => ' . $r . ",\n";
}
