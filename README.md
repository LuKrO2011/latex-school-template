# Latex templates for school worksheets and exams

The repository contains two latex templates for school: `worksheet.cls` and `exam.cls`. Both are extended from a common base template `school.cls`.

## Building

This project uses `pdflatex` to build the latex files.
`pdflatex` is available for MacOS, Linux and Windows.

- MacOS:
    ```bash
    brew cask install mactex
    ```

- Linux:
    ```bash
    sudo apt-get install texlive-full
    ```

- Windows: Download and install [MiKTeX](https://miktex.org/download)

To build the latex files, run the following command:

```bash
pdflatex <file>.tex
```

Alternatively, you can copy the files to [Overleaf](https://www.overleaf.com/) and build them online.

## Features
- Fully accessible font and colors: Helvetica is a fully accessible font and the barrier free [CUD colors](https://jfly.uni-koeln.de/color/) are predefined.
- Solutions: Solutions defined inside a `\solution{}` block are only displayed when the `solution` flag is set.
- Squares: `\squares{#rows}` can be used to create a square grid for students to write their answers.
- Think-Bubbles: `\thinkbubble[text]` can be used to create a think bubble with the given text. You can use `\phantom{text}` inside the bubble to create a blank think bubble suited for the text.


### Worksheet
- Custom header and title: The header and title is customized for worksheets. See `worksheet.tex` for an example.

### Exam
- Custom header and title: The header and title is customized for exams. The header contains a gradebox and a name field for the student to fill out. See `exam.tex` for an example.
- Tasks & Points: Tasks are automatically numbered and their points are displayed next to the task using the `\task{#points}` command. The total points are automatically calculated and can be displayed at the end of the page using the `\totalpoints` command.

