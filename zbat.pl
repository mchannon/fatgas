#!/usr/bin/perl

use strict;
use warnings;

system "pdf2htmlEX /Users/jrrr/Desktop/index.pdf  --zoom 2 --embed cfi --split-pages 1 -l 147";

my @files = glob("*.page");
foreach my $file(@files) {

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

