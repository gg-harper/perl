package Tools;

use Exporter qw(import);
@EXPORT = qw(vlogin read_user_list);

sub vlogin {
    (my $name, my $password) = @_;
    my %users = read_user_list();
    while((my $user, my $pass) = each(%users)) {
        chomp($user, $pass);
        if(($user eq $name) && ($pass eq $password)) {
            return 1;
        }
    }
    return 0;
}

sub read_user_list {
    open (my $hREAD_FILE, '<', "users");
    my %users = ();
    while(my $input_line = <$hREAD_FILE>) {
        $input_line = parse_line($input_line);
        my ($user_name, $passwd) = split('=', $input_line);
        chomp($user_name, $passwd);
        if($user_name eq '' || $passwd eq '' || $input_line =~ /^#/) {
            next;
        }
        $users{$user_name} = $passwd;  
        
    }

    close $hREAD_FILE;
    return %users;
}

sub parse_line() {
    my $line = $_[0];
    $line =~ s/^\s*//;
    $line =~ s/\s*=\s*/=/;
    $line =~ s/\s*$//;
    return $line;
}