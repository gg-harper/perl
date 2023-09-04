package Tools;
use Exporter(import);
@EXPORT = qw(v_login delete_user add_user update_user);

sub v_login {
    my($name, $password) = @_;
    my %users = _read_user_list();
    if ($users{$name} == $password) {
        return 1;
    }
    return 0;
}

sub add_user {
    my($name, $password) = @_;

    if(_check_user($name)) {
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
    my %users = _read_user_list();
    if(!_check_user($user_name)) {
        return 0;
    }
    delete($users{$user_name});
    _write_to_file(\%users);
}

sub update_user {
     my($name, $old_password, $new_password) = @_;
     my %users = _read_user_list();

    if(!v_login($name, $old_password)) {
        print("No such user!\n");
        return 0;
    }
    else {
        $users{$name} = $new_password;
        _write_to_file(\%users);
       return 1;
    }
}

sub _read_user_list {
    open (my $hREAD_FILE, '<', "users") or die("File not found");
    
    my %users = ();
    while(my $input_line = <$hREAD_FILE>) {
        $input_line =~ s/\s//g;
        my ($user_name, $passwd) = split('=', $input_line);
        if($user_name eq '' || $passwd eq '' || $input_line =~ /^#/) {
            next;
        }
        $users{$user_name} = $passwd;    
    }
    close $hREAD_FILE;
    return %users;
}

sub _check_user {
    my $name = shift(@_);
    my %users = _read_user_list();
    if(exists($users{$name})) {
        return 1;
    }
    return 0;
}

sub _write_to_file {
    my $users = shift(@_);
    my $counter = %{$users};
    open (my $hWRITE_FILE, '>', "_users");
    while(my($user, $pass) = each(%{$users})) {
        print($hWRITE_FILE "$user=$pass");
        $counter--;
        if($counter == 0) {
            last;
        }
        print($hWRITE_FILE "\n");
    }
    close($hWRITE_FILE);
    rename("_users", "users");
}