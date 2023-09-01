#!/usr/bin/perl

use strict;
use warnings;

sub readFile() {
    open (my $hREAD_FILE, '<', "users");
    my %users = ();
    while(my $inputLine = <$hREAD_FILE>) {
        $inputLine = parseLine($inputLine);
        my ($user_name, $passwd) = split('=', $inputLine);
        chomp($user_name, $passwd);
        if($user_name eq '' || $passwd eq '' || $inputLine =~ /^#/) {
            next;
        }
        $users{$user_name} = $passwd; 
    }

    close $hREAD_FILE;
    return %users;
}

sub parseLine() {
    my $line = $_[0];
    $line =~ s/^\s*//;
    $line =~ s/\s*=\s*/=/;
    $line =~ s/\s*$//;
    return $line;
}

my %users = readFile();

if (@ARGV > 1) {

    (my $name, my $password) = @ARGV;
    my $isPresent = 0;

    while((my $user, my $pass) = each(%users)) {
        chomp($user, $pass);
        if(($user eq $name) && ($pass eq $password)) {
            print("Hi, $name!\n");
            $isPresent = 1;
            last;
        }
    }
     if (!$isPresent) {
        print("Wrong user or password!\n");
    }
}
else {
    print("Enter login and password!\n");
}