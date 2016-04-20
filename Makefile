document = dissertation

# commands
LATEX = pdflatex
BIBTEX = bibtex

# targets
all: $(document).pdf
docx: $(document).docx
pdf: $(document).pdf

BIB = source/dissertation.bib
PDFLAGS = --filter pandoc-crossref --bibliograph=$(BIB) --chapters

# sources
CHAPTERS = source/01_intro.md \
		   source/02_misr.md \
		   source/03_subgrid1.md \
		   source/04_subgrid2.md \
		   source/05_cmip5.md 

TEXSRC = latex/01_intro.tex \
		 latex/02_misr.tex \
		 latex/03_subgrid1.tex \
		 latex/04_subgrid2.tex \
		 latex/05_cmip5.tex

$(document).pdf: $(document).tex $(TEXSRC)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" $<

$(document).docx: $(document).md $(CHAPTERS)
	pandoc $(PDFLAGS) -M chapters --reference-docx=template.docx -o --toc $@ $^

latex/%.tex: source/crossref.yaml source/%.md
	pandoc --filter pandoc-crossref --natbib --chapters -o $@ $^

clean:
	latexmk -CA
