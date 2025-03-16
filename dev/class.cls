\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{class}[Development]
\RequirePackage{xkeyval} % Key-value parsing for options

%%%-------------------------------------------------------------------------
%%%   Options
%%%-------------------------------------------------------------------------

% Default values
\def\@textsize{12pt}   % Default text font size
\def\@mathsize{12pt}   % Default math font size

% Custom font-size option (renamed to textsize)
\DeclareOptionX{textsize}{\edef\@textsize{#1}} % Renamed to textsize
\DeclareOptionX{mathsize}{\edef\@mathsize{#1}} 

\ProcessOptionsX\relax  % Process options before using them

%%%-------------------------------------------------------------------------
%%%   Strip 'pt' and Set Numerical Values
%%%-------------------------------------------------------------------------
\makeatletter
% Extract the numeric value from \@textsize (strip 'pt')
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
    \ifnum\mathsizeNumeric=10
        \def\scriptmathsize{7} \def\scriptscriptmathsize{5} 
    \fi
    \ifnum\mathsizeNumeric=11
        \def\scriptmathsize{8} \def\scriptscriptmathsize{6} 
    \fi
    \ifnum\mathsizeNumeric=12
        \def\scriptmathsize{8.4} \def\scriptscriptmathsize{6} 
    \fi
    \ifnum\mathsizeNumeric=14
        \def\scriptmathsize{10} \def\scriptscriptmathsize{7} 
    \fi
    \ifnum\mathsizeNumeric=17
        \def\scriptmathsize{12} \def\scriptscriptmathsize{8} 
    \fi
}

\setmathsizes  % Apply math sizes

%%%-------------------------------------------------------------------------
%%%   Load Base Class
%%%-------------------------------------------------------------------------
\LoadClass[\@textsize]{extarticle} % Pass font size to article class

\RequirePackage{fix-cm}
\AtBeginDocument{
    \DeclareMathSizes{\actualtextsize}{\@mathsize}{\scriptmathsize}{\scriptscriptmathsize}
}
\makeatother
