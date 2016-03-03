%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** version information ********************************
%%
%% Copyright (C) 2014-2018 Huangrui Mo <huangrui.mo@gmail.com> 
%% This is free software: you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{uwaterloothesis}
  [2014/10/01 v0.1 uwaterloothesis
   document class]
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Declare Options **************************************
%%
%% end-user parameters, each option is declared by one declare option command
\newif\ifUW@versioninfo \UW@versioninfofalse
\DeclareOption{draftversion}{% draft information reminder
  \UW@versioninfotrue%
}
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
\DeclareOption*{% handle non-implemented options
  \PassOptionsToClass{\CurrentOption}{book}%
}
%% terminates all options processing
\ProcessOptions\relax
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** loadclass infomation *********************************
%%
\ifUW@doublesided% if double-sided printing enabled
  \LoadClass[letterpaper,12pt,openright,twoside]{book}
\else% if double-sided printing isn't enabled
  \LoadClass[letterpaper,12pt,oneside]{book}
\fi
%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** package infomation *********************************
%%
%% math packages
\RequirePackage{amsmath,amssymb,amstext}
%%%%% --------------------------------------------------------------------------------
%%
%%%%************************ load class configuretion ********************************
%%
\AtEndOfPackage{%class cfg loaded after package, makes commands at preamble take effect
  \makeatletter
  \InputIfFileExists{uwaterloothesis.cfg}{}{}
  \makeatother
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%******************************* page layout **************************************
%%
%% part one -- horizontal widths
%% left side width + textwidth + right side width = paperwidth
%% left side width of [odd, even] page = [odd, even]sidemargin + 1.0in (fixed)
%% binding side width + textwidth + nonbinding side width = paperwidth
%% binding side width of [odd, even] page = [left, right] side width
%% assuming US letter paper (8.5in. x 11in.)
\setlength{\textwidth}{6in}% set required text width first
\ifUW@printcopy% if print copy layout enabled
  \setlength{\oddsidemargin}{0.5in}% binding side width
  \setlength{\evensidemargin}{0in}% ensure uniform binding side width for printing
\else
  \setlength{\oddsidemargin}{0.25in}% left side width
  \setlength{\evensidemargin}{0.25in}% ensure uniform left side width for EThesis
\fi
%% set margin for notes to zero
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%% part two -- vertical heights
\setlength{\headheight}{14.5pt}% set a minimum header height
%% specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%% line spacing
%\renewcommand{\baselinestretch}{1} % this is the default line space setting
%% default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* some style control commands ********************************
%%
%% define prechapter command
\newcommand\prechapter[1]{%
  \pagestyle{plain}
  \begin{center}%
    {\bfseries #1}
  \end{center}%
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%******************* commands of titlepage items **********************************
%%
\renewcommand\title[2][\UW@value@title]{%
  \def\UW@value@title{#2}
  %\def\UW@value@titlemark{\MakeUppercase{#1}}}
  \def\UW@value@titlemark{#1}}
\def\@title{\UW@value@titlemark}
\renewcommand\author[1]{\def\UW@value@author{#1}}
\newcommand\degree[1]{\def\UW@value@degree{#1}}
\newcommand\discipline[1]{\def\UW@value@discipline{#1}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** titlepage configuration ******************************
%%
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{1.0cm}

    \Huge
    {\bf \UW@value@title}

    \vspace*{1.0cm}

    \normalsize
    by \\

    \vspace*{1.0cm}

    \Large
    \UW@value@author \\

    \vspace*{3.0cm}

    \normalsize
    \UW@value@statement

    \vspace*{2.0cm}

    \UW@value@school

    \vspace*{1.0cm}

    \copyright\ \UW@value@author\ \the\year \\
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
%%%%% --------------------------------------------------------------------------------
%%
%%%%****************************** new environments **********************************
%%
%% author's declaration
\newenvironment{declaration}
  {\prechapter{\UW@label@declaration}}
  {\cleardoublepage}
%% abstract
\newenvironment{abstract}
  {\prechapter{\UW@label@abstract}}
  {\cleardoublepage}
%% acknowledgements
\newenvironment{acknowledgements}
  {\prechapter{\UW@label@thanks}}
  {\cleardoublepage}
%% dedication
\newenvironment{dedication}
  {\prechapter{\UW@label@dedication}\begin{center}\bigskip\itshape}
  {\end{center}\cleardoublepage}
%% nomenclature
\newenvironment{nomenclature}
  {\chapter{\UW@label@nomenclature}}
  {\cleardoublepage}
%%%%% --------------------------------------------------------------------------------
\endinput
%% End of file `uwaterloothesis'.
%%%%% --------------------------------------------------------------------------------
