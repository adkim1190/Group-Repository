diff -bqr $1 $recdir >> log.txt
mv log.txt $backdir

#-b: ignore whitespace
#-q: only tell whether files differ
#diff
