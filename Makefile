###
# Build specification docs
#
### Basic use: 'make'
# A build/ directory will be created if not already present, and all necessary files for producing the specification PDF will be copied or generated into there.
#
### Generating from a model
# If a file named <SPECACRO>.config is present in this dirctory, it will be used to drive md2LaTeX.py from the mdsa-tools
# repository, and generate LaTeX files from a MagicDraw model. (Other tool support pending.) Otherwise, this step
# is skipped.
#

build := build
gencondir := GeneratedContent

specacro := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup specacro --setupFile _Specification_Setup.tex)
version  := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup version --setupFile _Specification_Setup.tex)
pdfnamebase := ${specacro}_${version}

all: spec

.PHONY: all 

include ./mdsa-omg-core/_core.mk
