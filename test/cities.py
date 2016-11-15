PROLOG border('sussex', 'kent').
PROLOG border('sussex', 'surrey').
PROLOG border('surrey', 'kent').
PROLOG border('hampshire', 'sussex').
PROLOG border('hampshire', 'surrey').
PROLOG border('hampshire', 'berkshire').
PROLOG border('berkshire', 'surrey').
PROLOG border('wiltshire', 'hampshire').
PROLOG border('wiltshire', 'berkshire').

PROLOG adjacent('X', 'Y') := border('X', 'Y').
PROLOG adjacent('X', 'Y') := border('Y', 'X').

PROLOG affordable('X', 'Y') := adjacent('X', 'Z'), adjacent('Z', 'Y').

PROLOG? affordable('X', 'kent').
