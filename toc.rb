#!/usr/bin/env ruby

require 'optparse'
require_relative 'libtoc.rb'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: toc.rb [options] [input filename]"

  opts.on("-b", "--bullets", "Non-numbered headings") { options[:bullets] = true }
  opts.on("-d", "--heading-depth DEPTH", "Specify maximum heading depth (from 1 to 6)") { |d| options[:depth] = d }
  opts.on("-f", "--four", "Use four spaces instead of two for markdown indentation") { options[:four_spaces] = true }
  opts.on("-i", "--no-indent", "Remove heading indentation") { options[:noindent] = true }
  opts.on("-l", "--no-links", "Remove links to section headings") { options[:nolinks] = true }
  opts.on("-m", "--markdown", "Output markdown instead of plain text") { options[:markdown] = true }
  opts.on("-t", "--top-level", "Include top-level heading (Heading 1 / Title)") { options[:top_level] = true }
  opts.on("-z", "--zero", "Allow for zero heading (Chapter 0, e.g. Introduction, Preface etc.)") { options[:zero] = true }
  opts.on("-r", "--replace-in-file", "Place the toc in the file it self. <!-- TocDown Begin --> and <!-- TocDown End --> are required to be present in the file.") { options[:replace] = true } 
  opts.on("-s", "--scan-after-marker", "Only scan for headers after <!-- TocDown Begin --> markers") { options[:scanmarker] = true }
end.parse!

filename = ARGV[0]

text = validate_file(filename)
toc = md_to_toc(text, options)
write_file(toc,filename) if options[:replace] == true
puts toc
