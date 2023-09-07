#!/usr/bin/perl
#
#
use strict;
use warnings;
use POSIX qw/ceil/;

print("Input tasks: \n");
my $input = <STDIN>;
print("Output tasks: \n");
my $output = <STDIN>;
print("Backlog count: \n");
my $backlog = <STDIN>;
my $result = ceil($backlog / (($output  - $input) * 10)); 

my $answer_string = $result > 0 ? "Успеет за $result спринт(ов)" : 'Не успеет';

print("$answer_string");

