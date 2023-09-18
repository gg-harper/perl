#!/usr/bin/perl
use strict;
use warnings;

my $input_file_name = shift( @ARGV );
my $dict_name = 'dictionary';
my @words = _get_text( $input_file_name );
my @dictionary = _read_dictionary( $dict_name );
@words = _parse_text(@words);
my $count = scalar(@words);
print("Word count is: $count\n\n");
print("Repeated words are: \n");
_count_repeated_words( @words );
_check_obscenities( \@dictionary, \@words );

sub _get_text {
	my $filename = 'newsletter/'.shift;
	my @raw_text = _read_file($filename);
	my @text;
	for my $line( @raw_text ) {
		push( @text, split( ' ', $line ) );
	}
	return @text;
}
sub _parse_text {
	my @words = @_;
	my @output;
	my $previous_word;
	my $flag = 0;
	for ( my $i = 0; $i <= $#words; $i++) {
		if( $words[$i] =~ /\-$/ ) {
			$previous_word = $words[$i];
			$previous_word =~ s/\-//g;
			$flag = 1;
			next;
		}
		if( $flag ) {
			my $word = $previous_word . $words[$i];
			$flag = 0;
			push( @output, $word);
		} else {
			push( @output, $words[$i]);
		}
	}
	return @output;
}

sub _read_dictionary {
	my $filename = shift;
	my @dictionary = _read_file( $filename );
	my @output;
	for my $line( @dictionary ) {
		chomp($line);
		push( @output, lc( $line ) );
	}
	return @output;
}

sub _check_obscenities {
	my @dict = @{$_[0]};
	my @words = @{$_[1]};
	my %dict;
	my @isect;
	for my $element ( @dict ) {
		$dict{$element} = 0;
	}

	for my $element ( @words ) {
		if( exists( $dict{$element}) && $dict{$element} == 0 ) {
			$dict{$element} = 1;
			push( @isect, $element );
		}
	}
	print("Found following obcene words: @isect \n\n");
}

sub _read_file {
	my $filename = shift;
	my @raw_text;
	open( my $hREAD_FILE, '<', $filename);
	while (my $line = <$hREAD_FILE> ) {
		push( @raw_text, lc( $line ));
	}
	return @raw_text;
}

sub _count_repeated_words {
	my @words = @_;
	my %repeated_words; 
	for my $word( @words ) {
		$word =~ s/[^a-zA-Z0-9А-Яа-я\-]|['`’]s\b//g;
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
	print("\n");
}
