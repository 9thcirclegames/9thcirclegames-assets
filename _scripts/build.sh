#!/bin/bash

declare -a assets=("eden" "woc" "common" "brand")

for j in "${assets[@]}"; do
	cd ./${j}
	shopt -s nullglob
	for i in *.jpg *.JPG *.png *.PNG; do

		identify -verbose $i
		
		filename=$(basename "$i")
		extension="${filename##*.}"
		filename="${filename%.*}"

		# Retina files are not resized
		if [[ ${filename} == *"@2x"* ]]; then
  			continue
		fi

		convert $i							\
		-quality 90							\
		-colorspace sRGB				\
		-units PixelsPerInch		\
		-density 120						\
		-filter Lanczos					\
		-write mpr:main					\
		+delete									\
		mpr:main -resize '1920x1200>' -write ${filename}1920.${extension} +delete \
		mpr:main -resize '1024x768>'  -write ${filename}1024.${extension} +delete \
		mpr:main -resize '960x720>'   -write ${filename}960.${extension}  +delete \
		mpr:main -resize '800x600>'   -write ${filename}800.${extension}  +delete \
		mpr:main -resize '200x150>'   -write ${filename}200.${extension}  +delete \
		mpr:main -thumbnail '150x150^' -gravity center -extent '150x150' ${filename}-thumbnail.${extension}
	done
	cd ..
done
