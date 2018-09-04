#!/usr/bin/env bash

if [ $# -lt 1 ]; then
     echo "Usage: krender.sh <kotlin_script> [additional arguments]+" >&2 ; exit 1;
fi

inputScript=$1

#inputScript=basic_kotlin_report.kts
#inputScript=krangl_example_report.kts
#inputScript=iris_vis.kts

reportName=$(basename $inputScript .kts)

inputBaseName=$(basename $inputScript .kts)

if [ ! -f $inputScript ]; then
     echo "Error: Input file $inputScript does not exist" >&2 ; exit 1;
fi

# https://www.r-project.org/
Rscript - ${inputScript} <<"EOF"
knitr::spin(commandArgs(T)[1], doc = "^//'[ ]?", knit=F)
EOF

# https://github.com/holgerbrandl/kscript
kscript -t 'lines.map { it.replace("{r }", "")}.print()' ${inputBaseName}.Rmd > ${inputBaseName}.md

# https://github.com/aaren/notedown
notedown ${inputBaseName}.md > ${inputBaseName}.ipynb

# http://jupyter.org/install
#jupyter nbconvert --ExecutePreprocessor.kernel_name=kotlin --execute --to html ${inputBaseName}.ipynb --output ${inputBaseName}

jupyter nbconvert --ExecutePreprocessor.kernel_name=kotlin --execute --to markdown ${inputBaseName}.ipynb --output ${inputBaseName}
