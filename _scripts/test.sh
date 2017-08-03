#!/bin/bash

declare -a assets=("eden" "woc" "common" "brand")

# Checking files
for j in "${assets[@]}"; do
	FILES=/$j/*
	for f in $FILES; do
		pattern=" |'"
		if [[ $f =~ $pattern ]]
		then
   			echo ERROR: Found one or more spaces in filename ${f} >&2
			exit 1
		else
   			echo INFO: Checking ${f}...passed
		fi
	done
done
