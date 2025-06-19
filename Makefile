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

specacro := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup specacro --setupFile Specification_Setup.tex)
version  := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup version --setupFile Specification_Setup.tex)
pdfname := ${specacro}_${version}.pdf

.PHONY: spec gen clean core local md

# Default target: build the document. Once for the base, second time for cross-references and ToC. Bibtex and a third time for bibliography creation.
spec: ${build} ${build}/GeneratedContent core local md
	@echo --- Creating PDF
	cd build && pdflatex ./Specification.tex 2>&1 > /dev/null
	cd build && pdflatex ./Specification.tex 2>&1 > /dev/null
	mv build/Specification.pdf "./${pdfname}"

# Only generate from the model if there is an appropriate ${specacro}.config file. I.e. UML.config or BPMN.config.
gen: ${build}
	@echo --- Generating from model
	@if [ -f "${specacro}.config" ]; then \
		./mdsa-tools/omgmdsa/md2LaTeX.py --config "${specacro}.config"; \
	else \
		echo "[MDSA] No "${specacro}.config" file, not building from model"; \
	fi

clean:
	@echo --- Cleaning
	rm -rf build/
	rm -f "${pdfname}"

${build}:
	mkdir -p "${build}"

# This is a raw copy, it could be smarter, but this is sufficiently fast
${build}/GeneratedContent: ${build}
	cp -R ./GeneratedContent "${build}/GeneratedContent"

# LaTeX files support (local and core)
coretex := $(wildcard mdsa-omg-core/*.tex) $(wildcard mdsa-omg-core/*.sty) $(wildcard mdsa-omg-core/*.bib)
localtex := $(wildcard ./*.tex) $(wildcard ./*.bib)
markdowns := $(filter-out ./README.md, $(wildcard ./*.md))
core: $(subst mdsa-omg-core,${build},${coretex})
local: $(subst ./,${build}/,${localtex}) 
md: ${build} $(subst ./,${build}/,$(subst .md,.tex,${markdowns}))

# Order of rules is important. This order allows local .tex files to override core .tex files, 
# and local .md files to override both
${build}/%.tex: mdsa-omg-core/%.tex
	cp $< $@

${build}/%.tex: ./%.tex
	cp $< $@

# Zero length files converted by pandoc end up non-zero-length, which breaks OMG templates
${build}/%.tex: ./%.md
	@target=$$0 ; \
	size=$(shell du -ks $< | cut -f1) ; \
	if (( $${size} > 0 )); then \
		pandoc $< -f markdown --defaults ./omgLaTeX.yaml -t latex -o $@ ; \
	else \
		touch $@ ; \
	fi

${build}/%.sty: mdsa-omg-core/%.sty
	cp $< $@

# As above, local *.bib files override core *.bib files if both exist.
${build}/%.bib: mdsa-omg-core/%.bib
	cp $< $@

${build}/%.bib: ./%.bib
	cp $< $@


