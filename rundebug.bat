:: show the abstract syntax tree for a jython program
@dist\bin\jython ast\astview.py %*

:: eg
:: >debug testLambda.py
:: >dist/bin/jython ast/astview.py testLambda.py
:: ('Module',
 :: ('body',
  :: ('Expr (1,0)',
   :: ('value',
    :: ('Lambda (1,0)',
     :: ('args',
      :: ('arguments',
       :: ('args', ('Name (1,7)', ('id', 'x'), ('ctx', ('Param',)))),
       :: ('vararg', None),
       :: ('kwarg', None),
       :: ('defaults',))),
     :: ('body', ('Name (1,11)', ('id', 'x'), ('ctx', ('Load',))))))),
  :: ('Expr (2,0)',
   :: ('value',
    :: ('Call (2,0)',
     :: ('func',
      :: ('Lambda (2,1)',
       :: ('args',
        :: ('arguments',
         :: ('args', ('Name (2,8)', ('id', 'x'), ('ctx', ('Param',)))),
         :: ('vararg', None),
         :: ('kwarg', None),
         :: ('defaults',))),
       :: ('body',
        :: ('BinOp (2,12)',
         :: ('left', ('Name (2,12)', ('id', 'x'), ('ctx', ('Load',)))),
         :: ('op', ('Add',)),
         :: ('right', ('Name (2,16)', ('id', 'x'), ('ctx', ('Load',)))))))),
     :: ('args', ('Num (2,20)', ('n', 4))),
     :: ('keywords',),
     :: ('starargs', None),
     :: ('kwargs', None))))))

