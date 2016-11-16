

% some facts

writtenBy(valis, pkd).
writtenBy(flowMyTears, pkd).
writtenBy(divineInvasion, pkd).

wrote(pkd, ubik).
wrote(pkd, aScannerDarkly).
wrote(pkd, doAndroidsDream).

website(pkd, 'http://en.wikipedia.org/wiki/Philip_K._Dick').


% some rules

author(Person, Book) :- writtenBy(Book, Person).
author(Person, Book) :- wrote(Person, Book).


% a query
% author(pkd, X).
% X=valis. etc

% author(X,Y).
% X=pkd, Y=valis, etc.

