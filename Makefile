###
# Build specification docs
#
# Basic use: 'make spec'
#
# If a file named modelgen.ini is present in this dirctory, it will be used to drive md2LaTeX.py from the mdsa-tools
# repository, and generate LaTeX files from a MagicDraw model. (Other tool support pending.) Otherwise, this step
# is skipped.
#

specacro := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup specacro --setupFile Submission_Setup.tex)
version  := $(shell ./mdsa-tools/omgmdsa/specsetup.py --lookup version --setupFile Submission_Setup.tex)
pdfname := ${specacro}_${version}.pdf

spec: gen
	mkdir -p build
	cp -R GeneratedContent build/
	cp mdsa-omg-core/* build/
# By putting this after copying the core files, a clever author can copy Submission.tex to the top level and then tweak it
	cp *.tex build/
	cp submission.bib build/
	cd build && pdflatex ./Submission.tex
	mv build/Submission.pdf "./${pdfname}"

%.tex: %.md
	pandoc -f markdown --defaults omgLaTeX.yaml -o @0 $< 

gen:
	@if [ -f "modelgen.ini" ]; then \
		./mdsa-tools/omgmdsa/md2LaTeX.py --config modelgen.ini; \
	else \
		echo "[MDSA] No modelgen.ini file, not building from model"; \
	fi

clean:
	rm -rf build/
	rm "${pdfname}"
