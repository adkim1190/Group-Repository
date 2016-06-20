

=======
check() {
dir ="$1"
chsum1=`digest -a md5 $dir | awk '{print $1}'`
chsum2=$chsum1
}

#list files from a destination
#then list files from the destination you are sourcing from
#dif
#pipe into somewhere else
