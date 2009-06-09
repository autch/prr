# To change this template, choose Tools | Templates
# and open the template in the editor.

class PlayRiteScanner
  attr_reader :tokens
  attr_reader :str
  
  def initialize
    @tokens = []
    @str = ""
  end

  def symbolize(s)
    s.downcase.intern
  end

  def parse(str)
    @tokens = []
    @str = str
    puts if str.empty?
    m = /^\s+/.match(str).to_a.first.to_s
    print m
    until str.empty?
      case str
      when /\A\!\!(.*)\Z/
        puts '#' + $1
      when /\A([ \r\n\t]+)/
      when /\A(-?\d+(\.\d+)?(e[-+]\d+)?|&[HO][0-9a-f]+)&?/i
        @tokens.push [:DIGITS, $&]
      when /\A[(]/ then    @tokens.push [:LBRACE, "("]
      when /\A[)]/ then       @tokens.push [:RBRACE, ")"]
      when /\A(Sub|Function)\b/i then      @tokens.push [:PROC, symbolize($1)]
      when /\ATo\b/i then @tokens.push [:TO, $&]
      when /\AIn\b/i then @tokens.push [:IN, $&]
      when /\AIf\b/i then @tokens.push [:IF, $&]
      when /\AEnd Sub\b/i then      @tokens.push [:END_SUB, $&]
      when /\AEnd Function\b/i then @tokens.push [:END_FUNCTION, $&]
      when /\AExit Sub\b/i then     @tokens.push [:EXIT_SUB, $&]
      when /\AExit Function\b/i then @tokens.push [:EXIT_FUNCTION, $&]
      when /\AExit For\b/i then     @tokens.push [:EXIT_FOR, $&]
      when /\AExit ForEach\b/i then     @tokens.push [:EXIT_FOREACH, $&]
      when /\AExit Do\b/i then      @tokens.push [:EXIT_DO, $&]
      when /\AExit\b/i then       @tokens.push [:EXIT, $&]
      when /\ACase\b/i then       @tokens.push [:CASE, $&]
      when /\ASelect Case\b/i then       @tokens.push [:SELECT_CASE, $&]
      when /\AEnd Select\b/i then       @tokens.push [:END_SELECT, $&]
      when /\AElse\b/i then       @tokens.push [:ELSE, $&]
      when /\AElseIf\b/i then       @tokens.push [:ELSEIF, $&]
      when /\AEnd If\b/i then       @tokens.push [:END_IF, $&]
      when /\ACall\b/i then       @tokens.push [:CALL, $&]
      when /\AFor\b/i then      @tokens.push [:FOR, $&]
      when /\AForEach\b/i then      @tokens.push [:FOREACH, $&]
      when /\AStep\b/i then      @tokens.push [:STEP, $&]
      when /\ANext\b/i then      @tokens.push [:NEXT, $&]
      when /\ADo\b/i then       @tokens.push [:DO, $&]
      when /\AWhile\b/i then       @tokens.push [:WHILE, $&]
      when /\AUntil\b/i then       @tokens.push [:UNTIL, $&]
      when /\ALoop\b/i then      @tokens.push [:LOOP, $&]
      when /\ATrue\b/i then      @tokens.push [:TRUE, $&]
      when /\AFalse\b/i then      @tokens.push [:FALSE, $&]
      when /\ANil\b/i then      @tokens.push [:NIL, $&]
      when /\A\"(.*?)\"/ then       @tokens.push [:STRING, $1]
      when /\A,/ then       @tokens.push [:COMMA, ',']
      when /\A>=/ then       @tokens.push [:GE, '>=']
      when /\A<=/ then       @tokens.push [:LE, '<=']
      when /\A<>/ then       @tokens.push [:NE, '<>']
      when /\A=/ then       @tokens.push [:EQ, '=']
      when /\A</ then       @tokens.push [:LT, '<']
      when /\A>/ then       @tokens.push [:GT, '>']
      when /\AAnd\b/i then       @tokens.push [:AND, '&&']
      when /\AOr\b/i then       @tokens.push [:OR, '||']
      when /\ANot\b/i then       @tokens.push [:NOT, '!']
      when /\AXor\b/i then        @tokens.push [:XOR, '^']
      when /\AMod\b/i then       @tokens.push [:MOD, '%']
      when /\A\&/i then       @tokens.push [:SCAT, '&']
      when /\A[*]/ then       @tokens.push [:ASTER, '*']
      when /\A\// then       @tokens.push [:SLASH, '/']
      when /\A[+]/ then       @tokens.push [:PLUS, '+']
      when /\A-/ then        @tokens.push [:MINUS, '-']
      when /\A[$%]\w+\b/ then  @tokens.push [:VAR_NAME, $&]
      when /\A\w+\b/ then    @tokens.push [:IDENT, $&]
      end
      str = $'
      break unless str
    end
    @tokens.push [false, '$end']
  end

  def next_token
    @tokens.shift
  end
end
