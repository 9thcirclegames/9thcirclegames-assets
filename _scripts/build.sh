#!/bin/bash

declare -a assets=("eden" "woc" "common" "brand")

for j in "${assets[@]}"; do
	echo $j
	cd ./${j}
	shopt -s nullglob
	for i in *.jpg *.JPG *.png *.PNG; do
		filename=$(basename "$i")
		extension="${filename##*.}"
		filename="${filename%.*}"
		convert            \
  		$i                 \
 		-quality 90        \
 		-colorspace rgb    \
 		+profile '*'                     \
 		-filter Lanczos                  \
 		-write mpr:copy-of-huge-original \
 		+delete                          \
  		mpr:copy-of-huge-original -resize '1920x1200>'  -write ${filename}1920.${extension} +delete \
  		mpr:copy-of-huge-original -resize '1024x768>'  -write ${filename}1024.${extension} +delete \
  		mpr:copy-of-huge-original -resize '960x720>'   -write ${filename}960.${extension}  +delete \
  		mpr:copy-of-huge-original -resize '800x600>'   -write ${filename}800.${extension}  +delete \
  		mpr:copy-of-huge-original -resize '200x150>'   -write ${filename}200.${extension}  +delete \
  		mpr:copy-of-huge-original -thumbnail '150x150^' -gravity center -extent '150x150' ${filename}-thumbnail.${extension}
	done
	cd ..
done
