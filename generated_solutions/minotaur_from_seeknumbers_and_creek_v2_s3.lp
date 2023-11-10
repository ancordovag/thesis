% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves for the player
move(X,Y,XX,YY) :- dir(DX,DY), XX = X+DX, YY = Y+DY, field(XX,YY), not wall(X,Y,XX,YY).

% Define the possible moves for the Minotaur
minomove(X,Y,XX,YY) :- dir(DX,DY), XX = X+2*DX, YY = Y+2*DY, field(XX,YY), not wall(X,Y,X+DX,Y+DY).

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the initial position of the Minotaur
at(X,Y,0) :- mino(X,Y).

% Define the position of the player at each step
at(XX,YY,S) :- at(X,Y,S-1), move(X,Y,XX,YY), not at(XX,YY,S-1), S>0, maxsteps(S).

% Define the position of the Minotaur at each step
at(XX,YY,S) :- at(X,Y,S-1), minomove(X,Y,XX,YY), not at(XX,YY,S-1), S>0, maxsteps(S).

% Define the winning condition
:- at(X,Y,S), goal(X,Y), S>0.

% Define the losing condition
:- at(X,Y,S), at(XX,YY,S), mino(X,Y), X=XX, Y=YY, S>0.
% It cannot be the case that the player is not at the start field at step 0
:- not at(X,Y,0), start(X,Y).
% It cannot be the case that the player is not at the goal field at the last step
:- maxsteps(S), not at(X,Y,S), goal(X,Y).
% It cannot be the case that the player is not at a field at a step if they are not at that field in the previous step
:- at(X,Y,S), not at(XX,YY,S-1), field(X,Y), field(XX,YY), (X != XX ; Y != YY).
% It cannot be the case that the player is at a field if there is a wall between that field and the previous field
:- at(X,Y,S), at(XX,YY,S-1), wall(X,Y,XX,YY), field(X,Y), field(XX,YY).
% It cannot be the case that the player is at a field if the Minotaur is also at that field
:- at(X,Y,S), mino(X,Y), field(X,Y).
% It cannot be the case that the player is at a field if the Minotaur is at a field adjacent to that field
:- at(X,Y,S), mino(XX,YY), field(X,Y), field(XX,YY), neighbour(X,Y,XX,YY,_).
% It cannot be the case that the player is at a field if the Minotaur is at a field that can be reached from that field in one step
:- at(X,Y,S), mino(XX,YY), field(X,Y), field(XX,YY), reachable(X,Y,XX,YY,_).
% It cannot be the case that the player is at a field if the Minotaur is at a field that can be reached from that field in two steps
:- at(X,Y,S), mino(XX,YY), field(X,Y), field(XX,YY), reachable(X,Y,XXX,YYY,_), reachable(XXX,YYY,XX,YY,_).
% It cannot be the case that the player is at a field if the Minotaur is at a field that can be reached from that field in three steps
:- at(X,Y,S), mino(XX,YY), field(X,Y), field(XX,YY), reachable(X,Y,XXX,YYY,_), reachable(XXX,YYY,XXXX,YYYY,_), reachable(XXXX,YYYY,XX,YY,_).
% It cannot be the case that the player is at a field if the Minotaur is at a field that can be reached from that field in four steps
:- at(X,Y,S), mino(XX,YY), field(X,Y), field(XX,YY), reachable(X,Y,XXX,YYY,_), reachable(XXX,YYY,XXXX,YYYY,_), reachable(XXXX,YYYY,XXXXX,YYYYY,_), reachable(XXXXX,YYYYY,XX,YY,_).

% Show output predicate at/3.
#show at/3.