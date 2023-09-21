#!/usr/bin/perl

print( eval( 2 * 2 ) );
#while(1) {
#	if( ) {
#	}
#
#
#}




sub _check_element {
	my $previous_element = shift;
	my $element = shift;

	if( $element =~ /^\d+$/ && $previous_element =~ /^/) {
		return false;
	}

}

sub _is_digit {
	my $element = shift;

	if( $element =~/^d+$/ ) {
		return true;
	}
	return false;
}

sub _is_operator {
	my $element = shift;

	if( $element =~/^\+\*-\/$/ ) {
		return true;
	}
	return false;
}

#sub _calculate {





