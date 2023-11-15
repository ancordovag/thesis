% generate possible moves for player
move(X,Y,XX,YY) :- XX=X, YY=Y+1, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY).
move(X,Y,XX,YY) :- XX=X, YY=Y-1, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY).
move(X,Y,XX,YY) :- XX=X+1, YY=Y, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY).
move(X,Y,XX,YY) :- XX=X-1, YY=Y, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY).
move(X,Y,X,Y) :- field(X,Y).

% generate possible moves for Minotaur
mino_move(X,Y,XX,YY) :- XX=X, YY=Y+2, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(X,Y+1,XX,YY).
mino_move(X,Y,XX,YY) :- XX=X, YY=Y-2, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(X,Y-1,XX,YY).
mino_move(X,Y,XX,YY) :- XX=X+2, YY=Y, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(X+1,Y,XX,YY).
mino_move(X,Y,XX,YY) :- XX=X-2, YY=Y, field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(X-1,Y,XX,YY).

% player starts at "start"
at(X,Y,0) :- start(X,Y).

% Minotaur starts at "mino"
mino_at(X,Y,0) :- mino(X,Y).

% player can move to a neighbouring field or stay in the same field
1 { at(XX,YY,S+1) : move(X,Y,XX,YY) } 1 :- at(X,Y,S), not maxsteps(S).

% Minotaur moves towards the player
mino_at(XX,YY,S+1) :- mino_move(X,Y,XX,YY), mino_at(X,Y,S), at(P,Q,S+1), (XX-P)*(XX-P) <= (X-P)*(X-P), (YY-Q)*(YY-Q) <= (Y-Q)*(Y-Q).

% player cannot be at the same field as the Minotaur
:- at(X,Y,S), mino_at(X,Y,S).

% Show output predicate
#show at/3.
% The player cannot be at a field that is not part of the labyrinth
:- at(X,Y,S), not field(X,Y).
% The player must start at the start field
:- not at(X,Y,0), start(X,Y).
% The player must reach the goal within the maximum number of steps
:- not at(X,Y,S), goal(X,Y), maxsteps(S).
% The player cannot move through walls
:- at(X,Y,S), at(XX,YY,S+1), wall(X,Y,XX,YY).
% The player cannot be at the same field as the Minotaur
:- at(X,Y,S), mino(X,Y).
% The Minotaur cannot move through walls
:- mino(X,Y), wall(X,Y,XX,YY), mino(XX,YY).
% The Minotaur must move closer to the player
:- mino(X,Y), at(XX,YY,S), abs(X-XX)+abs(Y-YY) < abs(X-XX)+abs(Y-YY).
% The Minotaur cannot move more than two fields in one step
:- mino(X,Y), mino(XX,YY), abs(X-XX)+abs(Y-YY) > 2.