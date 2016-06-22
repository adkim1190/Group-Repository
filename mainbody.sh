#!/bin/bash
target=$1
dest='~/Backups/'${target%/}_`date +%F_%H.%M.%S`

#Checks to make sure everything is in place (throws weird errors sometimes)
if [ "$target" == "" ]; then
	echo "Choose proper directory to backup"
	return 
elif [ ! -d ~/Backups ]; then
	mkdir ~/Backups
elif [ ! -d $dest ]; then
	mkdir ${dest}
fi

#Wrap submition task
echo "#!/bin/bash" > submit.sh
echo "#MSUB -N backup_job" >> submit.sh
echo "#MSUB -A b1011" >> submit.sh
echo "#MSUB -q ligo" >> submit.sh
echo "#MSUB -l walltime=00:00:20:00" >> submit.sh
echo "#MSUB -l nodes=1:ppn=1" >> submit.sh
echo "#MSUB -j oe" >> submit.sh
echo "touch log.txt" >> submit.sh
echo "source log.sh" >> submit.sh
echo "cp -rv $1 $dest > log.txt" >> submit.sh
echo "source diskspace.sh $dest" >> submit.sh

#msub submit.sh
source submit.sh #for testing only
#Periodically checks for new log file to find compute time
#while [ ! -e backup_job* ]; do
#	sleep 5
#done
#
#time=`cat backup_job* | grep -Eo 'cput=.{0,8}' | tr -d 'cput='
#
#
#echo "Backup completed"
#echo "cpu time: $time"
#
#rm submit.sh
#rm log.txt
