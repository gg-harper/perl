#!/usr/bin/perl

use strict;
use warnings;
use lib ".";

# use Tools;
use Database;


if (@ARGV == 3 && $ARGV[2] eq 'login') {
    my($name, $password) = @ARGV;
    if (v_login($name, $password)) {
        print("Welcome, $name!\n");
    }
    else {
        print("Wrong user or password!\n");
    }
}

if (@ARGV == 3 && $ARGV[2] eq 'add') {
    my ($name, $password) = @ARGV;
    if (add_user($name, $password)) {
        print("User added successfully!\n");
    }
}

if (@ARGV == 4 && $ARGV[3] eq 'update') {
    my ($name, $old_password, $new_password) = @ARGV;
    if (update_user($name, $old_password, $new_password)) {
        print("User info updated successfully!\n");
    }
}

    if (@ARGV == 2 && $ARGV[1] eq 'delete') {
    my $name = shift(@ARGV);
    if (delete_user($name)) {
        print("User removed successfully!\n");
    }
    else {
        print("No user $name.\n");
    }

   
}
if(@ARGV == 1) {
    print("234");
    get_connection();
}