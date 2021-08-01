#!/bin/sh
set -e
E=`equery w $1`
ebuild --skip-manifest $E clean prepare
if [[ $E =~ /([^/]+)/([^/]+)/([^/]+).ebuild ]]; then
	P=${BASH_REMATCH[3]}
	cd /var/tmp/portage/${BASH_REMATCH[1]}/$P/work
	cd $P || cd ${P%%-*}* || cd `find . -type d ! -path . -print -quit` || true
	git init
	git add -A
	git commit -m '.'
	echo $PWD > /tmp/lwd
fi
