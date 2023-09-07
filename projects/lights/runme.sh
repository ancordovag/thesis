#!/bin/bash

enc1="lights.lp"
enc2="lights-double.lp"
enc3="lights-triple.lp"

echo "running ...";
for file in test*.lp; do
  echo "=======================================";
  echo "$file";
  echo "=======================================";
  echo "";
  echo "gringo $enc1 $file | clasp 0 --stats -q --solution-recording";
  gringo $enc1 $file | clasp 0 --stats -q --solution-recording
#  echo "";
  echo "---------------------------------------";
  echo "";
  echo "gringo $enc2 $file | clasp 0 --stats -q --solution-recording";
  gringo $enc2 $file | clasp 0 --stats -q --solution-recording
#   echo "";
  echo "---------------------------------------";
  echo "";
  echo "gringo $enc3 $file | clasp 0 --stats -q --solution-recording";
  gringo $enc3 $file | clasp 0 --stats -q --solution-recording
#   echo "";
  echo "---------------------------------------";
  echo "";
  echo "gringo $enc1 $file | clasp 0 --stats -q --solution-recording --initial-lookahead=0";
  gringo $enc3 $file | clasp 0 --stats -q --solution-recording --initial-lookahead=0
done
echo "---------------------------------------";
echo "... done"
