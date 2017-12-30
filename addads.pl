#!/usr/bin/perl

use strict;
use warnings;


foreach( @ARGV ){

my @fileno = split( 'index', $_ );
my @fileno2 = split( '.page', $fileno[ 1 ] );

print "file: $_\n";
open(my $file, "<", $_) || die "File not found";
my @lines = <$file>;
close($file);

my @sps = split( '</div><div class=\"pi\"', $lines[ 0 ] );

my @out;

push( @out, $sps[ 0 ] );

#insert ad code
push( @out, "<table bgcolor=\"#939393\" border=\"0\" " );

if ( $fileno2[ 0 ] % 2 == 0 ) {
push( @out, "align=\"right\" " );
}
push( @out, " style=\"margin: 0px -3px 0px -5px\" cellpadding=\"0\" cellspacing=\"0\"><tr><td>" );
push( @out, "<a href=\"http://www.dpbolvw.net/click-8524921-12588112\" target=\"_top\">" );
push( @out, "<img src=\"http://www.ftjcfx.com/image-8524921-12588112\" width=\"160\" height=\"600\" alt=\"\" border=\"0\" ");
if ( $fileno2[ 0 ] % 2 == 0 ) {
push( @out, "align=\"right\" " );
} else {
push( @out, "style=\"margin: -4px 0px\" " );
}
push( @out, "></a><a href=\"http://www.kqzyfj.com/click-8524921-10833132\" target=\"_top\"><img src=\"http://www.ftjcfx.com/image-8524921-10833132\" width=\"160\" height=\"600\" alt=\"\" border=\"0\" " );
if ( $fileno2[ 0 ] % 2 == 0 ) {
push( @out, "align=\"right\" " );
} else {
push( @out, "style=\"margin: -4px 0px\" " );
}
push( @out, "\n/></a></td></tr><tr><td>" );

open( my $ad, '<', 'ca4a.160x600' );
my $adData = <$ad>;

push( @out, $adData );

close( $ad );


#push( @out, "<a href=\"http://www.dpbolvw.net/click-8524921-10833150\" target=\"_top\">" );
#push( @out, "<img src=\"http://www.lduhtrp.net/image-8524921-10833150\" width=\"160\" height=\"600\" alt=\"\" border=\"0\"" );
if ( $fileno2[ 0 ] % 2 == 0 ) {
push( @out, "align=\"right\" " );
}
push( @out, "\n/></a><a href=\"http://www.tkqlhce.com/click-8524921-10829166\" target=\"_top\"><img src=\"http://www.awltovhc.com/image-8524921-10829166\" width=\"120\" height=\"600\" alt=\"Get results and increase sales with GetResponse\" border=\"0\" ");
if ( $fileno2[ 0 ] % 2 == 0 ) {
push( @out, "align=\"right\" " );
}
push( @out, "/></a></td></tr></table>" );


push( @out, '</div><div class="pi"' );
push( @out, $sps[ 1 ] );


open(my $fileh, ">", $_) || die "File not found";
print $fileh "@out";
close $fileh;

}

