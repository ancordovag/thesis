#!/bin/bash

if [ ! -f group/meeting.lp ]
then
	echo "failure (file not found meeting.lp)" >&2;
	exit -1;
fi

if [ ! -f $1 ]
then
    	echo "failure (file not found $1)" >&2;
	exit -1;
fi;

/home/wv/bin/linux/32/clingo $1 group/meeting.lp 2>&1 | perl ./extractAnswerSet.pl > as.lp; 
if [ ! -s as.lp ] && [ $2 == "SAT" ]
then
	cat as.lp >&2;
	echo "???" >&2;
 	echo "Warning: no output predicates link/4." >&2;
fi;	

RESULT=$(/home/wv/bin/linux/32/clingo -q $1 encoding.lp as.lp 2>&1);

if (echo $RESULT | grep "Models : 1" > /dev/null) && [ $2 == "SAT" ]; then
	echo "successful";
elif (echo $RESULT | grep "Models : 0" > /dev/null) && [ $2 == "UNSAT" ]; then
	echo "successful";
else
	echo "failure" >&2;
fi

rm -f as.lp;
