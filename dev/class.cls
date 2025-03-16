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
    \edef\scriptmathsize{\the\numexpr (\mathsizeNumeric * 7 + 5) / 10\relax} % Round (0.7 * mathsizeNumeric)
    \edef\scriptscriptmathsize{\the\numexpr (\mathsizeNumeric * 5 + 5) / 10\relax} % Round (0.5 * mathsizeNumeric)
}

\setmathsizes  % Apply math sizes

%%%-------------------------------------------------------------------------
%%%   Load Base Class
%%%-------------------------------------------------------------------------
\LoadClass[\@textsize]{extarticle} % Pass font size to article class

\AtBeginDocument{
    \DeclareMathSizes{\actualtextsize}{\@mathsize}{\scriptmathsize}{\scriptscriptmathsize}
}
\makeatother
