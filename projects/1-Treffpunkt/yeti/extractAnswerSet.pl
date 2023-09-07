#!/usr/bin/perl -w

use strict;
use Getopt::Long;
use parseAnswerSet;

my $line;
my $type;

while ((($type,$line) = parseAnswerSet(\*STDIN)) && ($type ne "End")) {
  if ($type eq "Answer Set") { 
      $_ = $line;
      while (/link\(([^\)]+)\)/g) {
	print "link($1).\n";
      }
  }
}