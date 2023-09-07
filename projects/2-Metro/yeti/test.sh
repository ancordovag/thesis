#!/bin/bash

echo $1;

#clasp=/home/yeti/clasp-2.0.X;
clasp=clasp-2.0.5-internal-st;

if [ ! -f group/metro.lp ]
then
	echo "failure (file not found metro.lp)" >&2;
	exit -1;
fi

if [ ! -f $1 ]
then
    	echo "failure (file not found $1)" >&2;
	exit -1;
fi;

/home/wv/bin/linux/32/runsolver -M 128 -w /dev/null /home/wv/bin/linux/32/gringo $1 group/metro.lp 2>&1 > as.gr;
/home/wv/bin/linux/32/runsolver -M 128 -w /dev/null $clasp --quiet=1,1 --solution-recording as.gr | perl ./extractAnswerSet.pl 1> as.lp 2>/dev/null;
#/home/wv/bin/linux/32/runsolver -M 128 -w /dev/null $clasp --quiet=1,1 --solution-recording as.gr | perl ./extractAnswerSet.pl
if [ ! -s as.lp ] && [ $2 == "SAT" ]
then
	cat as.lp >&2;
	echo "???" >&2;
 	echo "Warning: no output predicates metro/2 or wires/4." >&2;
fi;	

#/home/wv/bin/linux/32/gringo encoding.lp as.lp $1 | $clasp --solution-recording --quiet=1,1   
RESULT=$(/home/wv/bin/linux/32/gringo encoding.lp as.lp $1 | $clasp --solution-recording --quiet=1,1 2>&1);

#echo $RESULT;
#echo $2;

if (echo $RESULT | grep "Models : 1" > /dev/null) && [ $2 == "SAT" ]; then
	echo "successful";
elif (echo $RESULT | grep "Models : 0" > /dev/null) && [ $2 == "UNSAT" ]; then
	echo "successful";
else
	echo "failure" >&2;
fi

rm -f as.lp;
rm -f as.gr;
