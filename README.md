# umphdthesis

This repository contains a LaTeX thesis template for an English-language PhD dissertation, styled to follow the University of Macau thesis formatting requirements.

## Repository structure

- `thesis.tex` — main thesis document. This is where you set the title, author, supervisor(s), department, degree details, and chapter content.
- `umphdthesis.cls` — custom LaTeX class file that defines the thesis layout and formatting. In principle, you should not have to make any changes to this document.
- `bibliography.bib` — bibliography database for all references cited in the thesis. I personally recommend using the JabRef software for bibliography management.
- `thesis.pdf` — compiled PDF output of the thesis.
- `img/` — image assets used in the document, such as logos or figures.
- `docs/` — supporting documentation, including the formatting guidelines PDF.

## Quick start

1. Install a LaTeX distribution, for example:
   - TeX Live (Linux)
   - MacTeX (macOS)
   - MiKTeX (Windows)

2. Compile the document
  1. Via terminal
    1. Open a terminal in the repository root
    2. Run:
  
    ```bash
    pdflatex thesis.tex
    bibtex thesis
    pdflatex thesis.tex
    pdflatex thesis.tex

  2. Using a LaTeX IDE such as TeXstudio
    1.  Press F5 on your keyboard or click on the Build & View double green arrow  
