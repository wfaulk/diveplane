#!/usr/bin/perl

use strict;
use warnings;

my $i = 0;
my $max = 62345;

for ($i=0; $i<$max; $i++) {
	print $i . ' => ' . rand() . ",\n";
}
