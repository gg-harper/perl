#!/usr/bin/perl

use strict;
use warnings;
use lib ".";

use Tools;


if (@ARGV == 3 && $ARGV[2] eq 'login') {
     (my $name, my $password) = @ARGV;
    if (v_login($name, $password)) {
        print("Welcome, $name!\n");
    }
    else {
        print("Wrong user or password!\n");
    }
}