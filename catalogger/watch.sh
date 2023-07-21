#!/bin/bash

#ranges for radio frequency
MIN_FREQUENCY=87.5
MAX_FREQUENCY=108.0

#file our rtl_fm command will output to
file="output.bin"

#infinite loop to run rtl_fm with different frequencys
while true
do
	#calculate a random frequency within the specified range
	range=$(echo "$MAX_FREQUENCY - $MIN_FREQUENCY" | bc -l)
	random_frequency_unrounded=$(echo "$MIN_FREQUENCY + ($RANDOM / 32767.0) * $range" | bc -l)
	random_frequency=$(printf "%.1f" $random_frequency_unrounded)
	#add "M" to the end of the random_frequency to pass it to the rtl_fm command
	rf="${random_frequency}M"

	#begin collecting on command line specified channel
	( rtl_fm -M wbfm -r 48000 -f $rf $file ) > /dev/null 2>&1 &
	while true
	do
		#check if file exits and if it is greater than 500KB
		if [ -s $file ] &&  [ $(stat -c %s $file) -gt 512000 ]; then 
			# use pgrep to get the process IDs of the running processes with the given filename
			pids=$(pgrep -f "rtl_fm")
			for pid in $pids; do
				#ps aux | awk -v pid="$pid" '$2 == pid { print }'
				#kill rtl_fm process
				kill -15 "$pid"
			done
			#converted output.bin file to a csv using fft
			./raw_data/convertFM random_frequency 2000
			#move generated CSV to CSV directory to be sent off
			mv fft_radio.csv CSVs/
			#delete ouput.bin
			rm $file
			#send generated CSV file to archivist
			./records/catalog
			break
		fi
	done
		
done
