#!/bin/bash

declare -a assets=("eden" "woc" "common" "brand")

# Checking files
for j in "${assets[@]}"; do
	cd ./${j}
	shopt -s nullglob
	for i in *.jpg *.JPG *.png *.PNG; do
		pattern=" |'"
		if [[ $i =~ $pattern ]]
		then
   			echo "ERROR: Found one or more spaces in filename ${i}" >&2
			exit 1
		else
   			echo "INFO: Checking ${i}...passed"
		fi
	done
	cd ..
done
