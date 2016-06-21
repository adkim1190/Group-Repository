
#!/bin/bash

rm myJob*

#Wraps submition task

echo "#!/bin/bash
#MSUB -N ajob
#MSUB -A b1011
#MSUB -q ligo
#MSUB -l walltime=00:00:00:20
#MSUB -l nodes=1:ppn=1
#MSUB -j oe

cd \$PBS_O_WORKDIR

#Finds recent backup to use in dif
Lastback='ls -t ~/Backups/$1 | head -1

log()
diskspace() > submit;

msub submit;
rm submit;


#Periodically checks for new log file to find compute time

while [ submit -nt myJob* ];
	do
	sleep 5
	done

time=`cat myJob* | grep -Eo 'cput=.{0,8}' | tr -d 'cput='


echo "Backup completed"
echo "cpu time:", time


#cd .. | if [ -a FILE ] == False;
#	then mkdir backups	
#	else then a
#	fi

#cp $0  

#Thought we should leave log file in backup folder
mv myJob* ~/Backups/$1/$(ls -t | head -1)
