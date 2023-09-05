package Database;

use Exporter(import);
@EXPORT = qw(get_connection);

use DBI;
use strict;

sub get_connection {
    my $driver = "Pg";
    my $database = "test_psb2";
    my $destination = "DBI:$driver:dbname = $database;host = 127.0.0.1;port = 5432";
    my $userid = "postgres";
    my $password = "postgres";

    my $dbh = DBI->connect($destination, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
    print("Success!");
    return 1;
}