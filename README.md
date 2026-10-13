# umphdthesis

This repository contains a LaTeX thesis template for an English-language PhD dissertation, styled to follow the University of Macau thesis formatting requirements.

## Repository structure

- `thesis.tex` — main thesis document. This is where you set the title, author, supervisor(s), department, degree details, and chapter content.
- `glossary-entries.tex` — document containing your glossary entries and abbreviations.
- `umphdthesis.cls` — custom LaTeX class file that defines the UM PhD thesis layout and formatting. In principle, you should not have to make any changes to this document.
- `bibliography.bib` — bibliography database for all references cited in the thesis. I personally recommend using the JabRef software for bibliography management.
- `thesis.pdf` — compiled PDF output of the thesis.
- `img/` — image assets used in the document, such as logos or figures.
- `docs/` — supporting documentation, including the formatting guidelines PDF.

## Quick start

If you are using Windows, I recommend installing [Strawberry Pearl](https://strawberryperl.com/)

This is often required for building glossaries, particularly when working with LaTeX editors such as TeXstudio.

The following steps should be sufficient to compile this template.
If you encounter any operating system-specific issues, please let me know.
I have tested the template on the following configurations:

| OS                | IDE                | Remarks |
| :---------------- | :----------------: |   ----: |
| Windows 11        |  Texstudio 4.9.8   |         |
| macOS 26          |  Texstudio 4.9.8   |         |
| Linux             |  Texstudio 4.9.8   |         |

<ol>
   <li> Install a LaTeX distribution, for example: </li>
      <ul>
         <li>TeX Live (Linux) </li>
         <li>MacTeX (macOS)</li>
         <li>MiKTeX (Windows)</li>
      </ul>
   <li> Compile the document </li>
      <ol>
         <li> Via terminal </li>
            <ol>
               <li> Open a terminal in the repository root </li>
               <li> Run: </li>
                  ```bash
                     pdflatex thesis.tex
                     bibtex thesis
                     makeglossaries thesis
                     pdflatex thesis.tex
                     pdflatex thesis.tex
                  ```
            </ol>
         <li> Using the LaTeX IDE TeXstudio</li>
            <ol>
               <li>Press F5</li>
               <li>Press F9</li>
               <li>Press F5 again</li>
            </ol>
      </ol>
</ol> 

## Usage

You simply have to edit the thesis metadata:

```latex
\thesistitle{Title of Thesis}
\thesisauthor{Given Names}{Surname}
\thesissupervisor{Name of Supervisor}
\thesiscosupervisor{Name of Co-supervisor(s) (if applicable)} % if applicable
\thesisdepartment{Name of Department (if applicable)} % optional
\thesisdegreetitle{Degree of Title}
\thesisdegreeyear{Year}
\thesisacademicunit{Academic Unit}
\thesisauthoryear{Year}
```

And pretty much that's it.

### Glossary and Acronyms

Regarding the citing/adding of entries in the glossary, use the command `\gls{<name>}`.
If instead you want to cite/add an acronym, use the command `\gls{acr:<name>}`.
A plural version is automatically created by simply invoking, in either case, the command `\glspl`.