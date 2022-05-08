#!/bin/sh
I=`file -b "$1"`
I=${I#*,}
read -r W X H <<<${I%%,*}
convert "$1" -verbose -chop $((W % 2))x$((H % 2)) -resize 50% -depth 8 "half8-$1"