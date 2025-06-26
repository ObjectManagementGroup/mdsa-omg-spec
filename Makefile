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
### Markdown Support
# `make md`
# Markdown files are converted to LaTeX files and processed as well by `make md`, which is included in the basic `make` run if Markdown files are present.
# Note that if there is a Markdown file *AND* a LaTeX file for the same file basename, the converted Markdown file takes precedence by default, but last modified wins on later builds.
# This lets an authoring team ignore the ./*.tex files if they wish. (Deleting them is also an option, and probably preferable.)
# Use an explicit `make md` anytime you wish to manually regenerate from Markdown, followed by `make` or `make spec`.

build := build
gencondir := GeneratedContent

specacro := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup specacro --setupFile _Specification_Setup.tex)
version  := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup version --setupFile _Specification_Setup.tex)
pdfnamebase := ${specacro}_${version}

all: spec

.PHONY: all 

include ./mdsa-omg-core/_core.mk
