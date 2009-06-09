require "pr.tab.rb"
require "playrite_scanner.rb"

class PlayRiteParser
  def initialize
    @scanner = PlayRiteScanner.new
    @globals = {}
    @locals = {}
  end

  def on_error(error_token_id, error_value, value_stack)
    p [@scanner.str, value_stack, [token_to_str(error_token_id).intern, error_value]]
    raise ParseError
  end

  def parse(str)
    @scanner.parse(str)
    do_parse
  end

  def next_token
    @scanner.next_token
  end

  def dump_vars
    p @globals
    p @locals
  end

#################
# symbol handling

  def typeize(i)
    case i
    when String
      "\"#{i}\""
    when Array
      case i[0]
      when :v_ref
        i[1].to_s
      end
    else
      i.to_s
    end
  end

  def lookup_vartop(ident)
    case ident
    when /^%/ then "\$locals['#{ident}']"
    when /^\$/ then "\$globals['#{ident}']"
    end
  end

#################
# runtime

  def on_proccall(ident, call_args)
    print "#{ident}("
    print call_args.map{|i| typeize(i) }.join(", ")
    print ")\n"
  end

  def on_def(ident, def_args)
    print "def #{ident}("
    print def_args.map{|arg| arg[1] }.join(", ")
    print ")\n"
  end

  def on_varref(ident, dimensions)
    print lookup_vartop(ident)
  end

  def on_assign(ident, value)
    print lookup_vartop(ident), " = "
    print typeize(value)
  end
end