###
# Build specification docs
#
### Basic use: 'make'
# A build/ directory will be created if not already present, and all necessary files for producing the specification PDF will be copied or generated into there.
#
### Debugging: `make debug`
# This will show the output of the LaTeX build to help debug
#
### Generating from a model
# If a file named <SPECACRO>.config is present in this dirctory, it will be used to drive md2LaTeX.py from the mdsa-tools
# repository, and generate LaTeX files from a MagicDraw model. (Other tool support pending.) Otherwise, this step
# is skipped.

### Author settable locations
# Default location for the temporary directory for building your PDF
build := build
# Where you GeneratedContent will be placed from your model if you're using that mechanism
gencondir := GeneratedContent

### Final PDF name
# By default, it is simply the ACRONYM_VERSION.pdf. If you choose to use something different, comment the following line and set a new value.
pdfnamebase = ${specacro}_${version}

###
# Nothing below here is user settable or usable
doc := Specification
all: spec
.PHONY: all 
include ./mdsa-omg-core/_core.mk
