
#!/bin/bash



echo "#!/bin/bash
#MSUB -N ajob
#MSUB -A b1011
#MSUB -q ligo
#MSUB -l walltime=00:00:$2
#MSUB -l nodes=1:ppn=1
#MSUB -j oe

cd \$PBS_O_WORKDIR

source $1" > submit;

msub submit;
rm submit;


time=`cat | grep -Eo 'cput=.{0,8}'


log()
diskspace()



echo "backup completed in:", time





