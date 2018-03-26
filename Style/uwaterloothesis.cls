%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]%
\ProvidesClass{uwaterloothesis}[2014/10/01 v0.1 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\newif\ifUW@singlesided \UW@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
    \UW@singlesidedtrue%
}
\newif\ifUW@doublesided \UW@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
    \UW@doublesidedtrue%
}
\newif\ifUW@printcopy \UW@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \UW@doublesidedtrue% auto enable double-sided style
    \UW@printcopytrue%
}
%-
%-> Draft version info
%-
\newif\ifUW@versioninfo \UW@versioninfofalse
\DeclareOption{draftversion}{%
    \UW@versioninfotrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{book}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\ifUW@doublesided% if double-sided printing enabled
    \LoadClass[letterpaper,12pt,openright,twoside]{book}
\else% if double-sided printing isn't enabled
    \LoadClass[letterpaper,12pt,oneside]{book}
\fi
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter%
    \InputIfFileExists{Style/uwaterloothesis.cfg}{}{}%
    \makeatother%
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming US letter paper (8.5in. x 11in.)
\setlength{\textwidth}{6in}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifUW@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{0.5in}% binding side margin
    \setlength{\evensidemargin}{0in}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{0.25in}% left side margin
    \setlength{\evensidemargin}{0.25in}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{220mm}% set required text height first
\setlength{\voffset}{-15mm}% set vertical offset
\setlength{\topmargin}{20pt}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{25pt}% vertical margin between header and body text
\setlength{\footskip}{30pt}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.1}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][empty]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- define prechapter command
\newcommand{\prechapter}[1]{%
    \pagestyle{plain}
    \begin{center}%
        {\bfseries #1}
    \end{center}%
}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Item commands
%-
\renewcommand{\title}[2][\UW@value@title]{%
    \def\UW@value@title{#2}%
    %\def\UW@value@titlemark{\MakeUppercase{#1}}}%
    \def\UW@value@titlemark{#1}%
}
\renewcommand{\@title}{\UW@value@titlemark}
\renewcommand{\author}[1]{\def\UW@value@author{#1}}
\newcommand{\degree}[1]{\def\UW@value@degree{#1}}
\newcommand{\discipline}[1]{\def\UW@value@discipline{#1}}
%-
%-> Redefine style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.1}
        \vspace*{1.0cm}

        \Huge
        {\bf \UW@value@title}

        \vspace*{1.0cm}

        \normalsize
        {by}

        \vspace*{1.0cm}

        \Large
        {\UW@value@author}

        \vspace*{3.0cm}

        \normalsize
        {\UW@value@statement}

        \vspace*{2.0cm}

        {\UW@value@school}

        \vspace*{1.0cm}

        {\copyright\ \UW@value@author\ \the\year}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifUW@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage
    \else
        \ifUW@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage
        \fi
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- examining committee membership
\newenvironment{committee}
{\prechapter{\UW@label@committee}}
{\cleardoublepage}
%- author's declaration
\newenvironment{declaration}
{\prechapter{\UW@label@declaration}}
{\cleardoublepage}
%- statement of contribution
\newenvironment{contribute}
{\prechapter{\UW@label@contribute}}
{\cleardoublepage}
%- abstract
\newenvironment{abstract}
{\prechapter{\UW@label@abstract}}
{\cleardoublepage}
%- acknowledgements
\newenvironment{acknowledgements}
{\prechapter{\UW@label@thanks}}
{\cleardoublepage}
%- dedication
\newenvironment{dedication}
{\prechapter{\UW@label@dedication}\begin{center}\bigskip\itshape}
{\end{center}\cleardoublepage}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%%- define spacing and length
%\def\@dotsep{1.5mu}% spacing for dots
%\def\@pnumwidth{2em}% spacing between titles and page numbers
%\def\@tocrmarg{2em}% right margin indentation
%\def\@chaptervspace{1ex}% spacing between chapter titles
%%- redefine dottedtocline from classes.dtx and latex.ltx
%\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
%    \ifnum #1>\c@tocdepth \else
%        \vskip \z@ \@plus.2\p@
%        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
%        \parindent #2\relax\@afterindenttrue
%        \interlinepenalty\@M
%        \leavevmode
%        \@tempdima #3\relax
%        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
%        {#4}\nobreak
%        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
%        \nobreak
%        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
%        \par\penalty\@highpenalty}%
%    \fi
%}
%%- redefine l@part from book.cls to add dotted toc line
%\renewcommand*{\l@part}[2]{% [<title>,<page>]
%    \ifnum \c@tocdepth >-2\relax
%        \addpenalty{-\@highpenalty}%
%        \addvspace{2.25em \@plus\p@}%
%        \setlength\@tempdima{3em}%
%        \begingroup
%            \parindent \z@ \rightskip \@pnumwidth
%            \parfillskip -\@pnumwidth
%            {\leavevmode
%            \large \bfseries #1
%            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
%            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
%            \nobreak
%            \global\@nobreaktrue
%            \everypar{\global\@nobreakfalse\everypar{}}%
%        \endgroup
%    \fi
%}
%%- redefine l@chapter from book.cls to add dotted toc line
%\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
%    \ifnum \c@tocdepth >\m@ne
%        \addpenalty{-\@highpenalty}%
%        \vskip \@chaptervspace \@plus\p@
%        \setlength\@tempdima{1.5em}%
%        \begingroup
%            \parindent \z@ \rightskip \@pnumwidth
%            \parfillskip -\@pnumwidth
%            \leavevmode \bfseries
%            \advance\leftskip\@tempdima
%            \hskip -\leftskip
%            #1\nobreak
%            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
%            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%            \penalty\@highpenalty
%        \endgroup
%    \fi
%}
%---------------------------------------------------------------------------%
\endinput

