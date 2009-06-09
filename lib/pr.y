# -*- mode: ruby; -*-

class PlayRiteParser
  prechigh
    left FUNCALL
    right NOT
    right NEG
    left ASTER SLASH MOD
    left PLUS MINUS SCAT
    nonassoc LT GT LE GE
    nonassoc EQ NE
    left XOR
    left AND
    left OR
    left COMMA
  preclow
rule

  statements:
  | stmt
  | statements stmt

  stmt: proccall
  | call_stmt
  | assign
  | select_case
  | case
  | if
  | elseif
  | else
  | for
  | foreach
  | do
  | do_while
  | do_until
  | stmt_preamble
  | END_IF                      { result = "end" }
  | NEXT                        { result = "end"}
  | LOOP                        { result = "end" }
  | EXIT_FOR                    { result = "break"}
  | EXIT_FOREACH                    { result = "break"}
  | EXIT_DO                     { result = "break"}
  | EXIT_SUB                  { result = "return"}
  | EXIT_FUNCTION             { result = "return _prr_result" }
  | END_SELECT                  { result = "end" }
  | END_SUB                        { result = "end" }
  | END_FUNCTION                  { result = "_prr_result\r\nend"}

  if: IF expr                 { result = "if " + val[1] + " then" }
  select_case: SELECT_CASE expr           { result = "case " + val[1]}
  else: ELSE                               { result = "else"}
  elseif: ELSEIF expr                { result = "elsif " + val[1] + " then"  }
  case: CASE expr                           { result = "when " + val[1] + " then" }
  | CASE ELSE                               { result = "else" }
  for: FOR VAR_NAME EQ expr TO expr { result = "(#{val[3]}).upto(#{val[5]}) do |#{lookup_vartop(val[1])}|" }
  foreach: FOREACH VAR_NAME IN var_ref { result = "for " + lookup_vartop(val[1]) + " in " + val[3] + " do"}
  do_while: DO WHILE expr           { result = "while " + val[2] + " do" }
  do_until: DO UNTIL expr           { result = "until " + val[2] + " do" }
  do: DO                              { result = "while true do"}

  assign: assign_left EQ expr           { result = val[0] + " = " + val[2] }
  assign_left: var_or_func            { @leftlist = [val[0]] }
  | assign_left COMMA var_or_func    { @leftlist << val[2] }
  var_or_func: var_ref
  | IDENT                             { result = "_prr_result" }

  stmt_preamble: PROC IDENT decl_args { result =    "def #{val[1]}(#{val[2]})" }

  value:  LBRACE expr RBRACE      { result = val[1] }
  | STRING                          { result = '"' + val[0].to_s + '"' }
  | DIGITS                          { result = val[0].to_s }
  | var_ref
  | TRUE                            { result = "true" }
  | FALSE                           { result = "false" }
  | NIL                               { result = "nil" }

  var_ref: VAR_NAME                        { result = on_varref(val[0], nil) }
  | VAR_NAME LBRACE arglist RBRACE        { result = on_varref(val[0], @arglist); @arglist = [] }

  proccall: IDENT call_args    { result = "#{val[0]}(#{val[1]})" }
  call_stmt: CALL IDENT call_args { result = "#{val[1]}(#{val[2]})" }

  funcall: IDENT decl_args { result = "#{val[0]}(#{val[1]})" }

  decl_args:                     { result = ""; @arglist = [] }
  | LBRACE arglist RBRACE { result = @arglist.join(", "); @arglist = [] }

  call_args: arglist                     { result = @arglist.join(", "); @arglist = [] }
  | LBRACE arglist RBRACE     { result = @arglist.join(", "); @arglist = [] }

  arglist:                    { @arglist = [] }
  | expr                      { @arglist << val[0]; }
  | arglist COMMA expr         { @arglist << val[2]; }

  expr: funcall
  | value
  | NOT expr  = NOT      { result = "!" + val[1] }
  | MINUS expr = NEG    { result = "-" + val[1] }
  | binary

  binary: expr AND expr { result = val[0] + " && " + val[2] }
  | expr OR expr { result = val[0] + " || " + val[2] }
  | expr ASTER expr { result = val[0] + " * " + val[2] }
  | expr SLASH expr { result = val[0] + " / " + val[2] }
  | expr MOD expr { result = val[0] + " % " + val[2] }
  | expr XOR expr { result = val[0] + " ^ " + val[2] }
  | expr SCAT expr { result = val[0] + " + " + val[2] }
  | expr PLUS expr { result = val[0] + " + " + val[2] }
  | expr MINUS expr { result = val[0] + " - " + val[2] }
  | expr EQ expr { result = val[0] + " == " + val[2] }
  | expr NE expr { result = val[0] + " != " + val[2] }
  | expr LT expr { result = val[0] + " < " + val[2] }
  | expr GT expr { result = val[0] + " > " + val[2] }
  | expr LE expr { result = val[0] + " <= " + val[2] }
  | expr GE expr { result = val[0] + " >= " + val[2] }
end
