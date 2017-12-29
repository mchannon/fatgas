#!/usr/bin/perl

use strict;
use warnings;

system "pdf2htmlEX /Users/jrrr/Desktop/index.pdf  --zoom 2 --embed cfi --split-pages 1 -l 147";

my @files = glob("*.page");
foreach (@files) {

	open(my $file, "<", $_) || die "File not found";
	my @lines = <$file>;
	close($file);

	my @newlines;
	foreach( @lines ) {
		$_ =~ s/NON                          ª/NON                      <A HREF=\"index.html#pf3\">ToC<\/A>/g;
		push (@newlines, $_ );
	}

	open( my $file, ">", $_) || die "File no found";
	print $file @newlines;
	close( $file );
}

#system "sed -i '' 's/NON                          ª/NON                      <A HREF=\"index.html#pf3\">ToC<\/A>/' *.page";
#system "sed -i '' 's/ª  \ \ \ /<A HREF=\"index.html#pf3\">ToC<\/A>/' *.page";
#system "sed -i '' 's/ª/<A HREF=\"index.html#pf3\">ToC<\/A>/' *.page";

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

