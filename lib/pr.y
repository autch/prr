# -*- mode: ruby; -*-

class PlayRiteParser
  prechigh
    left FUNCALL
    right NOT
    left ASTER SLASH MOD
    left PLUS MINUS
    nonassoc LT GT LE GE
    nonassoc EQ NE
    left XOR
    left AND
    left OR
    left COMMA
  preclow
rule
  top:
  | module_definition
  | top module_definition
  
  module_definition: statements
  | stmt_preamble
  | end_something

  statements:
  | stmt
  | statements stmt

  stmt:
  | proccall                      { result = [:pc, val]; on_proccall(val[0][0], val[0][1]) }
  | call_stmt                     { result = [:call, val]; on_proccall(val[0][0], val[0][1]) }
  | assign                        { result = [:assign, val]  }
  | select_case                  { @case = [[:select, val]] }
  | case                          { @case << [:case, val]    }
  | if                            { result = [:if, val]      }
  | elseif                        { result = [:elif, val]      }
  | else                          { result = [:else]      }
  | for                           { result = [:for, val] }
  | END_IF
  | NEXT
  | do                          { result = [:do, val] }
  | LOOP
  | EXIT_FOR
  | EXIT_DO
  | EXIT_SUB
  | EXIT_FUNCTION
  | EXIT
  | END_SELECT                  { result = @case }
    
  if: IF expr                 { result = val[1] }
  select_case: SELECT_CASE expr           { result = val[1]}
  else: ELSE
  elseif: ELSE IF expr                { result = val[1] }
  case: CASE expr                           { result = val[1] }
  | CASE ELSE
  for: FOR assign TO expr step              {result = [val[1], val[2], val[3]]}
  step:
  | step expr                               { result = val[1]}
  do: DO condition                          { result = val[1] }
  condition:
  | edge expr                      { result = val}
  edge: WHILE
  | UNTIL

  assign: assign_left EQ expr           { result = on_assign(val[0], val[2]) }
  assign_left: var_or_func            { @leftlist = [val[0]] }
  | assign_left COMMA var_or_func    { @leftlist << val[2] }
  var_or_func: var_ref
  | IDENT

  stmt_preamble: PROC IDENT decl_args { result = val; on_def(val[1], val[2]) }
  end_something: END_SUB
  | END_FUNCTION

  value:  LBRACE expr RBRACE      { result = val[1] }
  | STRING                          { result = val[0].to_s }
  | DIGITS                          { result = val[0].to_i }
  | var_ref
  | TRUE                            { result = true }
  | FALSE                           { result = false }
  | NIL                               { result = nil}

  var_ref: VAR_NAME var_args        { result = on_varref(val[0], val[1]) }
  | VAR_NAME                        { result = on_varref(val[0], nil) }
  var_args: LBRACE arglist RBRACE  { result = @arglist; @arglist = [] }

  proccall: IDENT call_args    { result = [val[0], val[1]]}
  call_stmt: CALL IDENT call_args { result = [val[1], val[2]]}

  funcall: IDENT call_args { result = [:fc, val[0], val[1]]; on_proccall(val[0], val[1]) }

  decl_args:                     { result = []; @arglist = [] }
  | LBRACE arglist RBRACE { result = @arglist; @arglist = [] }

  call_args: arglist                     { result = @arglist; @arglist = [] }
  | LBRACE arglist RBRACE     { result = @arglist; @arglist = [] }

  arglist:                    { @arglist = [] }
  | expr                      { @arglist << val[0]; }
  | arglist COMMA expr         { @arglist << val[2]; }

  expr: funcall     = FUNCALL      { result = val[0] }
  | NOT expr  = NOT      { result = !val[1] }
  | binary             { result = val[0] }
  | value             { result = val[0] }

  binary: expr EQ expr { result = val[0] == val[2] }
  | expr NE expr { result = val[0] != val[2] }
  | expr LT expr { result = val[0] < val[2] }
  | expr GT expr { result = val[0] > val[2] }
  | expr LE expr { result = val[0] <= val[2] }
  | expr GE expr { result = val[0] >= val[2] }
  | expr AND expr { result = val[0] && val[2] }
  | expr OR expr { result = val[0] || val[2] }
  | expr XOR expr { result = val[0] ^ val[2] }
  | expr SCAT expr { result = "#{val[0]}#{val[2]}" }
  | expr PLUS expr { result = val[0] + val[2] }
  | expr MINUS expr { result = val[0] - val[2] }
  | expr ASTER expr { result = val[0] * val[2] }
  | expr SLASH expr { result = val[0] / val[2] }
  | expr MOD expr { result = val[0] % val[2] }
end
