# tocdown - A table of contents generator for markdown

tocdown is a general purpose table of contents generator that takes markdown as input. There is a command-line version written in Ruby and a Javascript version with identical functionality that can be used in a browser.

* [1 Rationale](#rationale)
* [2 Usage](#usage)
  * [2.1 toc.rb](#tocrb)
    * [2.1.1 Options](#options)
    * [2.1.2 test.md](#testmd)
  * [2.2 toc.js](#tocjs)
* [3 To do](#to-do)
* [4 Credits](#credits)
* [5 License](#license)

## Rationale

There are several existing ways to generate a table of contents from a given markdown file, but most of them focus on outputting unordered html lists, and generally lack options for tweaking the output.

The need for a flexible table of contents generator arose when it became clear that none of the available solutions were able to generate a plain text or markdown TOCs in numbered [ISO 2145 format](https://en.wikipedia.org/wiki/ISO_2145).

ISO 2145 provides a specification for the numbering of divisions and subdivisions in written documents, whose format is essentially:

    1
      1.1
      1.2
        1.2.1
        1.2.2
      1.3
    2

It is possible to number the section headings in a document according to ISO 2145 format using pandoc (with the command `pandoc --number-sections`), but only for pdf or html output. It can also generate a very nice table of contents (with `pandoc --toc`), but this appears to only work for pdf output.

tocdown generates ISO 2145-compliant tables of contents by default, though both numbering and indentation can be optionally turned off. Its non-interactive mode is also suitable for command-line piping or as part of a toolchain (for example, to automatically include a table of contents for each file in a directory).

## Usage

tocdown comes in two versions: toc.rb (written in Ruby) and toc.js (written in Javascript), whose feature sets are identical.

## toc.rb

The command-line version of tocdown can be used interactively by executing the command `./toc.rb`, or non-interactively by specifying an input filename as a parameter:

    ./toc.rb [options] [filename]

### Options

A number of options are available that change the way the output is processed or displayed. A list of all available options can be viewed by using the `--help` option:

    ./toc.rb --help

Currently, the following options are available:

* `-b`, `--bullets` (Non-numbered headings)
* `-d`, `--heading-depth DEPTH` (Specify maximum heading depth [between 1 and 6])
* `-i`, `--no-indent` (Remove heading indentation)
* `-l`, `--no-links` (Remove links to section headings)
* `-m`, `--markdown` (Output markdown instead of plain text)
* `-z`, `--zero` (Allow for zero heading or Chapter 0, e.g. Introduction, Preface etc.)

Options can be combined arbitrarily, so e.g., `./toc.rb -mbi` will produce a table of contents in markdown format with non-numbered headings and no indendation.

### test.md

If you have downloaded the source package, you can try out tocdown using the provided test.md sample file:

    ./toc.rb test.md

This will display the following text on standard output:

    1 Top-level topic
     1.1 First sub-topic
     1.2 Second sub-topic
      1.2.1 First sub-sub-topic
     1.3 Third sub-topic
      1.3.1 A sub-sub-topic
       1.3.1.1 And a sub-sub-sub-topic
    2 Third top-level topic

If you specify markdown output with the `-m` option, you will get the following result instead:

    * [1 Top-level topic](#top-level-topic)
      * [1.1 First sub-topic](#first-sub-topic)
      * [1.2 Second sub-topic](#second-sub-topic)
        * [1.2.1 First sub-sub-topic](#first-sub-sub-topic)
      * [1.3 Third sub-topic](#third-sub-topic)
        * [1.3.1 A sub-sub-topic](#a-sub-sub-topic)
          * [1.3.1.1 And a sub-sub-sub-topic](#and-a-sub-sub-sub-topic)
    * [2 Seond top-level topic](#third-top-level-topic)


## toc.js

The Javascript version of tocdown, `toc.js` was designed to have the same features and functionality as the command-line version. Since it can be accessed in a browser it is convenient for one-offs and short documents. The output live updates when configuration options are selected, so it is also useful as a way to see the effect of different options and parameters on a given output.

Once you have generated a table of contents, you can preview the output in [Remarkable](https://jonschlinkert.github.io/remarkable/demo/) by clicking the _View TOC in Remarkable_ button.

A demo of toc.js can be found [here](http://dohliam.github.io/tocdown/).

## To do
* Replace [TOC] in file with Table of Contents
* Option to output html

## Credits

* [mui](https://github.com/muicss/mui) CSS by @amorey ([MIT](https://github.com/muicss/mui/blob/master/LICENSE.txt)), prototyped using [dropin-minimal-css](https://github.com/dohliam/dropin-minimal-css)
* [github-corners](https://github.com/tholman/github-corners) by @tholman

## License

MIT -- see LICENSE file for details.
