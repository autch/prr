
require "strscan"

class PlayRiteScanner
  attr_reader :tokens
  attr_reader :str
  
  KEYWORDS = %W(end\ sub end\ function
    exit\ sub exit\ function
    exit\ for exit\ foreach exit\ do
    exit
    select\ case case end\ select
    if elseif else end\ if
    call
    for foreach to in next
    do while until loop
    true false nil
    sub function
  )

  SYMBOLS = [ [',', :COMMA], ['(', :LBRACE], [')', :RBRACE],
    ['>=', :GE], ['<=', :LE], ['<>', :NE, '!='], ['=', :EQ, '=='], ['<', :LT], ['>', :GT],
    ['and', :AND, '&&'], ['or', :OR, '||'], ['xor', :XOR, '^'], ['not', :NOT, '!'],
    ['mod', :MOD, '%'],
    ['*', :MUL], ['/', :DIV], ['+', :ADD], ['&', :CAT, '+'], ['-', :SUB]
  ]

  def initialize
    @tokens = []
    @str = ""
    @re_keywords = Regexp.union(*KEYWORDS.map{|i| /\A#{i}\b/i })
    @re_symbols = Regexp.union(*SYMBOLS.map{|i| /#{Regexp.quote i[0]}/i })
  end

  def kw_to_token
    if len = @scan.match?(@re_keywords) then
      kw = @scan[0].downcase
      @scan.pos += len
      [kw.gsub(/ /, '_').upcase.intern, kw]
    end
  end

  def sym_to_token
    if len = @scan.match?(@re_symbols) then
      sym = @scan[0].downcase
      _, token, expr = *SYMBOLS.assoc(sym)
      @scan.pos += len
      [token, expr ? expr : sym]
    end
  end

  def parse(str)
    @tokens = []
    @str = str

    puts if str.empty?
    m = /^\s+/.match(str).to_a.first.to_s
    print m

    @scan = StringScanner.new(str)
    until @scan.eos? do
      case
      when @scan.scan(/\A(\s*)\!\!(.*)\Z/)
        #puts '#' + @scan[1]
        @tokens.push [:COMMENT, @scan[1] + '#' + @scan[2]]
      when @scan.scan(/\A([ \r\n\t\x1a]+)/)
        # eat up all spaces
      when @scan.scan(/\A(-?\d+(\.\d+)?(e[-+]\d+)?|&[HO][0-9a-f]+)&?/i)
        @tokens.push [:DIGITS, @scan[0]]
      when @scan.scan(/\A\"(.*?)\"/) then
        @tokens.push [:STRING, @scan[1]]
      when @scan.scan(/\A[$%]\w+\b/) then
        @tokens.push [:VAR_NAME, @scan[0]]
      else
        token = kw_to_token
        token = token || sym_to_token
        if token then
          @tokens.push token
        else
          if @scan.scan(/\A\w+\b/) then
            @tokens.push [:IDENT, @scan[0]]
          else
            p @scan.rest
            raise
          end
        end
      end
    end

    @tokens.push [:EOS, 'EOS']
    @tokens.push [false, '$end']
  end

  def next_token
    @tokens.shift
  end
end
