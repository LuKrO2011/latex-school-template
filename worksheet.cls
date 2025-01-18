\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[Worksheet class extending school.cls]

%%%-------------------------------------------------------------------------
%%%   Options and Base Class
%%%-------------------------------------------------------------------------
\LoadClass{school} % Load the school base class

%%%-------------------------------------------------------------------------
%%%   Default Values
%%%-------------------------------------------------------------------------
\date{\today}
\title{Set with \texttt{\textbackslash title}}

\DeclareRobustCommand\subjectarea[1]{\gdef\@subjectarea{#1}}
\subjectarea{Set with \texttt{\textbackslash subjectarea}}

%%%-------------------------------------------------------------------------
%%%   Header
%%%-------------------------------------------------------------------------

% Every page
\pagestyle{fancy} % Clear any current headers and footers
\fancyhf{} % Clear all header/footer fields

% Add the left-aligned subject area
\fancyhead[L]{\bfseries\large \@subjectarea}

% Add the right-aligned worksheet date
\fancyhead[R]{\bfseries\large \@date}

% Draw a horizontal rule across the header
\renewcommand{\headrulewidth}{1pt}

% Add the page number in the center of the footer
\fancyfoot[C]{\thepage}

% Adjust the header height
\setlength{\headheight}{14.0pt}
\addtolength{\topmargin}{-2.0pt}

% First page title
\renewcommand{\maketitle}{
    \begin{center}
        {\bfseries\LARGE \@title}
    \end{center}
}
\AtBeginDocument{\maketitle}

%%%-------------------------------------------------------------------------
%%%   Document Environment
%%%-------------------------------------------------------------------------
\newenvironment{worksheetdoc}{%
    \document
}{%
    \enddocument
}
