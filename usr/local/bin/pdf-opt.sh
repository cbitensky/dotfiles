#!/bin/sh
gs \
  -dBATCH -dNOPAUSE \
  -sDEVICE=pdfwrite \
  -dSubsetFonts=true \
  -dConvertCMYKImagesToRGB=true \
  -dCompressFonts=true \
  -sOutputFile="$1.pdf" \
  "$1"

#  -c ".setpdfwrite <</AlwaysEmbed [ ]>> setdistillerparams" \
#  -c ".setpdfwrite <</NeverEmbed [/Courier /Courier-Bold /Courier-Oblique /Courier-BoldOblique /Helvetica /Helvetica-Bold /Helvetica-Oblique /Helvetica-BoldOblique /Times-Roman /Times-Bold /Times-Italic /Times-BoldItalic /Symbol /ZapfDingbats /Arial]>> setdistillerparams" \
