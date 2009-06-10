require "pr.tab.rb"
require "playrite_scanner.rb"

class PlayRiteParser
  def initialize
    @scanner = PlayRiteScanner.new
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

#################
# symbol handling

  def lookup_vartop(ident)
    case ident
    when /^%/ then ident.gsub(/^%/, '').downcase
    when /^\$/ then ident
    end
  end

#################
# runtime

  def on_varref(ident, dimensions)
    v = lookup_vartop(ident)
    if dimensions then
      v << dimensions.map{|i| "[#{i}]"}.join
    end
    v
  end
end
