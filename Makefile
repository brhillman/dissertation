document = dissertation
latex = pdflatex
bibtex = bibtex

SOURCES = $(document).tex $(document).bib \
    chapter1.tex chapter2.tex chapter3.tex \
    chapter4.tex chapter5.tex

all: $(document).pdf
draft: draft.pdf

$(document).pdf: $(SOURCES) $(document).tex
	pdflatex $(document) \
        && bibtex $(document) \
        && pdflatex $(document) \
        && pdflatex $(document)

draft.pdf: $(SOURCES) draft.tex
	pdflatex draft \
        && bibtex draft \
        && pdflatex  \
        && pdflatex draft 
