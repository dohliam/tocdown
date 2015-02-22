#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: toc.rb [options] [input filename]"

  opts.on("-b", "--bullets", "Non-numbered headings") { options[:bullets] = true }
  opts.on("-i", "--no-indent", "Remove heading indentation") { options[:noindent] = true }
  opts.on("-m", "--markdown", "Output markdown instead of plain text") { options[:markdown] = true }
  opts.on("-z", "--zero", "Allow for zero heading (Chapter 0, e.g. Introduction, Preface etc.)") { options[:zero] = true }
end.parse!

file_name = ARGV[0]

if file_name == nil
  puts "Please enter the name of a markdown file to process"
  file_name = gets.chomp
end

if options[:zero] == true
  counter = [-1]
  counter[1..5] = [0] * (5)
else
  counter = [0] * 6
end

File.open(file_name, 'r') do |f|
  f.each_line do |line|
    next if !line.start_with?("#") { |w| line =~ /#{w}/ }

    title = line.gsub("#", "").strip

    x = line.count("#")

    counter[x - 1] += 1
    counter[x..5] = [0] * (6 - x)

    print_counter = counter.dup

    while print_counter.last == 0 && print_counter.length > 1
      print_counter.pop
    end

    if options[:noindent] == true
      indent = "" * (line.count("#") - 1)
    elsif options[:markdown] == true
      indent = "  " * (line.count("#") - 1)
    else
      indent = " " * (line.count("#") - 1)
    end


    if options[:markdown] == true
      href = title.gsub(" ", "-").gsub("\.", "").downcase
      if options[:bullets] == true
        puts indent + "* [#{title}](\##{href})"
      else
        puts indent + "* [#{print_counter.join(".")} #{title}](\##{href})"
      end
    elsif options[:bullets] == true
      puts indent + "* #{title}"
    else
      puts indent + "#{print_counter.join(".")} #{title}"
    end
  end
end
