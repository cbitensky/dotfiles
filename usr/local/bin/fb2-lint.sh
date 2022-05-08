#!/bin/sh
xmllint --schema /res/fb2/FictionBook.xsd --noout "$1" 2>&1 | sed "
s/^%[^:]*:/$1:/
s/{http:[^\}]*}//g
s/Schemas validity error /Schema error/
s/This element is not expected/Not expected/g
"
exit ${PIPESTATUS[0]}
