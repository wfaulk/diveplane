#!/usr/bin/perl

use strict;
use warnings;

use lib '.';
use Diveplane;

my %d = (
	1 => 0.25,
	2 => 0.5,
	7 => 0.25 );

print "reading data\n";
my %input = do "input.pl";
print "done reading data\n";

print "initalizing module\n";
Diveplane::init(%input, 123);
#Diveplane::init(%d, 1);
print "done initalizing module\n";

for (my $i=0; $i<10000; $i++) {
	my $v;
	$v = Diveplane::rand();
	die() if not defined $v;
	print "$v\n";
	#print Diveplane::lcg() . "\n";
}
