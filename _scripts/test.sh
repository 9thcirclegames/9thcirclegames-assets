#!/bin/bash

declare -a assets=("eden" "woc" "common" "brand")

# Checking files
for j in "${assets[@]}"; do
	cd ./${j}
	shopt -s nullglob
	for i in *.jpg *.JPG *.png *.PNG; do
		filename=$(basename "$i")
		extension="${filename##*.}"
		filename="${filename%.*}"

		pattern=" |'"
		if [[ $i =~ $pattern ]]
		then
   			echo "ERROR: Found one or more spaces in filename ${i}." >&2
			exit 1
		fi
   		
   		if [ ! -f ${filename}@2x.${extension} ]; then
    		echo "WARNING: Hi-res retina version not found for file ${i}."
		fi
   		
   		echo "INFO: Checking ${i}...passed"
	done
	cd ..
done
