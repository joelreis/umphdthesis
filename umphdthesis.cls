%==============================================================================
% umphdthesis.cls
% LaTeX class for English-language PhD theses at the University of Macau
%
% Based on: "Guidelines Governing the Format of Theses of PhD and Other
% Doctoral Degree Programmes", GRS.09-4/201502/400.r02, 17/5/2023
%
% Author: Joel Reis joelreis@um.edu.mo
% Version: 1.0
% License: MIT
%==============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umphdthesis}[2026/10/12 v1.0 University of Macau PhD Thesis]

%--------
% Options
%--------
\newif\if@umphd@twoside % Create a new boolean switch
\@umphd@twosidetrue % Set the switch to true by default 
\DeclareOption{oneside}{\@umphd@twosidefalse}
\DeclareOption{twoside}{\@umphd@twosidetrue}

\newif\if@umphd@draft
\@umphd@draftfalse
\DeclareOption{draft}{\@umphd@drafttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} % catch-all
\ProcessOptions\relax

%--------------------------
% Base class: report (12pt)
%--------------------------
\if@umphd@twoside
\LoadClass[12pt,a4paper,twoside,openright]{report}
\else
\LoadClass[12pt,a4paper,oneside,openany]{report}
\fi

%------------------
% Required packages
%------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{newtxtext} % Times-like text font
\RequirePackage{newtxmath} % Times-like math font
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{ragged2e}
\RequirePackage[acronym,toc]{glossaries-extra} % Also loads glossaries itself
\RequirePackage{hyperref}
\RequirePackage{bookmark}

% If you swap this for \makenoidxglossaries, then replace \printglossary with \printnoidxglossary in the environments below.
\makeglossaries

%---------------------------------
% Page geometry - see /docs/<> 
%   Binding edge (inner): 4 cm
%   Other three margins: 2.5 cm
%   twoside: inner = binding edge
%---------------------------------
\geometry{
	a4paper,
	inner=4cm,
	outer=2.5cm,
	top=2.5cm,
	bottom=2.5cm,
	headheight=15pt,
	headsep=0.5cm,
	footskip=1.0cm
}

% Force a single-sided, centered, marginless page for title pages
\newcommand{\umphd@onesidedpage}{%
	\clearpage
	\@twosidefalse
	\@mparswitchfalse
	\newgeometry{%
		left=0cm,right=0cm,%
		top=2.5cm,bottom=2.5cm,%
		headheight=15pt,headsep=0.5cm,footskip=1.0cm,%
		twoside=false%
	}%
	\thispagestyle{umphd@empty}%
}
\newcommand{\umphd@restoregeometry}{%
	\restoregeometry
	\if@umphd@twoside\@twosidetrue\else\@twosidefalse\fi
}

%-------------------------------------------
% Line spacing: double throughout the thesis
%-------------------------------------------
\doublespacing

%--------------------------------------------
% Page style: page number centered at bottom
%--------------------------------------------
\fancypagestyle{umphd@plain}{%
	\fancyhf{}%
	\fancyfoot[C]{\thepage}%
	\renewcommand{\headrulewidth}{0pt}%
	\renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{umphd@empty}{%
	\fancyhf{}%
	\renewcommand{\headrulewidth}{0pt}%
	\renewcommand{\footrulewidth}{0pt}%
}

% Apply the plain style globally to chapter-opening pages too
\renewcommand{\ps@plain}{%
	\ps@umphd@plain
}

\pagestyle{umphd@plain}

%-------------------------------
% Chapter and section formatting
%-------------------------------
\titleformat{\chapter}[display]
{\normalfont\large\bfseries\centering}
{\chaptertitlename\ \thechapter}
{1ex}
{\large\bfseries}
\titlespacing*{\chapter}{0pt}{-20pt}{20pt}

\titleformat{\section}
{\normalfont\large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}
{\normalfont\normalsize\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}
{\normalfont\normalsize\bfseries}{\thesubsubsection}{1em}{}

%---------------------------------------------
% Front matter page numbering (Roman numerals)
%---------------------------------------------
\newcommand{\umphd@frontmatter}{%
	\pagenumbering{roman}%
	\pagestyle{umphd@plain}%
}
\newcommand{\umphd@mainmatter}{%
	\clearpage
	\pagenumbering{arabic}%
	\pagestyle{umphd@plain}%
}

%----------------
% Thesis metadata
%----------------
\newcommand{\umphd@title}{}
\newcommand{\umphd@author}{}
\newcommand{\umphd@authorformatted}{}
\newcommand{\umphd@supervisor}{}
\newcommand{\umphd@cosupervisor}{}
\newcommand{\umphd@department}{}
\newcommand{\umphd@degreetitle}{}
\newcommand{\umphd@degreeyear}{}
\newcommand{\umphd@academicunit}{}
\newcommand{\umphd@authoryear}{}
\newcommand{\umphd@glossaryfile}{glossary-entries.tex}

\newcommand{\thesistitle}[1]{%
	\renewcommand{\umphd@title}{#1}%
}
\newcommand{\umphd@givennames}{}
\newcommand{\umphd@surnames}{}

\newcommand{\thesisauthor}[2]{%
	\renewcommand{\umphd@givennames}{#1}%
	\renewcommand{\umphd@surnames}{#2}%
	\renewcommand{\umphd@author}{#1\ #2}%
}

\newcommand{\umphdauthorformatted}{%
	\MakeUppercase{\umphd@surnames}, \umphd@givennames
}
\newcommand{\thesissupervisor}[1]{%
	\renewcommand{\umphd@supervisor}{#1}%
}
\newcommand{\thesiscosupervisor}[1]{%
	\renewcommand{\umphd@cosupervisor}{#1}%
}
\newcommand{\thesisdepartment}[1]{%
	\renewcommand{\umphd@department}{#1}%
}
\newcommand{\thesisdegreetitle}[1]{%
	\renewcommand{\umphd@degreetitle}{#1}%
}
\newcommand{\thesisdegreeyear}[1]{%
	\renewcommand{\umphd@degreeyear}{#1}%
}
\newcommand{\thesisacademicunit}[1]{%
	\renewcommand{\umphd@academicunit}{#1}%
}
\newcommand{\thesisauthoryear}[1]{%
	\renewcommand{\umphd@authoryear}{#1}%
}
\newcommand{\umphdglossaryfile}[1]{%
	\renewcommand{\umphd@glossaryfile}{#1}
}

%----------------------------------------
% Thesis cover (Appendix I - English)
% Single-sided, centered, no page number
%----------------------------------------
\newcommand{\makecover}{%
	\umphd@onesidedpage
	\begin{titlepage}%
		\thispagestyle{umphd@empty}%
		\begin{center}%
			{\large\umphd@title\par}
			\vspace{2.5cm}
			{\large by\par}
			\vspace{1.0cm}
			{\large\umphd@author\par}
			\vspace{2cm}
			{\large\umphd@degreetitle\par}
			\vspace{2cm}
			{\large\umphd@degreeyear\par}
			\vspace{1.5cm}
			\includegraphics[width=8cm]{./img/UM-Logo_V-Black}\par
			\vspace{0.5cm}
			{\large\umphd@academicunit\par}
			\vspace{0.5cm}
			{\large University of Macau\par}
		\end{center}%
	\end{titlepage}%
	% add a blank page
	\newpage
	\thispagestyle{umphd@empty}%
	\mbox{}%
	\newpage

	\umphd@restoregeometry
}

%----------------------------------------
% Title page (Appendix II - English)
% Single-sided, centered, no page number
%----------------------------------------
\newcommand{\maketitlepage}{%
	\umphd@onesidedpage
	\begin{titlepage}%
		\thispagestyle{umphd@empty}%
		\begin{center}%
			\vspace*{2cm}
			{\large\umphd@title\par}
			\vspace{2cm}
			{\large by\par}
			\vspace{1.5cm}
			{\large\umphd@author\par}
			\vspace{2cm}
			{\large SUPERVISOR: \umphd@supervisor\par}
			\ifx\umphd@cosupervisor\empty
			\else
			\vspace{0.5cm}
			{\large CO-SUPERVISOR: \umphd@cosupervisor\par}
			\fi
			\ifx\umphd@department\empty
			\else
			\vspace{0.5cm}
			{\large DEPARTMENT: \umphd@department\par}
			\fi
			\vspace{2cm}
			{\large\umphd@degreetitle\par}
			\vspace{1cm}
			{\large\umphd@degreeyear\par}
			\vspace{1.5cm}
			{\large\umphd@academicunit\par}
			\vspace{0.5cm}
			{\large University of Macau\par}
		\end{center}
	\end{titlepage}
	% add a blank page
	\newpage
	\thispagestyle{umphd@empty}%
	\mbox{}%
	\newpage
	
	\umphd@restoregeometry
}

%-------------------------------------------------------
% Author's Right page (Appendix III)
% Single-sided, centered 10 cm from top, no page number
%-------------------------------------------------------
\newcommand{\makeauthorright}{%
	\umphd@onesidedpage
	\begin{titlepage}%
		\thispagestyle{umphd@empty}%
		\null\vspace{9.5cm}% approximately 10 cm from top (accounting for 0.5cm baseline)
		\begin{center}%
			{\normalsize Author's right \umphd@authoryear\ by\par}
			\vspace{0.3cm}
			{\normalsize\umphdauthorformatted\par}
		\end{center}%
	\end{titlepage}%
	% add a blank page
	\newpage
	\thispagestyle{umphd@empty}%
	\mbox{}%
	\newpage
	\umphd@restoregeometry
}

%-----------------
% Acknowledgements
%-----------------
\newenvironment{umphdacknowledgements}{%
	\pagenumbering{roman}%
	\setcounter{page}{1}%
	\chapter*{Acknowledgements}%
	\addcontentsline{toc}{chapter}{Acknowledgements}%
	\markboth{Acknowledgements}{Acknowledgements}%
}

%---------
% Abstract
%---------
\newenvironment{umphdabstract}{%
	\let\cleardoublepage\clearpage
	\chapter*{Abstract}%
	\addcontentsline{toc}{chapter}{Abstract}%
	\markboth{Abstract}{Abstract}%
}{%
	\clearpage
}

%------------
% Declaration
%------------
\newcommand{\umphddeclarationtext}{%
	I declare that the thesis here submitted is original except for the source materials explicitly acknowledged and that this thesis as a whole, or any part of this thesis has not been previously submitted for the same degree or for a different degree.
	
	\vspace{0.5cm}
	
	I also acknowledge that I have read and understood the Rules on Handling Student Academic Dishonesty and the Regulations of the Student Discipline of the University of Macau.
}

\newenvironment{umphddeclaration}{%
	\chapter*{Declaration}%
	\addcontentsline{toc}{chapter}{Declaration}%
	\markboth{Declaration}{Declaration}%
	\umphddeclarationtext
	\vspace{1.5cm}\par
	\noindent\rule{6cm}{0.4pt}\par
	\noindent\umphd@author\par
	\noindent\umphd@degreeyear\par
	\let\cleardoublepage\clearpage
}

%---------------------------------
% Glossary/List of Abbreviations
%---------------------------------
\newenvironment{umphdglossary}{%
	\clearpage
	\let\cleardoublepage\clearpage
	\printglossary[title={Glossary},toctitle={Glossary}]%
	\clearpage
}{}

\newenvironment{umphdabbreviations}{%
	\clearpage
	\let\cleardoublepage\clearpage
	\printglossary[type=\acronymtype,title={List of Abbreviations},toctitle={List of Abbreviations}]%
	\clearpage
}{}

%--------------------------------------
% List of Tables and Figures (combined)
%--------------------------------------
\newcommand{\umphdlistoffiguresandtables}{%
	\let\cleardoublepage\clearpage
	\chapter*{List of Tables and Figures}%
	\addcontentsline{toc}{chapter}{List of Tables and Figures}%
	\markboth{List of Tables and Figures}{List of Tables and Figures}%
	\vspace{0.5cm}
	\noindent\textbf{Tables}\par
	\vspace{0.3cm}
	\@starttoc{lot}%
	\vspace{0.8cm}
	\noindent\textbf{Figures}\par
	\vspace{0.3cm}
	\@starttoc{lof}%
	\clearpage
}

%------------------------------------------------
% TOC formatting: indent sections and subsections
%------------------------------------------------
\titlecontents{chapter}[0em]
{\vspace{0.3em}\bfseries}
{\contentslabel{2em}}
{\hspace*{-2em}}
{\titlerule*[0.5pc]{.}\contentspage}

\titlecontents{section}[2em]
{\vspace{0.1em}}
{\contentslabel{2em}}
{\hspace*{-2em}}
{\titlerule*[0.5pc]{.}\contentspage}

\titlecontents{subsection}[4em]
{\vspace{0.1em}}
{\contentslabel{3em}}
{\hspace*{-3em}}
{\titlerule*[0.5pc]{.}\contentspage}

\renewcommand\bibname{References}

%---------------
% Hyperref setup
%---------------
\AtBeginDocument{%
	\hypersetup{
		pdfdisplaydoctitle=true,
		bookmarksnumbered=true,
		colorlinks,
		citecolor=NavyBlue,
		hidelinks,
		bookmarksopen=true,
		pdftitle={\umphd@title},
		pdfauthor={\umphd@author},
		pdfsubject={PhD Thesis, University of Macau}
	}%
	\IfFileExists{\umphd@glossaryfile}{%
		\loadglsentries{\umphd@glossaryfile}%
	}{}%
}

% Sensible defaults for a thesis
\setglossarystyle{long}          % longtable-based, good for multi-page lists
\renewcommand{\glossarypreamble}{\vspace{0.5em}}
\setlength{\glsdescwidth}{0.75\textwidth}
\setlength{\glspagelistwidth}{0.15\textwidth}

% Abbreviation style: on first use, spell out; afterwards, short form
\setabbreviationstyle[acronym]{long-short}

%----------------------------------------------------------------
% Convenience: build the entire front matter in the correct order
%----------------------------------------------------------------
\newcommand{\umphdfrontmatter}{%
	\umphd@frontmatter
	\makecover
	\maketitlepage
	\makeauthorright
}

\newcommand{\umphdmainmatter}{%
	\umphd@mainmatter
}

\endinput