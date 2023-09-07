# $1: grid size
# /dev/stdin: facts file
# Call: clingo sudoku.lp examples/ex5.lp | tofacts.sh | paint.sh 9

size=$1
start=1
f=$$.tmp
sort -n /dev/stdin | sed -n 's/.*\([0-9][0-9]*\))\./\1/p' > $f

for ((i=1;i<=size;++i)); do 
    end=$((start+$size-1))
    sed -n ''$start','$end' p' $f | paste -d' ' -s 
    start=$((end+1))
done

rm $f

