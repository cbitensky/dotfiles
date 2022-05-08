#!/bin/sh
declare -a A
N="$1"
ff () {
ffprobe -v 0 -of csv=s="\ " -hide_banner -select_streams $1 -show_entries stream=index,codec_name:stream_tags=language "$N"
}
while read S; do
	[ "$S" = "" ] && continue
	S=${S/program,/}
	A=($S)
	E=${A[2]/subrip/srt}
	E=${E/mpeg2video/mp2}
	E=${E/vorbis/ogg}
	E=${E/vp9/mkv}
	E=${E/mpeg4/mp4}
	E=${E/pcm*/wav}
	E=${E/dvd_subtitle/vobsub}
	[ $E = dvd_subtitle      ] && continue
	[ $E = hdmv_pgs_subtitle ] && continue
	R="$R -map 0:${A[1]} -c copy ${N:0:3}-${A[3]}-${A[1]}.$E"
#done <<< `ff v; ff a; ff s`
done <<< `ff s`
IFS=" "
ffmpeg -y -i "$N" -c copy $R
