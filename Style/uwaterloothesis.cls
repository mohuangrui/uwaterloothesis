%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** version information *********************************
%%
%% this is the "uwaterloothesis.cls" file for "uwaterloothesis" class definition
%% written by Huangrui Mo <mohuangrui@gmail.com>
%% $Last-modified: 28 Nov 2014 03:25:14 PM
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
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
\setlength{\evensidemargin}{0.125in}% binding side of even pages if "twoside"
\setlength{\oddsidemargin}{0.125in}% left margin of all if "oneside", left of odd if "twoside"
\setlength{\textwidth}{6.375in}% text width
\raggedbottom
%%
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
