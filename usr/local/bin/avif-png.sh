#!/bin/sh -e
N=${1%.*}
P=$N.png
Y=$N.y4m
avifdec "$1" "$Y"
ffmpeg -i "$Y" -pix_fmt yuv444p "$P"
rm "$Y"
