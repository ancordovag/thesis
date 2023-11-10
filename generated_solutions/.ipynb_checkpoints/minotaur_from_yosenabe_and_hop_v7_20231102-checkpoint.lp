% possible movements
move(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
move(X,Y,X-1,Y) :- field(X,Y), field(X-1,Y), not wall(X,Y,X-1,Y).
move(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
move(X,Y,X,Y-1) :- field(X,Y), field(X,Y-1), not wall(X,Y,X,Y-1).

% player's movement
possible_at(X,Y,T) :- start(X,Y), T=0.
possible_at(X,Y,T) :- at(X,Y,T-1), move(X,Y,X1,Y1), T>0, T<=S.

% minotaur's movement
possible_mino(X,Y,T) :- mino(X,Y), T=0.
possible_mino(X,Y,T) :- mino(X,Y,T-1), move(X,Y,X1,Y1), T>0, T<=S.