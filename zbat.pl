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

open ( my $file, "<", "index.css" ) || die "index not found";
my @lines = <$file>;
close($file);

pop @lines;

push( @lines, ".xue{left:22pt;}\n" );
push( @lines, ".xuo{left:480pt;}\n" );
push( @lines, "}\n" );

open( $file, ">", "index.css" ) || die "File no found";
print $file @lines;
close( $file );


foreach (@files) {

        open(my $file, "<", $_) || die "File not found";
        my @lines = <$file>;
        close($file);

        my @fileno = split( 'ToC', $lines[0] );

	my @divvy = split( '<div', $fileno[ 0 ] );
	my @slash = split( '/div>', $fileno[ 1 ] );

	my $lastDiv = pop @divvy;
	my $slashDiv = shift @slash;

	my $cleanup = join( '', join( '<div', @divvy), join( '/div>', @slash ) );

	my @thirds = split( '<div class=\"c x1 y1 w0 h2\">', $lines[0] );
	my $xog = 0 + @thirds;

	my $excerpt = join( '', '<div' , $lastDiv , 'ToC', $slashDiv, '/div>' );

	print "EX: $excerpt\n";
	my @fixx = split( 'x', $excerpt );
	print "PO: $fixx[1]\n";
	my @splitfixx = split( 'h', $fixx[ 1 ] );
	print "PY: ";
	print join('h', @splitfixx );
	print "\n";

	shift @splitfixx;
	my $tempFixx = $fixx[ 0 ];
	shift @fixx;
	shift @fixx;


	my $excerpt2 = join( '', $tempFixx , 'xue ' , join( 'h', @splitfixx ) , 'x' , join( 'x', @fixx ) );
	print "EX2: $excerpt2\n";

	if ( $xog == 2 )
	{
		my $finished = join( '', join( '<div', @divvy), $excerpt2, join( '/div>', @slash) );				
		print "FI : $finished\n";
		print "LI : $lines[0]\n";
        	open( my $zfile, ">", $_) || die "File no found";
        	print $zfile $finished;
        	close( $zfile );	
	} else 
	{


	}
}
