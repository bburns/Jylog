

cities1 = ['sussex', 'sussex', 'surrey', 'hampshire', 'hampshire', 'hampshire', 'berkshire', 'wiltshire', 'wiltshire']
cities2 = ['kent', 'surrey', 'kent', 'sussex', 'surrey', 'berkshire', 'surrey', 'hampshire', 'berkshire']

PROLOG border(cities1, cities2).

PROLOG adjacent('X', 'Y') := border('Y', 'X').
PROLOG adjacent('X', 'Y') := border('X', 'Y').

PROLOG affordable('X', 'Y') := adjacent('X', 'Z'), adjacent ('Z', 'Y').
PROLOG? affordable('X', 'kent').
