#!/usr/bin/perl
#
#
#
print("This is calculator! Enter expression to calculate, one symbol at a time: \n");

my @input_list;
my $result = 0;

while(1) {
	print("Enter next symbol: \n");
	my $input = <STDIN>;
	chomp($input);
	if($input eq '=') {
		system('clear');
		#_print_expression();
		last;
	}
	if(scalar(@input_list) == 0) {
		if($input !~ /\d+/) {
			print("Start with digit, please!\n");
			next;
		}
		push(@input_list, $input);
		$result = $input;
		next;
	}
	if(!_check_symbol($input, @input_list)) {
		print("Wrong symbol!\n");
		next;
	}
	push(@input_list, $input);
	
	if (_is_operator($input)) {
		next;
	}
	if(!_check_division_by_zero(@input_list)) {
		pop(@input_list);
		next;
	}	
	$result = _calculate(@input_list, $result);
	
}


sub _is_operator {
	my $symbol = shift;
	if($symbol =~ /[\+\*\/-]/) {
		return 1;
	}
	print("Is not operator\n");
	return 0;
}


sub _check_symbol {
	my $symbol = pop;
	my @previous_symbol = pop;
	
	if($symbol !~ /[\d+\+\/\*-]/) {
		return 0;
	}
	if(($symbol =~ /\d+/ && $previous_symbol =~ /\d+/)
		|| ($symbol =~ /[\+\/\*-]/ && $previous_symbol =~ /[\+\/\*-]/)) {
		return 0;
	}
	return 1;
}
sub _check_division_by_zero {
	my $operand = pop;
	my $operator = pop;
	if($operand == 0 && $operator eq '/') {
		print("Division by 0 is restricted!\n");
		return 0;
	}
	return 1;
}
sub _calculate {
	my $result = pop;
	my $operand = pop;
	my $operator = pop;
	if($operator eq '+') {
		$result += $operand;
	} elsif($operator eq '-'){
		$result -= $operand;
	} elsif($operator eq '*') {
		$result *= $operand;
	} elsif($operator eq '/') {
		$result /= $operand;
	} else {
		print("Wrong operator!\n");
	}
	print(" = $result\n");
	return $result;
}
sub _print_expression {
	my @to_print;
	my $first_operand = shift;
	my $first_operator = shift;
	my $second_operand = shift;
	my @expression = @_;
	
	if(_is_operator(pop(@_))) {
		pop(@expression);
	}

	my $next_operator;
	
	for $element (@expression) {
		#		if(!_is_operator($element)) {
			#push(@to_print, $element);	
			#		}
		if(!_is_operator_less_or_same_pri($element)) {
			push(@to_print, '(');
			push(@to_print, $first_operand);
			push(@to_print, $operator);
			push(@to_print, $second_operand);
			push(@to_print, ')');
		}
		$first_operand = $second_operand;
		$first_operator = $element;
		

	}
}

sub _is_operator_less_or_same_pri {
	my $first_operator = shift;
	my $second_operator = shift;
	if($first_operator =~ /[\/\*]/) {
		return 1;
	}
	if($first_operator =~ /[\+-]/ && $second_operator =~ /[\+-]/) {
		return 1;
	}
	return 0;
}
	


