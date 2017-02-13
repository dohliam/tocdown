# Tocdown - A table of contents generator for markdown

Tocdown is a general purpose table of contents (TOC) generator that takes markdown as input. There is a command-line version written in Ruby and a Javascript version with identical functionality that can be used in a browser.

* [1 Rationale](#rationale)
* [2 Usage](#usage)
  * [2.1 General guidelines](#general-guidelines)
  * [2.2 toc.rb](#tocrb)
    * [2.2.1 Options](#options)
    * [2.2.2 test.md](#testmd)
  * [2.3 toclib.rb](#toclibrb)
  * [2.4 toc.js](#tocjs)
    * [2.4.1 Shortcut keys](#shortcut-keys)
* [3 To do](#to-do)
* [4 Credits](#credits)
* [5 License](#license)

## Rationale

There are several existing ways to generate a table of contents from a given markdown file, but most of them focus on outputting unordered html lists, and generally lack options for tweaking the output.

The need for a flexible table of contents generator arose when it became clear that none of the available solutions were able to generate a plain text or markdown TOC in numbered [ISO 2145 format](https://en.wikipedia.org/wiki/ISO_2145).

ISO 2145 provides a specification for the numbering of divisions and subdivisions in written documents, whose format is essentially:

    1
      1.1
      1.2
        1.2.1
        1.2.2
      1.3
    2

It is possible to number the section headings in a document according to ISO 2145 format using pandoc (with the command `pandoc --number-sections`), but only for pdf or html output. It can also generate a very nice table of contents (with `pandoc --toc`), but this appears to only work for pdf output.

Tocdown generates ISO 2145-compliant tables of contents by default, though both numbering and indentation can be optionally turned off. Its non-interactive mode is also suitable for command-line piping or as part of a toolchain (for example, to automatically include a table of contents for each file in a directory).

## Usage

Tocdown comes in two versions: toc.rb (written in Ruby) and toc.js (written in Javascript), whose feature sets are identical.

### General guidelines

In markdown, heading levels are determined by the number of `#` characters at the beginning of a line. Thus, a line beginning with `# A heading` would be equivalent to `<h1>` in HTML markup, or Heading 1.

However, since Heading 1 is usually used for the title of a document, it is by default ignored in both toc.rb and toc.js. That means the top level (**TOC level 1**) is by default `##` (`<h2>`) or Heading 2, as in this README.

The above behaviour can be changed by selecting the _Include Heading 1 (Title)_ option, in which case Heading 1 will be **TOC level 1**, and Heading 2 will be **TOC level 2** etc.

It is also possible to start level numbering at zero, using the _Allow zero-level heading_ option. This means that the top level of the document (whether Heading 1 or Heading 2) will be listed as **0** in the TOC. Sub-headings will be listed as **0.1**, **0.2**, **0.3** etc. This may be useful in cases where, for example, the first heading in the document represents an Introduction or Preface, followed by Chapter or Section 1.

### toc.rb

The command-line version of tocdown can be used interactively by executing the command `./toc.rb`, or non-interactively by specifying an input filename as a parameter:

    ./toc.rb [options] [filename]

It is also possible to use the tocdown library from within a script by including the file `toclib.rb`. Further details and examples of using toclib can be found [below](#toclibrb).

#### Options

A number of options are available that change the way the output is processed or displayed. A list of all available options can be viewed by using the `--help` option:

    ./toc.rb --help

Currently, the following options are available:

* `-b`, `--bullets`: _Non-numbered headings_
* `-d`, `--heading-depth DEPTH`: _Specify maximum heading depth [between 1 and 6]_
* `-f`, `--four`: _Use four spaces instead of two for markdown indentation_
* `-i`, `--no-indent`: _Remove heading indentation_
* `-l`, `--no-links`: _Remove links to section headings_
* `-m`, `--markdown`: _Output markdown instead of plain text_
* `-t`, `--top-level`: _Include top-level heading (Heading 1 / Title)_
* `-z`, `--zero`: _Allow for zero heading or Chapter 0, e.g. Introduction, Preface etc._

Options can be combined arbitrarily, so e.g., `./toc.rb -mbi` will produce a table of contents in markdown format with non-numbered headings and no indendation.

#### test.md

If you have downloaded the source package, you can try out tocdown using the provided test.md sample file:

    ./toc.rb test.md

This will display something similar to the following text on standard output:

    1 Top-level topic
     1.1 First sub-topic
      1.1.1 First sub-sub-topic
       1.1.1.1 First sub-sub-sub-topic
        1.1.1.1.1 First sub-sub-sub-sub-topic
     1.2 Second sub-topic
     1.3 Third sub-topic
      1.3.1 A sub-sub-topic
       1.3.1.1 And a sub-sub-sub-topic
    2 Second top-level topic

If you specify markdown output with the `-m` option, you will get something like the following result instead:

    * [1 Top-level topic](#top-level-topic)
      * [1.1 First sub-topic](#first-sub-topic)
        * [1.1.1 First sub-sub-topic](#first-sub-sub-topic)
          * [1.1.1.1 First sub-sub-sub-topic](#first-sub-sub-sub-topic)
            * [1.1.1.1.1 First sub-sub-sub-sub-topic](#first-sub-sub-sub-sub-topic)
      * [1.2 Second sub-topic](#second-sub-topic)
      * [1.3 Third sub-topic](#third-sub-topic)
        * [1.3.1 A sub-sub-topic](#a-sub-sub-topic)
          * [1.3.1.1 And a sub-sub-sub-topic](#and-a-sub-sub-sub-topic)
    * [2 Second top-level topic](#second-top-level-topic)

You can try out the other options in different combinations to see how they affect the output.

### toclib.rb

For more fine-grained control, the features of tocdown can also be accessed from within a script by including the file `toclib.rb`.

A minimal example script might look like this:

    require_relative 'toclib.rb'

    text = "## Some markdown text\n\nSome more text\n\n### A sub-heading"
    md_to_toc(text)

This will return the string `"1 Some markdown text\n 1.1 A sub-heading\n"`.

You can also pass in optional parameters to get different results:

    md_to_toc(text, :markdown => true)
    md_to_toc(text, :markdown => true, :noindent => true)

### toc.js

The Javascript version of tocdown, `toc.js` was designed to have the same features and functionality as the command-line version. Since it can be accessed in a browser it is convenient for one-offs and short documents (such as this one). The output live updates when configuration options are selected, so it is also useful as a way to see the effect of different options and parameters on a given input text.

Once you have generated a table of contents, you can preview the output in [Remarkable](https://jonschlinkert.github.io/remarkable/demo/) by clicking the _View TOC in Remarkable_ button.

A fully functioning demo of toc.js can be found [here](http://dohliam.github.io/tocdown/).

#### Shortcut keys

The input and output boxes can be accessed using keyboard shortcut keys (access keys) for convenience:

* Shortcut modifier key + `.`: **Focus input textarea**
* Shortcut modifier key + `o`: **Focus output textarea**

The modifier keys you need to press will differ depending on which browser and operating system you are using. See [here](https://github.com/dohliam/xsampa#access-keys) for a list of common access keys for different browsers.

All of the options in toc.js are also accessible using access keys:

* Shortcut modifier key + `b`: **Output bulleted list instead of numbered list**
* Shortcut modifier key + `c`: **Create TOC**
* Shortcut modifier key + `d`: **Maximum heading depth selector**
* Shortcut modifier key + `i`: **Remove heading indentation**
* Shortcut modifier key + `l`: **Remove links to section headings**
* Shortcut modifier key + `m`: **Output markdown**
* Shortcut modifier key + `r`: **View TOC in Remarkable**
* Shortcut modifier key + `s`: **Sample text**
* Shortcut modifier key + `t`: **Include top-level heading (Heading 1 / Title)**
* Shortcut modifier key + `z`: **Allow for zero-level heading**

## To do
* Replace [TOC] in file with Table of Contents
* Option to output html
* Add tests

## Credits

* [mui](https://github.com/muicss/mui) CSS by @amorey ([MIT](https://github.com/muicss/mui/blob/master/LICENSE.txt)), prototyped using [dropin-minimal-css](https://github.com/dohliam/dropin-minimal-css)
* [github-corners](https://github.com/tholman/github-corners) by @tholman

## License

MIT -- see LICENSE file for details.
