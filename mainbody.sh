#!/bin/bash

#Makes sure directory to be backed up exists
if [ ! -d $1 ]; then
	echo "Choose a directory"
	return
elif [ -e myJob* ]; then
	rm myJob*
elif [ ! -d ~/Backups ]; then
	mkdir ~/Backups
elif [ ! -d ~/Backups/$1 ]; then
        mkdir ~/Backups/$1
fi


#Wrap submition task

echo "#!/bin/bash
#MSUB -N myJob
#MSUB -A b1011
#MSUB -q ligo
#MSUB -l walltime=00:00:05:00
#MSUB -l nodes=1:ppn=1
#MSUB -j oe

cd \$PBS_O_WORKDIR

#backed up to here
backdir=~/Backups/$1/$(date +%F_%H.%M.%S)

cp -r $1 $backdir

source diskspace.sh "$backdir"

source log.sh "$1" "$backdir"" > submit;

msub submit;
rm submit;


#Periodically checks for new log file to find compute time

while [ ! -e myJob* ];
	do
	sleep 10
	done

time=`cat myJob* | grep -Eo 'cput=.{0,8}' | tr -d 'cput='


echo "Backup completed"
echo "cpu time:"$time


#Thought we should leave log file in backup folder
mv myJob* $backdir
