#!/bin/sh
xsltproc /usr/local/xsl/fb2-binary.xsl - | while read f; do
	base64 -d $f > ${f%%.base64} && rm $f
done
