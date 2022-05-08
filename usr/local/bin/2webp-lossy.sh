#!/bin/sh
cwebp -q 95 -m 6 -pass 10 "$@" -o "${@%.*}.webp"