#!/usr/bin/perl

use strict;
use warnings;

system "pdf2htmlEX /Users/jrrr/Desktop/index.pdf  --zoom 2 --embed cfi --split-pages 1 -l 147";

my @files = glob("*.page");
foreach (@files) {

	open(my $file, "<", $_) || die "File not found";
	my @lines = <$file>;
	close($file);

	my @fileno = split( 'index', $_ );
	my @fileno2 = split( '.page', $fileno[ 1 ] );
	my $pgno = int($fileno2[ 0 ] / 50) + 3;

	my @newlines;
	foreach( @lines ) {
		$_ =~ s/  ª/<A HREF="index.html#pf$pgno">ToC<\/A>/g;
		$_ =~ s/ª  /<A HREF="index.html#pf$pgno">ToC<\/A>/g;
		$_ =~ s/ª/<A HREF="index.html#pf$pgno">ToC<\/A>/g;
		push (@newlines, $_ );
	}

	open( $file, ">", $_) || die "File no found";
	print $file @newlines;
	close( $file );
}

system "perl numberize.pl index3.page";
system "perl numberize.pl index4.page";
system "perl numberize.pl index5.page";
system "perl numberize.pl index6.page";
system "perl numberize.pl index7.page";
system "perl numberize.pl index8.page";
system "perl numberize.pl index9.page";
system "perl numberize.pl index10.page";
system "perl numberize.pl index11.page";
system "perl numberize.pl index12.page";
system "perl numberize.pl index13.page";
system "perl numberize.pl index14.page";
system "perl numberize.pl index15.page";

foreach (@files) {
	system "perl addads.pl $_";
}
