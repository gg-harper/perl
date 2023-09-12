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
print("Enter first value: \n");
push(@input_list, '(');
while(1) {
	
	my $input = <STDIN>;
	chomp($input);
	if($input eq '=') {
		system('clear');
		if ($flag == 1) {
			shift(@input_list);
		}
		push(@input_list, '=');
		print("@input_list");
		print("\n");
		last;
	}
	if(scalar(@input_list) == 1) {
		if($input !~ /^\d+$/) {
			print("Start with digit, please!\n");
			next;
		}
		push(@input_list, $input);
		$result = $input;	
		print("Which arithmetic operation (+|-|*|/| = for finish) you require?\n");
		next;
	}
	if(!_check_symbol($input, @input_list)) {
		print("Wrong symbol!\n");
		pop(@input_list);
		next;
	}
	
	if (_is_operator($input)) {
		if(_is_previous_operator_less_pri($previous_operator, $input)) {
			push(@input_list, ')');	
			$flag = 0;
			print("@input_list\n");
		}

		push(@input_list, $input);
		$previous_operator = $input;
		print("Enter $next_value value: \n");
		next;
	}
	push(@input_list, $input);
	if(!_check_division_by_zero(@input_list)) {
		pop(@input_list);
		next;
	}	
	$result = _calculate(@input_list, $result);
	print("Which arithmetic operation (+|-|*|/| = for finish) you require?\n");
	$next_value++;
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
		print("Enter $nextValue value: \n");
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
	print("Pre-result = $result\n");
	return $result;
}

sub _is_previous_operator_less_pri {
	my $previous_operator = shift;
	my $current_operator = shift;
	if($previous_operator =~ /[\+-]/ && $current_operator =~ /[\*\/]/) {
		return 1;
	}
	return 0;
}
