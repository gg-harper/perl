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
#	_calculate();
	#if(!$result = _action(@input_list, $result)) {
#		pop(@input_list);
#		next;
#	}
	$result = _action(@input_list, $result);
}


sub _is_operator {
#	print("Is operator?\n");
	my $symbol = shift;
	if($symbol =~ /[\+\*\/-]/) {
#		print("$symbol is operator\n");
		return 1;
	}
	print("Is not operator\n");
	return 0;
}


sub _check_symbol {
#	print("Check symbol...\n");
	my $symbol = pop(@_);
	my @previous_symbol = pop(@_);
	
	if($symbol !~ /[\d+\+\/\*-]/) {
		return 0;
	}
	if(($symbol =~ /\d+/ && $previous_symbol =~ /\d+/)
		|| ($symbol =~ /[\+\/\*-]/ && $previous_symbol =~ /[\+\/\*-]/)) {
		return 0;
	}
#	print("Check OK\n");
	return 1;
}

sub _action {
#	print("Action...\n");
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
		if($operand == 0) {
			print("Division by 0 restricted!\n");
			return 0;
		}
		$result /= $operand;
	} else {
		print("Wrong operator!\n");
		return 0;
	}
	print(" = $result\n");
	return $result;
}

