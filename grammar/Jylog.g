
/*
Jylog Antlr Grammar
Starting from a blank language - will move into Jython later. 

Note: The 'fragment' keyword is used to prevent a token from 
being returned by the tokenizer. 
*/


grammar Jylog;

@header {
    // import java.util.HashMap;
    // JylogParser.java:12: reference to Parser is ambiguous, 
    // both class org.antlr.runtime.Parser in org.antlr.runtime and class yprolog.Parser in yprolog match
    // public class JylogParser extends Parser {
//    import yprolog.*;
}

// @members {
    // symbol table
    // HashMap memory = new HashMap();
// }

@lexer::members {
/** Handles context-sensitive lexing of implicit line joining such as
 *  the case where newline is ignored in cases like this:
 *  a = [3,
 *       4]
 */

//For use in partial parsing.
// public boolean eofWhileNested = false;
// public boolean partial = false;
// public boolean single = false;
int implicitLineJoiningLevel = 0;
// int startPos=-1;
}


program
  : prolog_stmt+ EOF
  ;
  

// clause : pred [':-' goals] '.'
// clause
  // : p = pred (':-' g = goals)? '.'  
    // { 
      // System.out.println("clause, pred=" + $p.text + ", goals=" + $g.text);
    // }
  // ;
  

// prolog_stmt : NAME (LPAREN NAME (COMMA NAME)* RPAREN)? DOT ;
// prolog_stmt
  // :  pred = NAME DOT 
  // :  pred = NAME ( LPAREN NAME RPAREN )? DOT 
  // :  pred = NAME ( LPAREN NAME ( COMMA NAME )* RPAREN )? DOT 
  // : pred = NAME { System.out.println("prolog_stmt: " + $pred.text); }
    // ( LPAREN x=NAME { System.out.println("x: " + $x.text); } 
      // (COMMA x=NAME { System.out.println("x: " + $x.text); } )* 
      // RPAREN )? DOT 
  // ;


prolog_stmt
  : pred = NAME { System.out.println("prolog_stmt: " + $pred.text); }
    ( LPAREN x=arg { System.out.println("x: " + $x.text); } 
      (COMMA x=arg { System.out.println("x: " + $x.text); } )* 
      RPAREN )? DOT 
  ;


arg
  : var
  | NAME
  ;
  
var 
  : QUESTIONMARK x=NAME 
    {System.out.println("variable: ?" + $x.text);}
  ;


QUESTIONMARK : '?';



// jython tokens

AS        : 'as' ;
ASSERT    : 'assert' ;
BREAK     : 'break' ;
CLASS     : 'class' ;
CONTINUE  : 'continue' ;
DEF       : 'def' ;
DELETE    : 'del' ;
ELIF      : 'elif' ;
EXCEPT    : 'except' ;
EXEC      : 'exec' ;
FINALLY   : 'finally' ;
FROM      : 'from' ;
FOR       : 'for' ;
GLOBAL    : 'global' ;
IF        : 'if' ;
IMPORT    : 'import' ;
IN        : 'in' ;
IS        : 'is' ;
LAMBDA    : 'lambda' ;
ORELSE    : 'else' ;
PASS      : 'pass'  ;
PRINT     : 'print' ;
RAISE     : 'raise' ;
RETURN    : 'return' ;
TRY       : 'try' ;
WHILE     : 'while' ;
WITH      : 'with' ;
YIELD     : 'yield' ;
SELECT    : 'SELECT' ;
CAPSFROM  : 'FROM' ;
WHERE     : 'WHERE' ;
CAPSAND   : 'AND' ;
CAPSOR    : 'OR' ;
INSERT    : 'INSERT' ;
INTO      : 'INTO' ;
VALUES    : 'VALUES' ;
SIM_INT   : 'SIM_INT' ;
SIM_STR   : 'SIM_STR' ;
SIM_BOOL  : 'SIM_BOOL' ;
SIM_REQ   : 'REQUIRED' ;
SIM_INV   : 'INVERSE IS' ;
SIM_ASSIGN : ':=' ;

// Please add CAPSCLASS : 'CLASS' ; to the list of tokens in Python.g 
// if you downloaded DCjython.zip before the date of this email [4/22]. 
CAPSCLASS : 'CLASS' ;

LPAREN    : '(' {implicitLineJoiningLevel++;} ;

RPAREN    : ')' {implicitLineJoiningLevel--;} ;

LBRACK    : '[' {implicitLineJoiningLevel++;} ;

RBRACK    : ']' {implicitLineJoiningLevel--;} ;

COLON     : ':' ;

COMMA    : ',' ;

SEMI    : ';' ;

PLUS    : '+' ;

MINUS    : '-' ;

STAR    : '*' ;

SLASH    : '/' ;

VBAR    : '|' ;

AMPER    : '&' ;

LESS    : '<' ;

GREATER    : '>' ;

ASSIGN    : '=' ;

PERCENT    : '%' ;

BACKQUOTE    : '`' ;

LCURLY    : '{' {implicitLineJoiningLevel++;} ;

RCURLY    : '}' {implicitLineJoiningLevel--;} ;

CIRCUMFLEX    : '^' ;

TILDE    : '~' ;

EQUAL    : '==' ;

NOTEQUAL    : '!=' ;

ALT_NOTEQUAL: '<>' ;

LESSEQUAL    : '<=' ;

LEFTSHIFT    : '<<' ;

GREATEREQUAL    : '>=' ;

RIGHTSHIFT    : '>>' ;

PLUSEQUAL    : '+=' ;

MINUSEQUAL    : '-=' ;

DOUBLESTAR    : '**' ;

STAREQUAL    : '*=' ;

DOUBLESLASH    : '//' ;

SLASHEQUAL    : '/=' ;

VBAREQUAL    : '|=' ;

PERCENTEQUAL    : '%=' ;

AMPEREQUAL    : '&=' ;

CIRCUMFLEXEQUAL    : '^=' ;

LEFTSHIFTEQUAL    : '<<=' ;

RIGHTSHIFTEQUAL    : '>>=' ;

DOUBLESTAREQUAL    : '**=' ;

DOUBLESLASHEQUAL    : '//=' ;

DOT : '.' ;

AT : '@' ;

AND : 'and' ;

OR : 'or' ;

NOT : 'not' ;

FLOAT
    :   '.' DIGITS (Exponent)?
    |   DIGITS '.' Exponent
    |   DIGITS ('.' (DIGITS (Exponent)?)? | Exponent)
    ;

LONGINT
    :   INT ('l'|'L')
    ;

fragment
Exponent
    :    ('e' | 'E') ( '+' | '-' )? DIGITS
    ;

INT :   // Hex
        '0' ('x' | 'X') ( '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' )+
    |   // Octal
        '0'  ( '0' .. '7' )*
    |   '1'..'9' DIGITS*
    ;

COMPLEX
    :   DIGITS+ ('j'|'J')
    |   FLOAT ('j'|'J')
    ;

fragment
DIGITS : ( '0' .. '9' )+ ;

NAME:    ( 'a' .. 'z' | 'A' .. 'Z' | '_')
        ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '0' .. '9' )*
    ;



WS: (' ' | '\t' | '\n' | '\r')+ { skip(); } ;



// SINGLE_LINE_COMMENT: '%' (~('\n'|'\r'))* ('\n'|'\r'|'\r\n') { skip(); };

// ADDOP: '+' | '-' ;
// MULOP: '*' | '/' | 'mod' ;
// RELOP: '=' | 'is' | '==' | '!=' | '>' | '<' | '>=' | '<=' ;

// NUMBER:  DIGIT+ ;
// fragment DIGIT: '0'..'9';
// CHAR_LITERAL:  '\'' (~('\''|'\\'|'\n'|'\r'))* '\'';

// VAR:    (HICASE |  '_' )  ANYCHAR* ;
// ATOM:  LOCASE ANYCHAR*;
// fragment ANYCHAR: ( LOCASE | HICASE | DIGIT | '_' );
// fragment LOCASE: 'a'..'z';
// fragment HICASE: 'A'..'Z';


