#!/usr/bin/perl

use strict;
use warnings;

my ($adSize, $randAd, $adFiles);
#print $adSize . $randAd . $adFiles;

foreach( @ARGV ){

my @fileno = split( 'index', $_ );
my @fileno2 = split( '.page', $fileno[ 1 ] );
my $isEven = ($fileno2[ 0 ] % 2 == 0);

print "file: $_\n";
open(my $file, "<", $_) || die "File not found";
my @lines = <$file>;
close($file);

my $count = 0;
while ( $lines[0] =~ /<\/div>/g) { $count++ }
print "num divs: $count\n";

my @sps;

if ( $count < 4 )
{
	@sps = split( '</div><div class=\"pi\"', $lines[ 0 ] );
} else {
	@sps = split( '</div></div><div class=\"pi\"', $lines[ 0 ] );
}

my @out;

push( @out, $sps[ 0 ] );

#insert ad code
my @adssofar;
my $repeated = 1;
my $adData;
my @adchunks;

push( @out, "<table bgcolor=\"#939393\" border=\"0\" " );

if ( $isEven ) {
push( @out, "align=\"right\" " );
}
push( @out, " style=\"margin: 0px -3px 0px -5px\" cellpadding=\"0\" cellspacing=\"0\"><tr><td>" );

my $ad1 = ad( "160x600" );
push( @out, "<a href=\"http://www.dpbolvw.net/click-8524921-12588112\" target=\"_top\">" );
push( @out, "<img src=\"http://www.ftjcfx.com/image-8524921-12588112\" width=\"160\" height=\"600\" alt=\"\" border=\"0\" ");

if ( $isEven ) {
push( @out, "align=\"right\" " );
} else {
push( @out, "style=\"margin: -4px 0px\" " );
}

my $ad2 = ad( "120x600" );

push( @out, "></a>");
push( @out, "</td><td>");

$repeated = 1;
while ( $repeated == 1 ) {
	$adData = ad( "160x600" );
	$repeated = 0;

	foreach ( @adssofar )
	{
		if ( $_ eq $adData )
		{
		        print "MATCH!\n";
			$repeated = 1;
		}
	}

	if ( $repeated == 0 ) {
		push( @adssofar, $adData );
	}
}

push( @out, "</td></tr><tr><td>" );

$repeated = 1;
while ( $repeated == 1 ) {
	$adData = ad( "160x600" );
	$repeated = 0;

	foreach ( @adssofar )
	{
		if ( $_ eq $adData )
		{
		        print "MATCH!\n";
			$repeated = 1;
		}
	}

	if ( $repeated == 0 ) {
		push( @adssofar, $adData );
	}
}

if ( $isEven ) {
	@adchunks = split( 'width=', $adData );
	my $firstchunk = shift @adchunks;
	$adData = join( '', $firstchunk, 'align="right" ', 'width=', join( 'width=', @adchunks ) );
}
#print "ad data 1: $adData\n";
push( @out, $adData );
push( @out, "</td><td>" );

$repeated = 1;
while ( $repeated == 1 ) {
	$adData = ad( "160x600" );
	$repeated = 0;

	foreach ( @adssofar )
	{
		if ( $_ eq $adData )
		{
		        print "MATCH!\n";
			$repeated = 1;
		}
	}

	if ( $repeated == 0 ) {
		push( @adssofar, $adData );
	}
}

if ( $isEven ) {
	@adchunks = split( 'width=', $adData );
	my $firstchunk = shift @adchunks;
	$adData = join( '', $firstchunk, 'align="right" ', 'width=', join( 'width=', @adchunks ) );
}
#print "ad data 2: $adData\n";

push( @out, $adData );
push( @out, "</td></tr></table>" );

if ( $count < 4 )
{
	push( @out, '</div><div class="pi"' );
} else {
	push( @out, '</div></div><div class="pi"' );
}

push( @out, $sps[ 1 ] );

open(my $fileh, ">", $_) || die "File not found";
print $fileh "@out";
close $fileh;

}


sub ad {
	my ($adSize) = @_;
	print "Ad Size: $adSize, ";
	
	my (@adFiles) = (<*.$adSize>);
	my $randno = (rand @adFiles);
	$randAd = $adFiles[rand @adFiles];

	print "Ad File: $randAd\n";

	open( my $ad, '<', $randAd );
	my $adData = <$ad>;

	chomp( $adData );

	close( $ad );

	my @killnewlines = split( '\n', $adData );
	$adData = join( '' , @killnewlines );

	return $adData;
}
