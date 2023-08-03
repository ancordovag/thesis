% Define the time predicate
time(1..S) :- maxsteps(S).

% Define the possible neighbor cells
neighbor(X, Y, NX, NY, DX, DY) :- field(NX, NY), diff(DX, DY), NX = X + DX, NY = Y + DY.

% Define the initial position of the player and the Minotaur
player(X, Y, 0) :- start(X, Y).
mino(X, Y, 0) :- mino(X, Y).

% Define the valid movements for the player and the Minotaur
% The player can move to any neighboring cell, and the Minotaur can move two steps towards the player
{ move(X, Y, DX, DY, T) : time(T), neighbor(X, Y, NX, NY, DX, DY) } 2 :- field(X, Y), time(T).
{ mino_move(X, Y, DX, DY, T) : time(T), neighbor(X, Y, NX, NY, DX, DY) } 2 :- field(X, Y), time(T).

% Define the rules for player movement
:- player(X, Y, T), move(X, Y, DX, DY, T), not player(NX, NY, T+1), NX = X + DX, NY = Y + DY.
player(NX, NY, T+1) :- player(X, Y, T), move(X, Y, DX, DY, T), NX = X + DX, NY = Y + DY.

% Define the rules for Minotaur movement
:- mino(X, Y, T), mino_move(X, Y, DX, DY, T), not mino(NX, NY, T+1), NX = X + DX, NY = Y + DY.
mino(NX, NY, T+1)