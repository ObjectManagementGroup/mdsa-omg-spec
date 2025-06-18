###
# Build specification docs
#
# Basic use: 'make'
#
# If a file named <SPECACRO>.config is present in this dirctory, it will be used to drive md2LaTeX.py from the mdsa-tools
# repository, and generate LaTeX files from a MagicDraw model. (Other tool support pending.) Otherwise, this step
# is skipped.
#
# Markdown Support
# `make md`
# Markdown files are converted to LaTeX files and processed as well.
# Note that if there is a Markdown file *AND* a LaTeX file for the same file basename, the converted Markdown file takes precedence by default, but last modified wins on later builds.
# This lets an authoring team ignore the ./*.tex files if they wish. (Deleting them is also an option.)
# Use an explicit `make md` anytime you wish to manually regenerate from Markdown.

build := build

specacro := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup specacro --setupFile Specification_Setup.tex)
version  := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup version --setupFile Specification_Setup.tex)
pdfname := ${specacro}_${version}.pdf

# Depend on model generation and the build directory. Process any markdown files to LaTeX and incorporate them *last* before producing the document.
spec: ${build} ${build}/GeneratedContent core local md
	@echo --- Creating PDF
	cd build && pdflatex ./Specification.tex
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

# Create the build directory and populate it with the needed files for processing by LaTeX
${build}:
	mkdir -p "${build}"

${build}/GeneratedContent: ${build}
	cp -R ./GeneratedContent "${build}/GeneratedContent"

# LaTeX files support (local and core)
coretex := $(wildcard mdsa-omg-core/*.tex) $(wildcard mdsa-omg-core/*.sty) $(wildcard mdsa-omg-core/*.bib)
localtex := $(wildcard ./*.tex) $(wildcard ./*.bib)
markdowns := $(filter-out ./README.md, $(wildcard ./*.md))
core: $(subst mdsa-omg-core,${build},${coretex})
local: $(subst ./,${build}/,${localtex}) 
md: $(subst ./,${build}/,$(subst .md,.tex,${markdowns}))
${build}/%.tex: mdsa-omg-core/%.tex
	cp $< $@
${build}/%.tex: ./%.tex
	cp $< $@
${build}/%.tex: ./%.md
	pandoc $< -f markdown -t latex -o $@
${build}/%.sty: mdsa-omg-core/%.sty
	cp $< $@
${build}/%.bib: mdsa-omg-core/%.bib
	cp $< $@
${build}/%.bib: ./%.bib
	cp $< $@

convert-to-md: $(substr .tex,.md,${localtex})
./%.md: ./%.tex
	pandoc $< -t markdown -f latex -o $@
