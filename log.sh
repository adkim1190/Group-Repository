diff -bqr $1 $backdir | tee log.txt
mv log.txt $backdir

#-b: ignore whitespace
#-q: only tell whether files differ
#diff
