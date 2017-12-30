#!/usr/bin/perl

use strict;
use warnings;


foreach( @ARGV ){


print "file: $_\n";
open(my $file, "<", $_) || die "File not found";
my @lines = <$file>;
close($file);

my @sps = split( '<span class=\"ff2', $lines[ 0 ] );

foreach (@sps) {

	my @erg = split( '>', $_ );
   	print "lin: $erg[-1]\n";
}

my @indices;
my $char = '<span class="ff2';
my $offset = 0;
my $result = index($lines[0],$char,$offset);
print ("\n");
  while ($result != -1) {

#    print "Found $char at $result\n";
	push @indices, $result - 13;

    $offset = $result + 1;
    $result = index($lines[0], $char, $offset);

  }

print "Indices: @indices\n";

my @newIndices;
my @newValues;
my @oldLengths;

foreach (@indices) {
	my $xn = substr( $lines[0], $_, 13 );
#	print $xn;
#	print(" ");
	my $xr = substr( $lines[0], $_, 13 );
	$xr =~ s/[^0-9]//g;
	my $ni = index( $xn, $xr );
#	print ("$xr ");
#	print ( index( $xn, $xr ) );
	push( @newIndices, $_ + $ni );
#	print (" $_ \n");
}


foreach (@newIndices)
{
	print ( "$_ " );
	my $xn = substr( $lines[0], $_, 13 );
	print ( "$xn " );
	$xn =~ s/[^0-9]//g;
	print $xn;
	print(" ");
	print length $xn;
	print("L ");
	push( @oldLengths, length $xn );
	print $xn + 16;
	print(" ");
	$xn = lc(sprintf( "<a href=\"index.html#pf%X\">%d</a>", $xn + 16, $xn ));
	print $xn;
	push( @newValues, $xn );
	print ("\n");
}

my @rIndices = reverse( @newIndices );
my @rLengths = reverse( @oldLengths );
my @rValues = reverse( @newValues );

for (my $i = 0; $i < scalar( @rIndices ); $i++) {
	substr( $lines[0], $rIndices[ $i ], $rLengths[ $i ] ) = $rValues[ $i ];
}

#print $lines[0];

open(my $fileh, ">", $_) || die "File not found";
print $fileh "$lines[0]";
close $fileh;

}

