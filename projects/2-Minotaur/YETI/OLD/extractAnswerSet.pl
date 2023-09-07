#!/usr/bin/perl -w

use strict;
use Getopt::Long;
use parseAnswerSet;

my $line;
my $type;

while ((($type,$line) = parseAnswerSet(\*STDIN)) && ($type ne "End")) {
  if ($type eq "Answer Set") { 
      $_ = $line;
      while (/at\(([^\)]+)\)/g) {
	print "at($1).\n";
      }
  }
}
