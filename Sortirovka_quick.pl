#!/usr/bin/perl


use strict;
use warnings;

my @input_array = qw(10 2 5 1 88 23 82 322 0 4 7 42 6 77 90 14);
print("Input array: @input_array\n");
my @result_array = quick_sort(@input_array);

print("Sorted result: @result_array\n");

sub quick_sort {
	my @array = @_;
	if(scalar(@array) < 2) {
		return @array;
	}
	my $pivot = $array[0];

	my @less = ();
	my @greater = ();
	my $i = 1;
	while($i < scalar(@array)) {
		if($array[$i] < $pivot) {
			push(@less, $array[$i]);
		}
		if($array[$i] > $pivot) {
			push(@greater, $array[$i]);
		}
		$i++;
	}
	my @result = ();
	push(@result, quick_sort(@less));
	push(@result, $pivot);
	push(@result, quick_sort(@greater));
	return @result;
}
