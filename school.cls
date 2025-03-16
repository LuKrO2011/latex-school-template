\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{school}[Base class for school worksheets and tests]

%%%-------------------------------------------------------------------------
%%%   Options
%%%-------------------------------------------------------------------------
\newif\ifsolution
\solutionfalse % By default, solutions are hidden (false)

%Set @textsize and @mathsize
\def\@textsize{12pt}   % Default text font size
\def\@mathsize{14pt}   % Default math font size

% Declare options
\RequirePackage{xkeyval} % Key-value parsing for options
\DeclareOptionX{textsize}{\edef\@textsize{#1}}
\DeclareOptionX{mathsize}{\edef\@mathsize{#1}} 

\DeclareOption{solution}{\solutiontrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\ProcessOptionsX\relax

%%%-------------------------------------------------------------------------
%%%   Strip 'pt' and Set Numerical Values
%%%-------------------------------------------------------------------------
\makeatletter
\def\strippt#1pt{#1}  % Removes 'pt' from a value

% Store the numeric value without 'pt'
\edef\textsizeNumeric{\expandafter\strippt\@textsize}
\edef\mathsizeNumeric{\expandafter\strippt\@mathsize}

%%%-------------------------------------------------------------------------
%%%   Font Size Selection
%%%-------------------------------------------------------------------------
\newcommand{\settextsize}{
    \def\actualtextsize{10} % Default size
    \ifnum\textsizeNumeric=10 \def\actualtextsize{10} \fi
    \ifnum\textsizeNumeric=11 \def\actualtextsize{11} \fi
    \ifnum\textsizeNumeric=12 \def\actualtextsize{12} \fi
    \ifnum\textsizeNumeric=14 \def\actualtextsize{14.4} \fi
    \ifnum\textsizeNumeric=17 \def\actualtextsize{17.28} \fi
}
\settextsize  % Apply the font size selection

%%%-------------------------------------------------------------------------
%%%   Math Size Adjustments
%%%-------------------------------------------------------------------------
\newcommand{\setmathsizes}{
    \edef\scriptmathsize{\the\numexpr (\mathsizeNumeric * 7 + 5) / 10\relax} % Round (0.7 * mathsizeNumeric)
    \edef\scriptscriptmathsize{\the\numexpr (\mathsizeNumeric * 5 + 5) / 10\relax} % Round (0.5 * mathsizeNumeric)
}
\setmathsizes  % Apply math sizes


%%%-------------------------------------------------------------------------
%%%   Base Class and Packages
%%%-------------------------------------------------------------------------
\LoadClass[\@textsize]{extarticle} % Use article as the base class
\AtBeginDocument{
    \DeclareMathSizes{\actualtextsize}{\@mathsize}{\scriptmathsize}{\scriptscriptmathsize}
}
\makeatother

\RequirePackage{geometry}   % Page layout
\RequirePackage{amsmath}    % Math support
\RequirePackage{amssymb}    % Additional math symbols
\RequirePackage{graphicx}   % Include graphics
\RequirePackage{hyperref}   % Hyperlinks
\RequirePackage{mdframed}   % Framing solutions
\RequirePackage{tikz}       % TikZ for custom shapes
\RequirePackage{xifthen}    % Conditional logic in LaTeX
\RequirePackage{everypage}  % Hooks for every page
\RequirePackage{totcount}   % Total counters
\RequirePackage{fancyhdr}   % Custom headers and footers
\RequirePackage{tcolorbox}  % Colored boxes
\usetikzlibrary{calc}       % Advanced TikZ calculations
\RequirePackage{titlesec}   % Custom section titles
\RequirePackage{enumitem}   % Custom lists

% Default layout
\geometry{a4paper, left=20mm, top=20mm, right=20mm, bottom=20mm}

%%%-------------------------------------------------------------------------
%%%   Fonts and Colors
%%%-------------------------------------------------------------------------
% Set default font
\usepackage[scaled]{helvet}
\renewcommand{\familydefault}{\sfdefault}

% Define colors
\definecolor{CUDblue}{HTML}{0072B2}   % Blue
\definecolor{CUDorange}{HTML}{E69F00} % Orange
\definecolor{CUDgreen}{HTML}{009E73}  % Green
\definecolor{CUDyellow}{HTML}{F0E442} % Yellow
\definecolor{CUDred}{HTML}{D55E00}    % Red
\definecolor{CUDpurple}{HTML}{CC79A7} % Purple
\definecolor{CUDgrey}{HTML}{999999}   % Grey

%%%-------------------------------------------------------------------------
%%%   Commands and Environments
%%%-------------------------------------------------------------------------
% Switch implementation
\usepackage{xifthen}
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

%%%-------------------------------------------------------------------------
%%%   Solution Command
%%%-------------------------------------------------------------------------
\ifsolution
\newcommand{\solutionNoCaption}[1]{%
    \begin{mdframed}[linecolor=red,linewidth=3pt]
    #1
    \end{mdframed}
}
\newcommand{\solution}[1]{%
  \solutionNoCaption{{\bf \large Musterlösung:} \\

  #1
  }
}
\else
\newcommand{\solutionNoCaption}[1]{}
\newcommand{\solution}[1]{}
\fi

%%%-------------------------------------------------------------------------
%%%   Squares
%%%-------------------------------------------------------------------------
\newcommand{\squares}[1]{%
  % Compute the rounded width to display only full squares
  \pgfmathsetlengthmacro{\gridwith}{floor(\textwidth/0.5cm) * 0.5cm}%
  
  % Compute the total height based on the number of rows
  \pgfmathsetlengthmacro{\gridheight}{#1 * 0.5cm}%

  % Draw the grid
  \begin{tikzpicture}
    \draw[step=0.5cm,color=gray] (0,0) grid ({\gridwith}, {\gridheight});%
  \end{tikzpicture}%
}

%%%-------------------------------------------------------------------------
%%%   Thinking Bubble
%%%-------------------------------------------------------------------------
% Define the thought bubble
\newcommand{\bubbleold}[2]{% #1 = width, #2 = height
    \begin{tikzpicture}[xscale=#1, yscale=#2]
        % Draw the main thought bubble
        \draw (-1.6,-0.7) .. controls (-2.3,-1.1)
        and (-2.7,0.3) .. (-1.7,0.3) .. controls (-1.6,0.7)
        and (-1.2,0.9) .. (-0.8,0.7) .. controls (-0.5,1.6)
        and (0.6,1.3) .. (0.7,0.5) .. controls (1.5,0.4)
        and (1.2,-1) .. (0.4,-0.6) .. controls (0.2,-1)
        and (-0.2,-1) .. (-0.5,-0.7) .. controls (-0.9,-1)
        and (-1.3,-1) .. cycle;

        % Draw the small circles
        \draw (-1.5,-1) circle (3pt);
        \draw (-1.7,-1.2) circle (2pt);
        \draw (-1.9,-1.4) circle (1pt);
    \end{tikzpicture}
}

% Define the bubble command for scaling an image
\newcommand{\bubble}[2]{% #1 = width, #2 = height
    \begin{scope}[xscale=#1, yscale=#2]
        \includegraphics[width=4cm, height=2cm]{think-bubble.jpg} % Update path to your image
    \end{scope}
}

% Define the thinkbubble command with text centered vertically on the left
\NewDocumentCommand{\thinkbubble}{O{}}{%
    \begin{tikzpicture}
        % Define the layers
        \pgfdeclarelayer{background}
        \pgfsetlayers{background,main}

        % Create a text node
        \draw (0, 1) node[align=center] (bubbleText) {#1};

        % Extract the dimensions of the bounding box
        \path (bubbleText.north east); \pgfgetlastxy{\xEast}{\yNorth};
        \path (bubbleText.south west); \pgfgetlastxy{\xWest}{\ySouth};
        % Causes: Missing character: There is no ; in font nullfont!
        % https://github.com/tectonic-typesetting/tectonic/issues/751
        
        % Calculate the width and height of the bounding box
        \pgfmathsetmacro{\bubbleWidth}{(\xEast - \xWest) / 30 + 1}
        \pgfmathsetmacro{\bubbleHeight}{(\yNorth - \ySouth) / 20 + 1}

        % Convert to lengths with units
        \edef\bubbleWidthDim{\bubbleWidth cm} % Add units
        \edef\bubbleHeightDim{\bubbleHeight cm} % Add units

        \begin{pgfonlayer}{background}
            \draw (0, 0.7) node[inner sep=0] {\includegraphics[width=\bubbleWidthDim, height=\bubbleHeightDim]{res/think-bubble.jpg}};
        \end{pgfonlayer}
    \end{tikzpicture}%
}

% Define the thinkbubbleat command with position and text
\NewDocumentCommand{\thinkbubbleat}{m m O{}}{% #1 = x position, #2 = y position, #3 = text
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=center] at (#1, #2) {\thinkbubble[#3]};
    \end{tikzpicture}%
}

%%%-------------------------------------------------------------------------
%%%   Appearance
%%%-------------------------------------------------------------------------
\setlength{\parindent}{0mm}
\setlength{\parskip}{1em}
\setlist[itemize]{noitemsep, topsep=0pt}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}

