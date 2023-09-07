% Generate all possible moves for the player at each step
move(X,Y,XX,YY,S) :- at(X,Y,S), not wall(X,Y,XX,YY), field(XX,YY), S <= maxsteps(S).

% The player starts at the start field at step 0
at(X,Y,0) :- start(X,Y).

% The player can stay in the same field at each step
at(X,Y,S) :- at(X,Y,S-1), field(X,Y), S > 0.

% The player can move to a neighboring field at each step
at(XX,YY,S) :- at(X,Y,S-1), move(X,Y,XX,YY,S), field(XX,YY), S > 0.

% The Minotaur moves right or left if possible, then up or down if possible, otherwise stays in the same field
minomove(X,Y,XX,YY) :- mino(X,Y), XX=X+2, YY=Y, field(XX,YY), not wall(X,Y,XX,YY).
minomove(X,Y,XX,YY) :- mino(X,Y), XX=X-2, YY=Y, field(XX,YY), not wall(X,Y,XX,YY).
minomove(X,Y,XX,YY) :- mino(X,Y), XX=X, YY=Y+2, field(XX,YY), not wall(X,Y,XX,YY).
minomove(X,Y,XX,YY) :- mino(X,Y), XX=X, YY=Y-2, field(XX,YY), not wall(X,Y,XX,YY).
minomove(X,Y,X,Y) :- mino(X,Y), field(X,Y).

% The Minotaur moves at each step
minoat(X,Y,S) :- mino(X,Y), at(XX,YY,S-1), minomove(XX,YY,X,Y), field(X,Y), S > 0.

% The player wins if they reach the goal field and the Minotaur never moves to the same field
:- at(X,Y,S), goal(X,Y), minoat(X,Y,S).

% Show the goal predicate
#show at/3.
% the player cannot be at a wall
:- wall(X,Y,XX,YY), at(X,Y,S).

% the player cannot be at the same field as the Minotaur
:- mino(X,Y), at(X,Y,S).

% the player cannot be at the goal field before reaching the maximum number of steps
:- goal(X,Y), at(X,Y,S), S < maxsteps(S).

% the player must be at the start field at step 0
:- start(X,Y), at(X,Y,S), S > 0.

% the player can move to an adjacent field in any direction
at(X,Y,S) :- at(XX,Y,S-1), not wall(XX,Y,X,Y).
at(X,Y,S) :- at(X,YY,S-1), not wall(X,YY,X,Y).
at(X,Y,S) :- at(XX,Y,S-1), not wall(X,Y,XX,Y).
at(X,Y,S) :- at(X,YY,S-1), not wall(X,Y,X,YY).

% Show output predicate
#show at/3.