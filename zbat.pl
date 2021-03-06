#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

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

system "perl ganalytics.pl";

#foreach (@files) {
#	system "perl addads.pl $_";
#}

#open ( my $file, "<", "index.css" ) || die "index not found";
#my @lines = <$file>;
#close($file);

my $lines = read_file('index.css');

my @thirds = split( '.x1{', $lines );
my $newlines = join( '', $thirds[0], ".xff3{left:50px;}\n", ".xff4{left:360px;}\n", '.x1{', $thirds[1], ".xff3{left:50pt;}\n", ".xff4{left:360pt;}\n", '.x1{', $thirds[2] );

#pop @lines;

#push( @lines, ".xff3{left:50pt;}\n" );
#push( @lines, ".xff4{left:360pt;}\n" );
#push( @lines, "}\n" );

open( my $file, ">", "index.css" ) || die "File no found";
print $file $newlines;
close( $file );


foreach (@files) {

        open(my $file, "<", $_) || die "File not found";
        my @lines = <$file>;
        close($file);

	if ( index( $lines[0], 'ToC' ) != -1 ) {

        my @fileno = split( 'ToC', $lines[0] );

	my @divvy = split( '<div', $fileno[ 0 ] );
	my @slash = split( '/div>', $fileno[ 1 ] );

	my $lastDiv = pop @divvy;
	my $slashDiv = shift @slash;

	my $cleanup = join( '', join( '<div', @divvy), join( '/div>', @slash ) );

	my @thirds = split( '<div class=\"c x1 y1 w0 h2\">', $lines[0] );
	my $xog = 0 + @thirds;

	my $excerpt = join( '', '<div' , $lastDiv , 'ToC', $slashDiv, '/div>' );

#	print "EX: $excerpt\n";
	my @fixx = split( 'x', $excerpt );
#	print "PO: $fixx[1]\n";
	my @splitfixx = split( 'h', $fixx[ 1 ] );
#	print "PY: ";
#	print join('h', @splitfixx );
#	print "\n";

	shift @splitfixx;
	my $tempFixx = $fixx[ 0 ];
	shift @fixx;
	shift @fixx;

        my @filenor = split( 'index', $_ );
        my @fileno2 = split( '.page', $filenor[ 1 ] );

	my $excerpt2 = "";;

	if ( $fileno2[ 0 ] % 2 == 0 ) {
		$excerpt2 = join( '', $tempFixx , 'xff3 ' , join( 'h', @splitfixx ) , 'x' , join( 'x', @fixx ) );
#	print "EX2: $excerpt2\n";
	} else {
		$excerpt2 = join( '', $tempFixx , 'xff4 ' , join( 'h', @splitfixx ) , 'x' , join( 'x', @fixx ) );
#	print "EX2: $excerpt2\n";
	}


	if ( $xog == 2 )
	{
		my $finished = join( '', join( '<div', @divvy), $excerpt2, join( '/div>', @slash) );				
#		print "FI : $finished\n";
#		print "LI : $lines[0]\n";
        	open( my $zfile, ">", $_) || die "File no found";
        	print $zfile $finished;
		if ( $lines[1] )
{
#		print "LI1 : $lines[1]\n";
		print $zfile $lines[1];
}
		if ( $lines[2] )
{
#		print "LI2 : $lines[2]\n";
		print $zfile $lines[2];
}
        	close( $zfile );	
	} else 
	{
                my $excerpted = join( '', join( '<div', @divvy), join( '/div>', @slash) );
		my @newThirds = split( '<div class=\"c x1 y1 w0 h2\">', $excerpted );
		my $finished = join( '', $newThirds[0], '<div class=\"c x1 y1 w0 h2\">', $newThirds[1], '<div class=\"c x1 y1 w0 h2\">', $excerpt2, $newThirds[2] );
                open( my $zfile, ">", $_) || die "File no found";
                print $zfile $finished;
                if ( $lines[1] )
{
 #               print "LI1 : $lines[1]\n";
                print $zfile $lines[1];
}
                if ( $lines[2] )
{
  #              print "LI2 : $lines[2]\n";
                print $zfile $lines[2];
}
                close( $zfile );
	}

	}
}
