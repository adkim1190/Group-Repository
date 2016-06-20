check() {
dir ="$1"
chsum1=`digest -a md5 $dir | awk '{print $1}'`
chsum2=$chsum1
}
