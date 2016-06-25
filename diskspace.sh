#script to write names of directories in backed-up file and their disk space requirements

du -h -all $backdir | sort -n > log.txt
echo $'\n' >> log.txt
