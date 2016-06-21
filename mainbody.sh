#!/bin/bash

#Makes sure directory to be backed up exists
if [ -d $1 ];
	then
	return;
	fi

rm myJob*
mkdir ~/Backups/
mkdir ~/Backups/$1/

#Wrap submition task

echo "#!/bin/bash
#MSUB -N myJob
#MSUB -A b1011
#MSUB -q ligo
#MSUB -l walltime=00:00:00:20
#MSUB -l nodes=1:ppn=1
#MSUB -j oe

cd \$PBS_O_WORKDIR

#Finds recent backup to use in diff
lastback=~/Backups/$1/$(ls -t ~/Backups/$1 | head -1)

source log.sh

cp $1 ~/Backups/$1/$(date +%F_%H.%M.%S)

source diskspace.sh" > submit;

msub submit;
rm submit;


#Periodically checks for new log file to find compute time

while [ submit -nt myJob* ];
	do
	sleep 5
	done

time=`cat myJob* | grep -Eo 'cput=.{0,8}' | tr -d 'cput='


echo "Backup completed"
echo "cpu time:"$time


#Thought we should leave log file in backup folder
mv myJob* ~/Backups/$1/$(ls -t | head -1)
