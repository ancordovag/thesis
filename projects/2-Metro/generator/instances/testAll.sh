#!/bin/bash

for file in `find . -name "*.lp"`; do
	echo $file
	gringo $file ../metro.lp | clasp-2.0.5-internal-st 0 --quiet=1,1
done
