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
%%%   Commands and Environments
%%%-------------------------------------------------------------------------
% Switch implementation
\usepackage{xifthen}
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

\begin{switch}{\@textsize}
    \case{10}{\def\actualtextsize{10}}
    \case{11}{\def\actualtextsize{11}}
    \case{12}{\def\actualtextsize{12}}
    \case{14}{\def\actualtextsize{14.4}}
    \case{17}{\def\actualtextsize{17.28}}
    \case{}{ \def\actualtextsize{10}} % Default case (if no match)
\end{switch}

% \ifnum\@textsize=10
% \def\actualtextsize{10}
% \else\ifnum\@textsize=11
% \def\actualtextsize{11}
% \else\ifnum\@textsize=12
% \def\actualtextsize{12}
% \else\ifnum\@textsize=14
% \def\actualtextsize{14.4}
% \else\ifnum\@textsize=17
% \def\actualtextsize{17.28}
% \else
% \def\actualtextsize{10}
% \fi\fi\fi\fi\fi


\def\scriptmathsize{\numexpr\@mathsize*7/10\relax}
\def\scriptscriptmathsize{\numexpr\scriptmathsize*7/10\relax}





\LoadClass[\@textsize]{extarticle} % Pass font size to article class

\RequirePackage{fix-cm}
\AtBeginDocument{
%   \DeclareMathSizes{\@textsize}{\@mathsize}{\@mathsize}{\@mathsize}
% \DeclareMathSizes{10.95}{10}{7}{7}   % For size 10 text
% \DeclareMathSizes{11}{19}{13}{9}      % For size 11 text
% \DeclareMathSizes{12}{20}{14}{10}     % For size 12 text
% \DeclareMathSizes{14.4}{10}{8}{7}     % For size 14 text
% \DeclareMathSizes{17.28}{7}{8}{7}     % For size 17 text

\DeclareMathSizes{\actualtextsize}{\@mathsize}{\scriptmathsize}{\scriptscriptmathsize}




}
