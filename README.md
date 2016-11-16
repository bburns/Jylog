
# Jylog

Jylog: Jython + Prolog

Brian Burns and Adam Keys

CS 345: Programming Languages  
Spring 2010  

----------------------------------------------------------------------------

[Jython](https://en.wikipedia.org/wiki/Jython) is an implementation of Python in Java, giving it access to the Java ecosystem and high performance compilers - the source code is [available on GitHub](https://github.com/jythontools/jython).

We evaluated several Prolog engines and chose [YProlog](http://freecode.com/projects/yprolog). 

The presentation is available [here](https://drive.google.com/open?id=0B-CHxEeXdpp2SlBCXzcwRFNzMzg).


## Syntax

Jylog handles Prolog facts and rules like the following - 

    >>> PROLOG wrote('pkd','valis').
    >>> PROLOG writtenBy('ubik','pkd').
    >>> PROLOG author('X','Y'):=wrote('X','Y').
    >>> PROLOG author('X','Y'):=writtenBy('Y','X').

and queries

    >>> PROLOG? author('pkd','X').

    author(pkd,ubik).
    author(pkd,valis).

Binary predicates are added to the TDB database as triples. 


## Todo

* get better prolog syntax working (ditch PROLOG keywords, use . at end for facts/rules, ? at end for queries)
* get SQL select working with binary predicates added to TDB via prolog
* get assignment to list working for prolog queries (eg x = author('pkd','X')?)
* get rid of scope variables in grammar (seemed to be needed for rewrite rules)


## Code

Most changes to the Jython code are marked with //jylog comments. 


## Running

Update the classpath then run:

    > init
    > run

    Jython 2.5.1+ (trunk, Apr 26 2010, 09:51:09)
    [Java HotSpot(TM) Client VM (Sun Microsystems Inc.)] on java1.6.0
    Type "help", "copyright", "credits" or "license" for more information.
    >>>

or run a test file

    > run cities.py

    Adding binary predicate to triple store: sussex, border, kent.
     WARN [main] (SetupTDB.java:702) - No BGP optimizer
    Adding binary predicate to triple store: sussex, border, surrey.
    Adding binary predicate to triple store: surrey, border, kent.
    Adding binary predicate to triple store: hampshire, border, sussex.
    Adding binary predicate to triple store: hampshire, border, surrey.
    Adding binary predicate to triple store: hampshire, border, berkshire.
    Adding binary predicate to triple store: berkshire, border, surrey.
    Adding binary predicate to triple store: wiltshire, border, hampshire.
    Adding binary predicate to triple store: wiltshire, border, berkshire.
    affordable(kent,kent).
    affordable(surrey,kent).
    affordable(kent,kent).
    affordable(berkshire,kent).
    affordable(hampshire,kent).
    affordable(hampshire,kent).
    affordable(sussex,kent).

or run with Jython's AST viewer

    > debug cities.py

    ('Module',
     ('body',
      ('Prolog (1,0)',
       ('dest', None),
       ('values',
        ('Str (1,14)', ('s', 'sussex')),
        ('Str (1,24)', ('s', 'kent')))),
      ('Prolog (2,0)',
       ('dest', None),
       ('values',
        ('Str (2,14)', ('s', 'sussex')),
        ('Str (2,24)', ('s', 'surrey')))),
      ('Prolog (3,0)',
       ('dest', None),
       ('values',
        ('Str (3,14)', ('s', 'surrey')),
        ('Str (3,24)', ('s', 'kent')))),
      ('Prolog (4,0)',
       ('dest', None),
       ('values',
        ('Str (4,14)', ('s', 'hampshire')),
        ('Str (4,27)', ('s', 'sussex')))),
      ('Prolog (5,0)',
       ('dest', None),
       ('values',
        ('Str (5,14)', ('s', 'hampshire')),
        ('Str (5,27)', ('s', 'surrey')))),
      ('Prolog (6,0)',
       ('dest', None),
       ('values',
        ('Str (6,14)', ('s', 'hampshire')),
        ('Str (6,27)', ('s', 'berkshire')))),
      ('Prolog (7,0)',
       ('dest', None),
       ('values',
        ('Str (7,14)', ('s', 'berkshire')),
        ('Str (7,27)', ('s', 'surrey')))),
      ('Prolog (8,0)',
       ('dest', None),
       ('values',
        ('Str (8,14)', ('s', 'wiltshire')),
        ('Str (8,27)', ('s', 'hampshire')))),
      ('Prolog (9,0)',
       ('dest', None),
       ('values',
        ('Str (9,14)', ('s', 'wiltshire')),
        ('Str (9,27)', ('s', 'berkshire')))),
      ('Prolog (11,0)',
       ('dest', None),
       ('values',
        ('Str (11,16)', ('s', 'X')),
        ('Str (11,21)', ('s', 'Y')),
        ('Str (11,36)', ('s', 'X')),
        ('Str (11,41)', ('s', 'Y')))),
      ('Prolog (12,0)',
       ('dest', None),
       ('values',
        ('Str (12,16)', ('s', 'X')),
        ('Str (12,21)', ('s', 'Y')),
        ('Str (12,36)', ('s', 'Y')),
        ('Str (12,41)', ('s', 'X')))),
      ('Prolog (14,0)',
       ('dest', None),
       ('values',
        ('Str (14,18)', ('s', 'X')),
        ('Str (14,23)', ('s', 'Y')),
        ('Str (14,40)', ('s', 'X')),
        ('Str (14,45)', ('s', 'Z')),
        ('Str (14,60)', ('s', 'Z')),
        ('Str (14,65)', ('s', 'Y')))),
      ('PrologQuery (16,0)',
       ('dest', None),
       ('values', ('Str (16,19)', ('s', 'X')), ('Str (16,24)', ('s', 'kent'))))))


## Building

You'll need the [Java Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) and the Java build tool [Ant](http://ant.apache.org/).

Set `JAVA_HOME` to the JDK home directory, e.g.

    > setx JAVA_HOME "C:\Program Files\Java\jdk1.8.0_111"

Run init.bat and then Ant to build Jylog:

    > init
    > ant


