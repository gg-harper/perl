#!/usr/bin/perl

use strict;
use warnings;
use lib ".";

use Tools;

sub main {
    while(1) {
            if (@ARGV == 3 && $ARGV[2] eq 'login') {
                (my $name, my $password) = @ARGV;
                if (v_login($name, $password)) {
                    print("Welcome, $name!\n");
                }
                else {
                    print("Wrong user or password!\n");
                }
                last;
            }

            if (@ARGV == 3 && $ARGV[2] eq 'add') {
                (my $name, my $password) = @ARGV;
                if (add_user($name, $password)) {
                    print("User added successfully!\n");
                }
                last;
            }

            if (@ARGV == 3 && $ARGV[2] eq 'update') {
                (my $name, my $password) = @ARGV;
                if (update_user($name, $password)) {
                    print("User info updated successfully!\n");
                }
                last;
            }

              if (@ARGV == 2 && $ARGV[1] eq 'delete') {
                my $name = shift(@ARGV);
                if (delete_user($name)) {
                    print("User removed successfully!\n");
                }
                else {
                    print("No user $name.\n");
                }
                last;
            }
    }
}
main();