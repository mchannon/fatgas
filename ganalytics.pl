#!/usr/bin/perl

use strict;
use warnings;

open(my $file, "<", 'index.html') || die "File not found";
my @lines = <$file>;
close($file);

open(my $gfile, "<", 'gana.html') || die "File not found";
my @gcode = <$gfile>;
close($gfile);

open(my $fileh, ">", 'index.html') || die "File not found";

my @firsthalf;

for ( my $ix = 0; $ix < 10; $ix++ )
{
	push @firsthalf, shift @lines;
}

print $fileh "@firsthalf";
print $fileh "@gcode";
print $fileh "@lines";
close $fileh;
