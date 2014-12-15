%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** version information *********************************
%%
%% this is the "uwaterloothesis.cls" file for "uwaterloothesis" class definition
%% written by Huangrui Mo <mohuangrui@gmail.com>
%% $Last-modified: 14 Dec 2014 07:38:48 PM
%%
%% This program can be redistributed and/or modified under the terms
%% of the GNU Public License, version 2.
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
%% set margins to minimum permitted by uWaterloo thesis regulations:
%% part one -- horizontal widths
\ifUW@printcopy% if print copy layout enabled
  \setlength{\oddsidemargin}{0.125in}% ensure binding side at least 0.125in + 1.0in (fixed)
  \setlength{\evensidemargin}{0in}% ensure a uniform binding width for two-sided printed copy
\else
  \setlength{\oddsidemargin}{0.125in}% ensure binding side at least 1.125in
  \setlength{\evensidemargin}{0.125in}% ensure a uniform left margin for EThesis when two-sided
\fi
%% set margin for notes to zero to get the maximum textwidth
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%% assuming US letter paper (8.5in. x 11in.) and note margins as above
%% if note margins are 0, then \textwidth should be \paperwidth - 2*1.0in - \oddsidemargin
\setlength{\textwidth}{6.375in}% text width
%% part two -- vertical heights
\setlength{\headheight}{13.6pt}% set a minimum header height
\raggedbottom
%% specifies the amount of space between paragraphs.
%% other reasonable specifications are \bigskipamount and \smallskipamount.
\setlength{\parskip}{\medskipamount}
%% line spacing
\renewcommand{\baselinestretch}{1} % this is the default line space setting
%% default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* some style control commands ********************************
%%
%% redefine \cleardoublepage to handle both oneside and twoside modes
\def\cleardoublepage{%
  \clearpage%
  \if@twoside%
    \ifodd\c@page%
      % do nothing
    \else%
      \thispagestyle{empty}%
      \hbox{}%
      \newpage%
      \if@twocolumn%
        \hbox{}%
        \newpage%
      \fi%
    \fi%
  \fi}%
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
