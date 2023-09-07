#!/usr/bin/perl
#
#
use strict;
use warnings;
use POSIX qw/ceil/;

print("in: \n");
my $input = <STDIN>;
print("out: \n");
my $output = <STDIN>;
print("backlog: \n");
my $backlog = <STDIN>;

my $result = _calculate($input, $output, $backlog);
my $answer_string = $result > 0 ? "Успеет за $result спринт(ов)" : 'Не успеет';

print("$answer_string");
print("\n");


sub _calculate {
	my ($in, $out, $backlog) = @_;
		
	return ceil($backlog / (($out  - $in) * 10)); 
}

