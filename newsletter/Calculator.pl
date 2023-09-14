#!/usr/bin/perl
#
#
#
print("This is calculator! Enter expression to calculate, one symbol at a time: \n");

my @input_list;
my $result = 0;
my $flag = 1;
my $next_value = 2;
my $previous_operator = '*';
print( "Enter first value: \n" );
push( @input_list, '(' );
while( 1 ) {
	
	my $input = <STDIN>;
	chomp( $input );
	if( $input eq '=' ) {
		system( 'clear' );
		if ( $flag == 1 ) {
			shift( @input_list );
		}
		push( @input_list, '=' );
		push( @input_list, $result );
		print( "@input_list" );
		print( "\n" );
		last;
	}
	if( scalar( @input_list ) == 1 ) {
		if( !_is_digit( $input ) ) {
			print( "Start with digit, please!\n" );
			next;
		}
		push( @input_list, $input );
		$result = $input;	
		print( "Which arithmetic operation (+|-|*|/| = for finish) you require?\n" );
		next;
	}
	if( !_check_symbol( $input, @input_list ) ) {
		print( "Wrong symbol!\n" );
		#pop( @input_list );
		next;
	}
	
	if( _is_operator( $input ) ) {
		if( _is_previous_operator_less_pri( $previous_operator, $input ) ) {
			push( @input_list, ')' );	
			$flag = 0;
		}

		push( @input_list, $input );
		$previous_operator = $input;
		print( "Enter $next_value value: \n" );
		next;
	}
	push( @input_list, $input );
	if( !_check_division_by_zero( @input_list ) ) {
		pop( @input_list );
		next;
	}	
	$result = _calculate( $result, @input_list );
	print( "Which arithmetic operation (+|-|*|/| = for finish) you require?\n" );
	$next_value++;
}



sub _is_operator {
	my $symbol = shift;
	if( $symbol =~ /[\+\*\/-]/ ) {
		return 1;
	}
	return 0;
}
sub _is_digit {
	my $symbol = shift;
	if( $symbol =~ /^\d+$/ ) {
		return 1;
	}
	return 0;
} 


sub _check_symbol {
	my $symbol = shift;
	my @input_list = shift;
	my $previous_symbol = pop;
	
	if( !_is_digit( $symbol ) && !_is_operator( $symbol ) ) {
		return 0;
	}
	if( ( $symbol =~ /\d+/ && $previous_symbol =~ /\d+/ )

		|| ( $symbol =~ /[\+\/\*-]/ && $previous_symbol =~ /[\+\/\*-]/ ) ) {
		return 0;
	}
	return 1;
}
sub _check_division_by_zero {
	my @input_list = @_;
	my $operand = pop( @input_list );
	my $operator = pop( @input_list );
	if( $operand == 0 && $operator eq '/' ) {
		print( "Division by 0 is restricted!\n" );
		print( "Enter $nextValue value: \n" );
		return 0;
	}
	return 1;
}
sub _calculate {
	my $result = shift;
	my @input_list = @_;
	my $operand = pop( @input_list );
	my $operator = pop( @input_list );
	if( $operator eq '+' ) {
		$result += $operand;
	} elsif( $operator eq '-' ){
		$result -= $operand;
	} elsif( $operator eq '*' ) {
		$result *= $operand;
	} elsif( $operator eq '/' ) {
		$result /= $operand;
	} else {
		print( "Wrong operator!\n" );
	}
	print( "Pre-result = $result\n" );
	return $result;
}

sub _is_previous_operator_less_pri {
	my $previous_operator = shift;
	my $current_operator = shift;
	if( $previous_operator =~ /[\+-]/ && $current_operator =~ /[\*\/]/ ) {
		return 1;
	}
	return 0;
}
