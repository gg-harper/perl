#!/usr/bin/perl

use strict;
use warnings;

my @input_array = qw(10 2 5 1 88 23 82 322 0 4 7 42 6 77 90 2 2 2 14);
my @stdin_array = split(' ', <STDIN>);
if(@stdin_array > 0) {
	@input_array = @stdin_array;
}
print("Input array: @input_array\n");

my @result_array = _quick_sort(@input_array);

print("Sorted result: @result_array\n");

sub _quick_sort {
	my @array = @_;
	if(scalar(@array) < 2) {
		return @array;
	}
	my $pivot = $array[0];
	
	my @less;
	my @greater;
	my $i = 1;
	while($i < scalar(@array)) {
		if($array[$i] < $pivot) {
			push(@less, $array[$i]);
		} else {
			push(@greater, $array[$i]);
		}
		$i++;
	}
	return (_quick_sort(@less), $pivot, _quick_sort(@greater));
}
