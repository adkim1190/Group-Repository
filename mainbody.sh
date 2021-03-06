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

#recent backup
recdir=~/Backups/$1/$(ls -t ~/Backups/$1 | head -1)

#backed up to here
backdir=~/Backups/$1/$(date +%F_%H.%M.%S)

cp -r $1 \$backdir

source ~/Backupper/diskspace.sh \$backdir

source ~/Backupper/log.sh $1 \$recdir \$backdir

while [ `ls -d ~/Backups/$1/` -gt 5 ];
	do
	rm -r ~/Backups/$1/$(ls -t ~/Backups/$1 | tail -1)
	done" > submit;

msub submit;
rm submit;


#Periodically checks for new log file to find compute time

while [ ! -e myJob* ];
	do
	sleep 10
	done

time=$(cat myJob* | grep -Eo 'cput=.{0,8}' | tr -d 'cput=')


echo "Backup completed"
echo "cpu time: "$time


#Thought we should leave log file in backup folder
mv myJob* ~/Backups/$1/$(ls -t ~/Backups/$1 | head -1)
