% Define the neighbours of a field X,Y
neighbour(X,Y,XX,YY) :- field(X,Y), field(XX,YY), |XX-X| + |YY-Y| = 1.

% The player can stay in his current field
{ at(X,Y,T) } 1 :- field(X,Y), start(X,Y), T = 0.
{ at(X,Y,T) } 1 :- field(X,Y), goal(X,Y), T = S, maxsteps(S).

% The player can move one field in any direction: up, down, left or right
{ at(XX,YY,T+1) } :- at(X,Y,T), neighbour(X,Y,XX,YY), not wall(X,Y,XX,YY), T < S, maxsteps(S).

% The Minotaur can move two fields every step
{ mino(XX,YY,T+1) } :- mino(X,Y,T), neighbour(X,Y,XX,YY), not wall(X,Y,XX,YY), T < S, maxsteps(S).

% The Minotaur will try to move right or left to become closer to the player
{ mino(XX,YY,T+1) } :- mino(X,Y,T), at(X+A,Y,T), neighbour(X,Y,XX,YY), not wall(X,Y,XX,YY), A != 0, T < S, maxsteps(S).

% The Minotaur will try to move up and down to become closer to the player
{ mino(XX,YY,T+1) } :- mino(X,Y,T), at(X,Y+A,T), neighbour(X,Y,XX,YY), not wall(X,Y,XX,YY), A != 0, T < S, maxsteps(S).

% The Minotaur will not move if there are no possible moves
{ mino(X,Y,T+1) } 1 :- mino(X,Y,T), not mino(XX,YY,T+1), T < S, maxsteps(S).