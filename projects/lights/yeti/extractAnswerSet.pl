#!/usr/bin/perl -w

use strict;
use Getopt::Long;
use parseAnswerSet;

my $line;
my $type;

while ((($type,$line) = parseAnswerSet(\*STDIN)) && ($type ne "End")) {
  if ($type eq "Answer Set") { 
      $_ = $line;
      while (/light\(([^\)]+)\)/g) {
	print "light($1).\n";
      }
  }
}