

% 6 slots available.
slots([slot(_,mon11),slot(_,mon11),slot(_,mon12),slot(_,mon12),slot(_,tues11),slot(_,tues11)]).

% 5 groups, g1-g5
schedule(Slots) :- slots(Slots),
 member(slot(g1, G1), Slots),
 member(slot(g2, G2), Slots),
 member(slot(g3, G3), Slots),
 member(slot(g4, G4), Slots),
 member(slot(g5, G5), Slots),

 % constraints
 G1 \= mon11,
 G2 \= mon12,
 G3 \= mon12,
 G3 \= tues11,
 G5 \= tues11,
true.

