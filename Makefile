document = dissertation

# commands
LATEX = pdflatex
BIBTEX = bibtex

# targets
all: $(document).pdf
docx: $(document).docx
pdf: $(document).pdf

BIB = dissertation.bib
PDFLAGS = --filter pandoc-crossref --bibliograph=$(BIB) --chapters

# sources
CHAPTERS = source/01_intro.md \
		   source/02_misr.md \
		   source/03_subgrid1.md \
		   source/04_subgrid2.md \
		   source/05_summary.md 

TEXSRC = latex/abstract.tex \
		 latex/acknowledgments.tex \
		 latex/01_intro.tex \
		 latex/02_misr.tex \
		 latex/03_subgrid1.tex \
		 latex/04_subgrid2.tex \
		 latex/05_summary.tex

# Make targets
# NOTE: for compiling the pdf from the LaTeX source, if you do not have latexmk 
# installed, you can replace the latexmk command with:
#
#     pdflatex $< && bibtex $< && pdflatex $< && pdflatex $<
#     
$(document).pdf: $(document).tex $(TEXSRC) $(document).bib $(shell find graphics -type f)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" $<

$(document).docx: $(document).md source/abstract.md $(CHAPTERS)
	pandoc $(PDFLAGS) -M chapters --reference-docx=template.docx -o $@ $^

latex/%.tex: source/crossref.yaml source/%.md
	pandoc --filter pandoc-crossref --natbib --chapters -o $@ $^
	sed -i '' 's/begin{figure}\[htbp\]/begin{figure}\[tp\]/g' $@

clean:
	latexmk -c
