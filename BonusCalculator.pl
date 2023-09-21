#!/usr/bin/perl
#

#
use strict;
use warnings;

my $amount = _ask_for_bonus_amount();
my @statistics = _read_from_file( 'Statistic.txt' );
my %bonuses =_calculate_bonuses( $amount, @statistics );
_write_to_file( \%bonuses );

sub _ask_for_bonus_amount {
	print("Enter overall bonus amount: \n");
	my $bonus_amount = <STDIN>;
	return $bonus_amount;
}


sub _read_from_file {
	my $filename = shift;
	my @statistics;
	open( my $hREAD_FILE, '<', "$filename" );
	while( my $input_line = <$hREAD_FILE> ) {
		push( @statistics, $input_line ); 
	}
	return @statistics;
}

sub _calculate_bonuses {
	my $overall_amount = shift;
	my @employees = @_;
	my %bonuses;
	my $overall_percentage = 0;
	for my $employee ( @employees ) {
		my ( $name, $tasks, $failed ) = split( '\^', $employee );
		if( $tasks - $failed >= 85 ) {
			$overall_percentage += $tasks - $failed;
		}
	}
	for my $employee ( @employees ) {
		my ( $name, $tasks, $failed ) = split( '\^', $employee );
		my $percent = $tasks - $failed;
		my $bonus;
		if( $percent >= 85 ) {
			$bonus = sprintf( int( ( $percent / $overall_percentage ) * 100000 * 100 ) / 100);
		} else {
			$bonus = ':)';
		}
		$bonuses{$name} = $bonus; 
		printf( "%s - %s\n", $name, $bonuses{$name});
	}	
	return %bonuses;
}

sub _write_to_file {
	my $bonuses = shift;
	my $counter = %{$bonuses};

	open ( my $hWRITE_FILE, '>', 'Output.txt' );
	while( my ( $employee, $bonus) = each( %{$bonuses} ) ) {
		if( $bonus eq ':)' ) {
			print( $hWRITE_FILE "$employee^!\n");
		} else {
			print( $hWRITE_FILE "$employee^$bonus\n" );
	
		}
	}
	close( $hWRITE_FILE );
}

