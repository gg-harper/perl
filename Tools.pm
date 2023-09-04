package Tools;

use Exporter qw(import);
@EXPORT = qw(v_login read_user_list add_user delete_user update_user);

sub v_login {
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

sub add_user {
    (my $name, my $password) = @_; 

    if(v_login($name, $password)) {
        print("User already exists!\n");
        return 0;
    }
    else {
       open (my $hWRITE_FILE, '>>', "users") or die("File not found"); 
       print ($hWRITE_FILE "\n$name=$password");
       close($hWRITE_FILE);
       return 1;
    }
    close($hWRITE_FILE);
}

sub delete_user {
    my $user_name = $_[0];
    my $is_deleted = 0;

    open (my $hWRITE_FILE, '>', "_users");
    open (my $hREAD_FILE, '<', "users") or die("File not found");

    if(!check_user($user_name)) {
        return 0;
    }
    while(my $user = <$hREAD_FILE>) {
        if ($user =~ /^\n$/) {
            next;
        }
        if($user =~ /$user_name/) {
            $is_deleted = 1;
            next;
        }
        print($hWRITE_FILE $user);
    }
    close($hWRITE_FILE);
    close($hREAD_FILE);
    
    rename("_users", "users");
    return $is_deleted;
}

sub update_user {
     (my $name, my $password) = @_;

    if(!check_user($name, $password)) {
        print("No such user!\n");
        return 0;
    }
    else {
       my $success = 0;
       (my $name, my $password) = @_;
        if ($success = delete_user($name)) {
            $success = add_user($name, $password);
        } else {
            return 0;
        }
        
       return $success;
    }
}

sub read_user_list {
    open (my $hREAD_FILE, '<', "users") or die("File not found");
    
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

sub check_user {
    my $name = shift(@_);
    my %users = read_user_list();
    while((my $user, my $pass) = each(%users)) {
        chomp($user, $pass);
        if($user eq $name) {
            return 1;
        }
    }
    return 0;

}