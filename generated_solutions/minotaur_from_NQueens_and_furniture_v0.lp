% Define the constants in each category.
category("field"; "start"; "goal"; "mino"; "wall"; "maxsteps"; "at").
constant("X"; "Y"; "XX"; "YY"; "S").
% For each category C, there is exactly 1 constant V.
{relation(C, V): constant(V)}=1 :- category(C).
% The field (X,Y) belongs to the labyrinth.
field(X,Y) :- relation("field",X), relation("field",Y).

% The start field is (X,Y).
start(X,Y) :- relation("start",X), relation("start",Y).

% The goal field is (X,Y).
goal(X,Y) :- relation("goal",X), relation("goal",Y).

% The Minotaur starts at (X,Y).
mino(X,Y) :- relation("mino",X), relation("mino",Y).

% There is a wall between (X,Y) and (XX,YY).
wall(X,Y,XX,YY) :- relation("wall",X), relation("wall",Y), relation("wall",XX), relation("wall",YY).

% There are at most S steps to reach the goal.
maxsteps(S) :- relation("maxsteps",S).

% The player is at field (X,Y) at step S.
at(X,Y,S) :- relation("at",X), relation("at",Y), relation("at",S).