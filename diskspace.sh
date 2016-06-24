#script to write names of directories in backed-up file and their disk space requirements

du -h $backdir | sort -n
