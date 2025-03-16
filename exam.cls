\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exam}[Exam class extending school.cls]

%%%-------------------------------------------------------------------------
%%%   Options and Base Class
%%%-------------------------------------------------------------------------
\LoadClassWithOptions{school}

\newif\ifpointsplaceholder
\pointsplaceholdertrue

% Define points placement setting
\newcommand{\pointsplacement}{inplace}

\DeclareOption{nopointsplaceholder}{\pointsplaceholderfalse}

% Currently only left is supported
\DeclareOption{points=left}{\renewcommand{\pointsplacement}{left}}
\DeclareOption{points=right}{\renewcommand{\pointsplacement}{right}}
\DeclareOption{points=inplace}{\renewcommand{\pointsplacement}{inplace}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\def\@boxoffset{-0cm}
\DeclareOptionX{boxoffset}{\edef\@boxoffset{#1}}

\ProcessOptions\relax
\ProcessOptionsX\relax

\geometry{
    includehead,
    a4paper, 
    left=30mm, % Add more space to the left
    top=10mm, 
    right=20mm, 
    bottom=20mm
}


%%%-------------------------------------------------------------------------
%%%   Default Values
%%%-------------------------------------------------------------------------
\date{\today}
\title{Set with \texttt{\textbackslash title}}

\DeclareRobustCommand\class[1]{\gdef\@class{#1}}
\class{Set with \texttt{\textbackslash class}}
\DeclareRobustCommand\notes[1]{\gdef\@notes{#1}}
\notes{Set with \texttt{\textbackslash notes}}

%%%-------------------------------------------------------------------------
%%%   Points
%%%-------------------------------------------------------------------------

% Define counters for tasks and points
\newtotcounter{TaskCounter}
\newtotcounter{PointsCounter}

% Add a placeholder command
\newcommand{\placeholder}{\rule{0.5cm}{0.4pt}}

% Add a command for displaying the points (placeholder/total)
\newcommand{\points}[1]{%
    \ifpointsplaceholder
        \textbf{\placeholder / #1}%
    \else
        \textbf{#1}%
    \fi
}

% Sidebox on the first page
\newcommand{\sideboxfirstpage}{
    \begin{tikzpicture}[remember picture, overlay]        
        % \draw[thick] (-2cm, 2cm) rectangle ($(current page.south west) + (2.8cm, 2cm)$);
        \draw[thick] (-0.7cm, 1cm) rectangle ($(current page.south west) + (0.8cm, 2cm)$);
    \end{tikzpicture}%
}

% Sidebox on other pages
\newcommand{\sideboxotherpage}{%
    \begin{tikzpicture}[remember picture, overlay]
        \draw[thick] (current page.north west) ++(0.8cm,-2cm) rectangle ++(1.5cm,-\textheight);
    \end{tikzpicture}%
}

\AddEverypageHook{%
    \ifthenelse{\equal{\thepage}{1}}{}{\sideboxotherpage}%
}

% Define a Aufgabe - section with a node for alignment
\newcommand{\taskwithpoints}{%
    \section*{\hspace{-0.3em}%
        \tikz[remember picture, baseline=(task-title.base)] 
        \node (task-title) {Aufgabe \theTaskCounter}; % Create a TikZ node for alignment
    }\vspace{-1.5em}%
}

% Define a boxat; params: anchor, content, xshift, yshift
\newcommand{\boxat}[4]{%
    \begin{tikzpicture}[overlay, remember picture]
        \node[anchor=#1, fill=gray!20, draw=black, rounded corners=2pt,
              inner sep=4pt, font=\small, xshift=#3, yshift=#4,
              minimum width=1.25cm, align=center]
        at ($(task-title.base)$)
        {#2};
    \end{tikzpicture}%
}

% Define the points box for the task
\newcommand{\pointsbox}[2]{%
    \edef\offset{\dimexpr -3.2cm - \@boxoffset}
    \ifthenelse{\equal{#2}{left}}{
        \boxat{west}{\points{#1}}{\offset}{0.4em}
    }{
        \boxat{west}{\points{#1}}{12cm}{0.4em}
    }
    \hspace{-0.74cm}
}

% Define a inplace-layout for the points
\newcommand{\pointsinplace}[1]{%
    \section*{Aufgabe \theTaskCounter{} (\points{#1})}
}

% Define the "task" command
\newcommand{\task}[1]{%
    \stepcounter{TaskCounter} % Increment task counter
    \addtocounter{PointsCounter}{#1} % Add points to the total counter
    \taskwithpoints % Add the task with the points box
    \ifthenelse{\equal{\theTaskCounter}{1}}{\sideboxfirstpage}{}%
    \begin{switch}{\pointsplacement}
        \case{left}{\pointsbox{#1}{left}} % Left placement
        \case{right}{\pointsbox{#1}{right}} % Right placement
        \case{inplace}{\pointsinplace{#1}} % Inplace placement
    \end{switch}
}

% Define the "totalpoints" command to summarize the total number of points
\newcommand{\totalpoints}{%
    \begin{switch}{\pointsplacement}
        \case{left}{
            \begin{tikzpicture}[overlay, remember picture]
                \node[anchor=south, fill=gray!20, draw=black, rounded corners=2pt, 
                    inner sep=4pt, font=\small, xshift=0, yshift=0, minimum width=1.25cm] 
                at ($(current page.south west) + (1.55cm, 2.7cm)$)
                {\textbf{\points{\total{PointsCounter}}}};
            \end{tikzpicture}%
        }
        \case{right}{
            \boxat{west}{\points{\total{PointsCounter}}}{12cm}{-5em}
        }
        \case{inplace}{
            \textbf{\points{\total{PointsCounter}}}
        }
    \end{switch}
}

%%%-------------------------------------------------------------------------
%%%   Header
%%%-------------------------------------------------------------------------

% Grade box
\newcommand{\gradebox}{%
    \begin{tikzpicture}[remember picture, baseline]
        \node[anchor=base east, font=\small, draw=black, thick, rectangle, inner sep=2pt, minimum size=2cm] {};
    \end{tikzpicture}%
}

% Name placeholder
\newcommand{\nameplaceholder}{%
    \rule{8.5cm}{0.1mm}\hspace{1cm}
}

% Name field
\newcommand{\namefield}{%
    \textbf{Name:} \nameplaceholder
}

% Define custom header style for the first page
\renewcommand{\maketitle}{
    \begin{minipage}[t]{0.25\textwidth}
        \phantom{T}
    \end{minipage}
    \begin{minipage}[t]{0.5\textwidth}
        \centering
        \hspace{-1cm}\textbf{\@title} \\
        \hspace{-1cm}\textbf{am \@date} \\
        \hspace{-1cm}\textbf{\@class} \\
    \end{minipage}
    \begin{minipage}[t]{0.25\textwidth}
        \raggedleft
        \gradebox
    \end{minipage}

    \vspace{1cm}
    Beachte:
    \@notes
}
\AtBeginDocument{\maketitle}

%%%-------------------------------------------------------------------------
%%%   Document Environment
%%%-------------------------------------------------------------------------
\newenvironment{examdoc}{%
    \document
}{%
    \enddocument
}