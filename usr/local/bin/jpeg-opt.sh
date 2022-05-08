#!/bin/sh -e
FS1=`stat -c%s "$1"`
jpegtran -optimize -progressive $2 "$1" >"$1.temp"
FS2=`stat -c%s "$1.temp"`
if [ $FS1 -gt $FS2 ]; then
	mv "$1.temp" "$1"
	S=→
else
	rm "$1.temp"
	S=X
fi
echo $1: $FS1 $S $FS2
exit 0