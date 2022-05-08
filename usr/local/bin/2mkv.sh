#!/bin/bash
F="${!#}"
mkvmerge  --output "${F%%.*}-out.mkv" --no-track-tags --no-global-tags '[' "$@" ']' --no-date --disable-track-statistics-tags --engage no_variable_data --engage remove_bitstream_ar_info