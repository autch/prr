#!/usr/bin/ruby

$KCODE = 'u'

require 'playrite_parser.rb'

parser = PlayRiteParser.new

buf = ""
while line = ARGF.gets do
  buf << line.strip
  while /\\\\$/ =~ buf do
    line = ARGF.gets
    break unless line
    buf.gsub!(/\\\\$/, '')
    buf << line.strip
  end
  r = parser.parse(buf)
  p(r) if r
  buf = ""
end

parser.dump_vars
