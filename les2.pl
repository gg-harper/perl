#!/usr/bin/perl

use strict;
use warnings;
use lib ".";

use Tools;

# sub read_file() {
#     open (my $hREAD_FILE, '<', "users");
#     my %users = ();
#     while(my $input_line = <$hREAD_FILE>) {
#         $input_line = parse_line($input_line);
#         my ($user_name, $passwd) = split('=', $input_line);
#         chomp($user_name, $passwd);
#         if($user_name eq '' || $passwd eq '' || $input_line =~ /^#/) {
#             next;
#         }
#         $users{$user_name} = $passwd; 
#     }

#     close $hREAD_FILE;
#     return %users;
# }

# sub parse_line() {
#     my $line = $_[0];
#     $line =~ s/^\s*//;
#     $line =~ s/\s*=\s*/=/;
#     $line =~ s/\s*$//;
#     return $line;
# }

if (@ARGV == 3 && $ARGV[2] eq 'login') {
     (my $name, my $password) = @ARGV;
    if (vlogin($name, $password)) {
        print("Welcome, $name!\n");
    }
    else {
        print("Wrong user or password!\n");
    }

    # (my $name, my $password) = @ARGV;
    # my $is_present = 0;

    # while((my $user, my $pass) = each(%users)) {
    #     chomp($user, $pass);
    #     if(($user eq $name) && ($pass eq $password)) {
    #         print("Hi, $name!\n");
    #         $is_present = 1;
    #         last;
    #     }
    # }
    #  if (!$is_present) {
    #     print("Wrong user or password!\n");
    # }
}
# else {
#     print("Enter login and password!\n");
# }