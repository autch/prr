#!/usr/bin/ruby

$KCODE = 'u'

require 'playrite_runtime.rb'
include PlayRiteRuntime

if $0 == __FILE__ then
  code = ARGF.read
  eval code, TOPLEVEL_BINDING, ARGF.filename, 1

  Gtk.main
end
