#!/usr/bin/perl
use strict;
use warnings;

my $input_file_name = shift( @ARGV );
my $dict_name = 'dictionary';
my @words = _read_input_file( $input_file_name );
my @dictionary = _read_dictionary( $dict_name );
print("Word count is: $#words\n");
print("\n");
print("Repeated words are: \n");
_count_repeated_words( @words );
print("\n");
_check_obscenities(\@dictionary, \@words);
print("\n");

sub _read_input_file {
	my $file_name = 'newsletter/'.shift;
	#	print($file_name);
	my @word_list;
	open( my $hREAD_FILE, '<', $file_name ) or die( 'File not found!' );
	for my $line( <$hREAD_FILE> ) {
		push( @word_list, split( ' ', $line ) );
	}
	close($hREAD_FILE);
	return @word_list;
}

sub _read_dictionary {

	my $file_name = shift;
	my @dictionary;
	open( my $hREAD_FILE, '<', $file_name ) or die( 'File not found!' );
	for my $line( <$hREAD_FILE> ) {
		chomp($line);
		push( @dictionary, $line );
	}
	close($hREAD_FILE);
	return @dictionary;
}
sub _check_obscenities {
	my @dict = @{$_[0]};
	my @words = @{$_[1]};
	my @result;
	for my $word( @dict ) {
		 push( @result, _uniq( grep( $_ eq $word, @words ) ) );	
	}
	print("Found following obcene words: @result\n");
}
sub _uniq {
	my %seen;
	return grep( { !$seen{$_}++ } @_);
}

sub _count_repeated_words {
	my @words = @_;
	my %repeated_words; 
	for my $word( @words ) {
		$word =~ s/[^a-zA-Z0-9А-Яа-я]|['`’]s\b//g;
		if( exists( $repeated_words{$word} ) ) {
			$repeated_words{$word} = $repeated_words{$word} + 1;
			
		} else {
			$repeated_words{$word} = 1;
		}
	}
	for my $word( reverse( sort { $repeated_words{$a} <=> $repeated_words{$b} } ( keys( %repeated_words ) ) ) ) {
		if( $repeated_words{$word} > 1 ) {
			print("$word - $repeated_words{$word}\n");
		}
	}	
}
