#!/bin/bash

dest=run.log
source=.

rm $dest
touch $dest
i=0
for FILE in $(ls $source/*.log) 
do 
  if [[ "$FILE" != *"_sim"* ]] && [[ "$FILE" != "$dest" ]]; then
	#check that the litmus test terminated correctly
	if grep -q Time $source/$FILE; then 
		cat $source/$FILE >> $dest
		echo "" >> $dest
		i=$((i+1))
	else
		echo "'Time' not found in $FILE"
	fi
  fi


done 
echo "Num of tests = $i"
