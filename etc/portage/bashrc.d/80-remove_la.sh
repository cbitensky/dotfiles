#!/bin/bash
Remove_la() {
	BashrcdTrue $NOLAFILEREMOVE && return
# Some packages are known to rely on .la files (e.g. for building of plugins):
	case "$PN" in
		'gst-plugins-base'|'libsidplay'|'colm')
			return 0;;
	esac
	einfo 'removing unneeded *.la files'
	Dexport=$ED find "$ED" -name '*.la' '!' -name 'libltdl.la' -exec sh -c "for i
		do	if grep -q -- '^shouldnotlink=no\$' \"\$i\"
			then	printf '\\t%s\\n' \"\${i#\$Dexport}\"
				rm -- \"\$i\" || echo 'removing failed!'
			fi
		done" sh '{}' '+'
}

BashrcdPhase preinst Remove_la
