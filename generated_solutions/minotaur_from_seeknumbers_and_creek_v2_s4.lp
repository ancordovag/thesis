% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible movements of the Minotaur based on the player's position
minotaur_move(X,Y,XX,YY) :- mino(X,Y), dir(DX,DY), XX=X+2*DX, YY=Y+2*DY, not wall(X,Y,XX,YY).
minotaur_move(X,Y,XX,YY) :- mino(X,Y), dir(DX,DY), XX=X+DY, YY=Y+DX, not wall(X,Y,XX,YY), not wall(XX,YY,XX+DX,YY+DY).
minotaur_move(X,Y,XX,YY) :- mino(X,Y), dir(DX,DY), XX=X-DY, YY=Y-DX, not wall(X,Y,XX,YY), not wall(XX,YY,XX+DX,YY+DY).
minotaur_move(X,Y,XX,YY) :- mino(X,Y), dir(DX,DY), XX=X-DX, YY=Y-DY, not wall(X,Y,XX,YY), not wall(XX,YY,XX+DX,YY+DY).

% Define the possible movements of the player
player_move(X,Y,XX,YY) :- start(X,Y), dir(DX,DY), XX=X+DX, YY=Y+DY, not wall(X,Y,XX,YY).
player_move(X,Y,XX,YY) :- at(X,Y,S), dir(DX,DY), XX=X+DX, YY=Y+DY, not wall(X,Y,XX,YY), S>0, at(XX,YY,S-1).

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the position of the player at each step
at(XX,YY,S) :- at(X,Y,S-1), player_move(X,Y,XX,YY), not minotaur_move(XX,YY,_,_).

% Define the position of the Minotaur at each step
at(XX,YY,S) :- at(X,Y,S-1), minotaur_move(X,Y,XX,YY), not player_move(XX,YY,_,_).

% Define the goal state
goal_reached :- goal(X,Y), at(X,Y,S), maxsteps(S).

% Show output predicate at
#show at/3.
% It cannot be the case that the player is not at the start field at step 0
:- not at(X,Y,0), start(X,Y).
% It cannot be the case that the player is not at the goal field at the last step
:- maxsteps(S), not at(X,Y,S), goal(X,Y).
% It cannot be the case that the player is not at a field at a step if they are not at that field at the previous step
:- at(X,Y,S), not at(XX,YY,S-1), field(X,Y), field(XX,YY), (X != XX ; Y != YY).
% It cannot be the case that the player is at a field at a step if they are at that field at the previous step
:- at(X,Y,S), at(XX,YY,S-1), field(X,Y), field(XX,YY), (X = XX ; Y = YY).
% It cannot be the case that the player is at a field at a step if there is a wall between that field and the previous field
:- at(X,Y,S), at(XX,YY,S-1), wall(X,Y,XX,YY), field(X,Y), field(XX,YY).
% It cannot be the case that the Minotaur is not at a field at a step if they are not at that field at the previous step
:- at(X,Y,S), not at(XX,YY,S-1), mino(X,Y), mino(XX,YY), (X != XX ; Y != YY).
% It cannot be the case that the Minotaur is at a field at a step if they are at that field at the previous step
:- at(X,Y,S), at(XX,YY,S-1), mino(X,Y), mino(XX,YY), (X = XX ; Y = YY).
% It cannot be the case that the Minotaur is at a field at a step if there is a wall between that field and the previous field
:- at(X,Y,S), at(XX,YY,S-1), wall(X,Y,XX,YY), mino(X,Y), mino(XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step
:- at(X,Y,S), at(XX,YY,S), field(X,Y), field(XX,YY), (X = XX ; Y = YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if there is a wall between them
:- at(X,Y,S), at(XX,YY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are not at the same field at the previous step
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if there is a wall between them and they are not at the same field at the previous step
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if there is a wall between them and they are at the same field at the previous step
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is a wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is no wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY), not wall(X,Y,XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are not at the same field at the previous step and there is no wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY), not wall(X,Y,XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are not at the same field at the previous step and there is a wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is a wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is no wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY), not wall(X,Y,XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are not at the same field at the previous step and there is no wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY), not wall(X,Y,XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are not at the same field at the previous step and there is a wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is a wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), wall(X,Y,XX,YY), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they are at the same field at the previous step and there is no wall between them
:- at(X,Y,S), at(XX,YY,S-1), at(XXX,YYY,S), field(X,Y), field(XX,YY), field(XXX,YYY), (X = XX ; Y = YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY), not wall(X,Y,XX,YY).
% It cannot be the case that the player and the Minotaur are at the same field at any step if they