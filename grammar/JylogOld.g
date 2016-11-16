
/*
Grammar for Jylog
Starting from a blank language - will move into Jython later. 

Overview of the grammar - adapted from XProlog's JavaCC grammar:
[ugh, I'm sure we don't need this much]

program    : clause+ EOF
clause     : pred [':-' goals] '.'
primitives : primitive+ EOF
primitive  : goal [':=' NUMBER | ':-' goals] '.'
goals      : goal (',' goal)*
pred       : ATOM [ '(' arglist ')' ]
           | CHAR_LITERAL
arglist    : arg (',' arg)*
goal       : '(' goal_list [ '->' goal_list ] [ ';' goal_list ] ')'
           | arg
           | '!'
goal_list  : goal (',' goal)*
arg        : sum (RELOP sum)*
sum        : factor (ADDOP factor)*
factor     : operand (MULOP operand)*
operand    : pred
           | VAR
           | NUMBER
           | list
list       : '[' listElems? ']'
listElems  : arglist [ '|' arg ]


Tokens
Note: The 'fragment' keyword is used to prevent a token from 
being returned by the tokenizer. 

WS: (' ' | '\t' | '\n' | '\r')+ { skip(); } ;
SINGLE_LINE_COMMENT: '%' (~('\n'|'\r'))* ('\n'|'\r'|'\r\n') { skip(); };
ADDOP: '+' | '-' ;
MULOP: '*' | '/' | 'mod' ;
RELOP: '=' | 'is' | '==' | '!=' | '>' | '<' | '>=' | '<=' ;
NUMBER:  DIGIT+ ;
fragment DIGIT: '0'..'9';
CHAR_LITERAL:  '\'' (~('\''|'\\'|'\n'|'\r'))* '\'';
VAR:    (HICASE |  '_' )  ANYCHAR* ;
ATOM:  LOCASE ANYCHAR*;
fragment ANYCHAR: ( LOCASE | HICASE | DIGIT | '_' );
fragment LOCASE: 'a'..'z';
fragment HICASE: 'A'..'Z';


*/



grammar Jylog;

@header {
    import java.util.HashMap;


    // JylogParser.java:12: reference to Parser is ambiguous, 
    // both class org.antlr.runtime.Parser in org.antlr.runtime and class yprolog.Parser in yprolog match
    // public class JylogParser extends Parser {

//    import yprolog.*;
}


@members {
    // symbol table
    HashMap memory = new HashMap();
}




// Rules
//------------------------------------------------------------------------


// a program is a list of clauses
// void Program( KnowledgeBase kb ) :
// {
    // ( clause(kb))+ <EOF>
// }


// so i guess xprolog passes the kb into the parser here, 
// so that different rules can add stuff to the kb, etc. 

// program : clause+ EOF
program [ yprolog.YProlog kb ]
  : clause+ EOF
  ;
  

    
// void clause( KnowledgeBase kb ) :
// { Term  head;
  // TermList body= null;
  // Clause c;
// }
    // {   { resetVDict();  }
    
        // head = pred() [ ":-" body = goals() ] "."
        
        // { c = new Clause( head, body);
          // kb.addClause( c );
          // System.out.println("Clause: " + c);
        // }
    // }


// clause : pred [':-' goals] '.'
clause
  : p = pred (':-' g = goals)? '.'  
    { 
      // Prolog.Clause
      System.out.println("clause, pred=" + $p.text + ", goals=" + $g.text);
    }
  ;
  

// void primitives(KnowledgeBase kb) :
    // {
        // ( primitive(kb))+ <EOF>
    // }

// primitives : primitive+ EOF
primitives
  : primitive+ EOF
  ;
  


// void primitive(KnowledgeBase kb) :
// { 
    // Term  head;
    // Token tok=null;
    // boolean opt = true;
    // TermList body = null;
// }
// {   { resetVDict();  }

    // head = goal() 
    // [ ":="  tok = <NUMBER>  { 
    		// kb.addPrimitive( new Clause( head, new Primitive(tok.image)));
    		// opt = false;
    	// }
    	
    // | ":-"  body = goals()  {
    		// kb.addPrimitive( new Clause( head, body));
    		// opt = false;
    	// }
    // ] "."
    
    // { if (opt) kb.addPrimitive( new Clause( head, null)); }
    
// }

// primitive  : goal [':=' NUMBER | ':-' goals] '.'
primitive
  : goal (':=' NUMBER | ':-' goals)? '.'
  ;


// TermList goals() :
// {
    // Term t;
    // TermList head, last, p;
// }
    // {
        // t = goal() { head = last = new TermList(t) ; }        
        // ( "," t = goal() 
            // {
                // last.next = p = new TermList( t );
                // last = p;
            // }
        // )*
        // { return head; }
    // }

// goals      : goal (',' goal)*
goals
  : goal (',' goal)*
  ;


// Term pred() :
// {
    // Token  op;
    // Vector v = new Vector() ;
// }
// {
    // op = <ATOM> [ "(" arglist( v ) ")" ]
    
    // {
        // int arity = v.size();
        // Term terms[] = new Term [arity];
        // for (int i = 0 ; i < arity ; i++)
            // terms[i] = (Term) v.elementAt(i);
        // return new Term( op.image.intern(), terms );
    
    // }
  // |
    // op = <CHAR_LITERAL>
      // {
	// String s = op.image;
	// return new Term( s.substring(1,s.length()-1).intern(),0);
       // }
// }

// pred       : ATOM [ '(' arglist ')' ]
//            | CHAR_LITERAL
pred
  : ATOM ( '(' arglist ')' )?
  | CHAR_LITERAL
  ;


// void arglist( Vector v) :
// {
    // Term t;
// }
    // {
        // t = arg()       { v.addElement( t ); }
        // ( "," 
          // t = arg()     { v.addElement( t ); }
        // )*
    // }

// arglist    : arg (',' arg)*
arglist
  : arg (',' arg)*
  ;


// Term goal() :
// {
    // Term x;  
    // Term s1=null, 
	// s2=null,
	// s3=null;
// }
// {
    // "(" s1 = goal_list()
	    // [ "->" s2 = goal_list() ]
	    // [ ";"  s3 = goal_list() ]
    // ")"
 
    // {  if ( s2==null && s3 == null) 
       // {
    		// x = new Term("seq",1); x.setarg(0,s1);
    		// return x;
       // }	
       // else if ( s2 == null) return new Term( "or", s1, s3); 
       // else if ( s3 == null) return new Term( "if", s1, s2);
       // else {
	   // Term ts[]= new Term[3];
	   // ts[0] = s1;
           // ts[1] = s2;
	   // ts[2] = s3;
	   // return new Term("if", ts);
       // }
    // }  
  // |
    // x = arg()  {   // System.out.println("   Goal: " + x );  
                   // return x; }
    
  // | "!"        { return  Term.CUT; }
// }

// goal       : '(' goal_list [ '->' goal_list ] [ ';' goal_list ] ')'
//            | arg
//            | '!'
goal
  : '(' goal_list ( '->' goal_list )? ( ';' goal_list )? ')'
  | arg
  | '!'
  ;


// Term goal_list() :
// {  Vector v = new Vector(); 
   // Term t;
// }
// {  t = goal()   { v.addElement( t ); }
   // ( "," 
       // t = goal() { v.addElement( t ); }
   // )*

   // {   int j = v.size();
       // t = new Term("null",0);;
       // while (--j >= 0 )
          // t = new Term("cons", (Term) v.elementAt(j), t);
       // return t;
   // }
// }

// goal_list  : goal (',' goal)*
goal_list
  : goal (',' goal)*
  ;


// Term arg() :
// {Term t1, t2;
// Token op;}
// {
    // t1 = sum() 
  // ( op = <RELOP>  t2 = sum() 
  
    // { t1 = new Term( op.image.intern(), t1, t2 ); }
  // )*
    // { return t1; }
// }

// arg        : sum (RELOP sum)*
arg
  : sum (RELOP sum)*
  ;


// Term sum() :
// {Term t1, t2;
// Token op;}
// {
    // t1 = factor() 
  // ( op = <ADDOP>  t2 = factor() 
  
    // { t1 = new Term( op.image.intern(), t1, t2 ); }
  // )*
    // { return t1; }
// }

// sum        : factor (ADDOP factor)*
sum
  : factor (ADDOP factor)*
  ;

// Term factor() :
// {Term t1, t2;
// Token op;}
// {
    // t1 = operand() 
  // ( op = <MULOP>  t2 = operand() 
  
    // { t1 = new Term( op.image.intern(), t1, t2 ); }
  // )*
    // { return t1; }
// }

// factor     : operand (MULOP operand)*
factor
  : operand (MULOP operand)*
  ;


// Term operand() :   
// {  Token tok; 
    // Term t;
// }
// {
  // t = pred() 
    // {   return t ;
    // }

// | tok = <VAR> 
    // {   
	// String s = tok.image;
        // t = (Term) vardict.get( s );
        // if (t==null) {
            // t = new Term(varnum++); 
            // if (varnum>maxVarnum) maxVarnum = varnum;
            // if( ! s.equals("_") )
            	// vardict.put( s,t);
        // }
        // return t;
    // }

// | tok = <NUMBER> 
    // {   
        // return new Number( tok.image.intern() );
    // }
    
// | t = list() 
    // {   
        // return t;
    // }
    
///| "(" t = arg() ")"
///    {   
///        return t;
///    }
// }

// operand    : pred
//            | VAR
//            | NUMBER
//            | list
operand
  : pred
  | VAR
  | NUMBER
  | list
  ;



// Term list() :
// {
    // Vector v = new Vector();
// }
// {
    // "["  [  listElems(v) ] "]" 
    
        // {  if (v.size()==0) 
                 // return new Term("null",0);
            // else
            // {   int j = v.size()-1;
                // Term t = (Term) v.elementAt( j );
                // while (--j >= 0 )
                    // t = new Term("cons", (Term) v.elementAt(j), t);
                // return t;
            // }
        // }
// }

// list       : '[' listElems? ']'
list
  : '[' listElems? ']'
  ;


// void listElems( Vector v) :
// {
    // Term t = null;
// }
// {
    // arglist( v )  [  "|"  t = arg() ] 
    
        // {  if (t== null) 
                // v.addElement(new Term("null",0) );
           // else
                // v.addElement( t );
        // }                       
// }

// listElems  : arglist [ '|' arg ]
listElems
  : arglist ( '|' arg )?
  ;




// Tokens
//------------------------------------------------------------------------

// SKIP : // WHITE SPACE 
// {" "|"\t"|"\n"|"\r"|"\f"}
WS: (' ' | '\t' | '\n' | '\r')+ { skip(); } ;

// SPECIAL_TOKEN : // COMMENTS 
// {
  // <SINGLE_LINE_COMMENT: "%" (~["\n","\r"])* ("\n"|"\r"|"\r\n")>
// }
SINGLE_LINE_COMMENT: '%' (~('\n'|'\r'))* ('\n'|'\r'|'\r\n') { skip(); };


//TOKEN : // RESERVED WORDS AND LITERALS
//{
//   < NOT: "not" | "\+" >
//}

// TOKEN : // OPERATORS 
// {
    // < CUT :  "!" >
  // | < ADDOP:  "+" | "-" >
  // | < MULOP:  "*" | "/" | "mod" >
  // | < RELOP:  "=" | "is" | "==" | "!=" | ">" | "<" | ">=" | "<=" >
// }

ADDOP: '+' | '-' ;
MULOP: '*' | '/' | 'mod' ;
RELOP: '=' | 'is' | '==' | '!=' | '>' | '<' | '>=' | '<=' ;


// TOKEN : // numeric constants 
// {
        // < NUMBER:  (<DIGIT>)+ >
  // |     < #DIGIT: ["0" - "9"] >
  // |     < CHAR_LITERAL:  "'" (~["'","\\","\n","\r"])*   "'" >
// }
NUMBER:  DIGIT+ ;
fragment DIGIT: '0'..'9';
CHAR_LITERAL:  '\'' (~('\''|'\\'|'\n'|'\r'))* '\'';


// TOKEN : // Function names 
// {
        // < VAR:      ( (<HICASE> |  "_" )  ( <ANYCHAR> )* ) >
  // |     < ATOM:     ( <LOCASE>) ( <ANYCHAR> )*  >  
  // |     < #ANYCHAR: ( <LOCASE> | <HICASE> | <DIGIT> | "_" ) > 
  // |     < #LOCASE: ["a"-"z"] > 
  // |     < #HICASE: ["A"-"Z"] > 
// } 
VAR:    (HICASE |  '_' )  ANYCHAR* ;
ATOM:  LOCASE ANYCHAR*;
fragment ANYCHAR: ( LOCASE | HICASE | DIGIT | '_' );
fragment LOCASE: 'a'..'z';
fragment HICASE: 'A'..'Z';





// value antlr grammar - just for reference
// from example calculator from ANTLR Reference p52-7
// also at http://www.antlr.org/wiki/display/ANTLR3/Expression+evaluator
/* 
stmt
    // evaluate expression and emit result
    : expr NEWLINE {System.out.println($expr.value);}

    // match assignment and stored value
    // $ID.text is text property of token matched for ID reference
    // | ID '=' expr NEWLINE 
        // {memory.put($ID.text, new Integer($expr.value));}

    // do nothing
    | NEWLINE
    ;

// return value of multExpr or, if +/- present, return
// multiplication of result from both multExpr references. 
expr returns [Value value]
    // : e=multExpr {$value = $e.value;}
    // ( '+' e=multExpr {$value += $e.value;} 
    // | '-' e=multExpr {$value -= $e.value;}
    // )*
    : INT {$value = new Value(Integer.parseInt($INT.text));}
    | INT ID  {$value = new Value(Integer.parseInt($INT.text), $ID.text);}
    ;
  
// return the value of an atom or, if '*' present, return
// multiplication of results from both atom references.
// $value is the return value of this method, $e.value
// is the return value of the rule labeled with e.
// multExpr returns [Value value]: 
    // e=atom {$value = $e.value;} ('*' e=atom {$value *= $e.value;})* 
    // ;

// note that $value in the actions is the return value
atom returns [Value value]: 

    // value of an INT is the int computed from char sequence
    INT {$value = new Value(Integer.parseInt($INT.text));}

    | ID // variable reference
    {
        // look up value of variable
        Integer v = (Integer) memory.get($ID.text);
        // if found, set return value else error
        if (v != null) 
            $value = v.intValue();
        else
            System.err.println("undefined variable " + $ID.text);
    }

    // value of parenthesized expression is just the expr value
    // $expr.value is the result computed by a call to expr. 
    | '(' expr ')' {$value = $expr.value;}
    ;


// Tokens

fragment
ALPHA: 'a'..'z' | 'A'..'Z' ;
ID: ALPHA+ ;
INT: '0'..'9'+ ;
NEWLINE: '\r'? '\n';
WS: (' ' | '\t' | '\n' | '\r')+ { $channel=HIDDEN; } ;

*/



