package Diveplane;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK=qw(init rand);

my @dataset = ();
my $seed = undef;

my $probsum;

# Initialize the module with data and an optional seed
sub init(\%$) {
	# Arguments:
	# $dataref : a ref that points to a hash where the keys are numbers and
	#            the values are relative probabilities as numbers
	# $iseed   : an integer containing the initial seed value for the
	#            randomization algorithm; defaults to 1
	my ($dataref, $iseed) = @_;

	# Don't assume the probablities add up to 1
	$probsum = 0;

	# Sort the data so we can make sure that output is reproducible
	# and do it at input time to do it only once per input set
	foreach my $key (sort {$a <=> $b} keys %$dataref) { ### Note: sort numerically
		# put sorted data into an array of tuples
		$probsum += $$dataref{$key};
		push @dataset, [$key, $$dataref{$key}, $probsum];
	}

	# default the rand seed to 1
	if (defined($iseed)) {
		$seed = $iseed;
	} else {
		$seed = 1;
	}
}

# Select a probabilistically weighted random value
# Returns one of the keys from the input set
sub rand {
	# Arguments: none

	# Make sure the module has been properly initialized
	if (scalar(@dataset) == 0) {
		return undef;
	}

	# Choose a random number between 0 and the total of the probabilities
	my $rn = lcg() * $probsum;

	# Walk through the dataset to find the point where the random number lies
	my $i = 0;
	while ( $rn > $dataset[$i][2] ) {
		$i++;
	}

	# Returning the previous number because the increment went past it
	return $dataset[$i][0];
}
	

# Repeatable random number generator (linear congruential generator)
# Returns float from 0-1
sub lcg {
	# Arguments: none
	my $modulus = (2**31)-1;
	my $multiplier = 1103515245;
	my $increment = 12345;
	my $mask = 0x3FFFFFFF;

	$seed = ( ( ( $multiplier * $seed ) + $increment ) % $modulus ) & $mask;
	#print $seed . "\n";
	return $seed / ((2**30)-1);
}

1;
