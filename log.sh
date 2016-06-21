#!/bin/bash

target=log.txt
memory=0

while [ ! -e backup_job* ]; do
	mem=`wc -l log.txt`
	if [ ! $memory -eq $mem ]; then
		let newstuff = $mem - $memory
		tail -n $newstuff
		memory=$mem
	fi
done
