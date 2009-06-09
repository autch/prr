#!/usr/bin/ruby

$KCODE = 'u'

require 'playrite_parser.rb'

parser = PlayRiteParser.new

buf = ""
while line = ARGF.gets do
  buf << line.chomp
  while /\\\\$/ =~ buf do
    line = ARGF.gets
    break unless line
    buf.gsub!(/\\\\$/, '')
    buf << line.chomp
  end
  r = parser.parse(buf)
  puts r if r
  buf = ""
end
