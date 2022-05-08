#!/bin/sh -e
F="$1"
TP=/var/tmp/`basename "$0"`-$$-
R="${F%.*}.avif"
N=`basename "$F"`
N=${N%.*}
Y="$TP$N.y4m"
P="$F"
if [ ${F##*.} != png ]; then
	P="$TP$N.png"
	convert "$F" "$P"
	RM=1
fi
ffmpeg -nostats -i "$P" -pix_fmt yuv444p "$Y"
[ -n "$RM" ] && rm "$P"
avifenc -l -s 0 "$Y" "$R"
rm "$Y"
[ `stat -c%s "$R"` -gt `stat -c%s "$F"` ] && mv "$R" "$R.big"
exit 0
