% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible positions of the fields
position(X,Y) :- rows(X), columns(Y).

% Define the maximum number of steps allowed
maxsteps(S) :- maxsteps(S).

% Define the start field
start(X,Y) :- start(X,Y).

% Define the goal field
goal(X,Y) :- goal(X,Y).

% Define the position of the Minotaur
mino(X,Y) :- mino(X,Y).

% Define the walls in the labyrinth
wall(X1,Y1,X2,Y2) :- wall(X1,Y1,X2,Y2).

% Define the possible movements of the Minotaur
move(X,Y,X+DX,Y+DY) :- mino(X,Y), dir(DX,DY), not wall(X,Y,X+DX,Y+DY), position(X+DX,Y+DY).

% Define the possible movements of the player
move(X,Y,X+DX,Y+DY) :- not mino(X,Y), dir(DX,DY), not wall(X,Y,X+DX,Y+DY), position(X+DX,Y+DY).

% Define the number of steps taken
steps(N) :- N = #count{X,Y : move(X,Y,_,_)}, maxsteps(S), N <= S.

% Define the path from the start field to the goal field
path(X,Y,X,Y) :- goal(X,Y).
path(X,Y,X+DX,Y+DY) :- move(X,Y,X+DX,Y+DY), path(X+DX,Y+DY,X,Y).

% Define the winning condition
winning_condition :- start(X,Y), goal(X,Y), path(X,Y,X,Y), steps(N), N <= S.

#show position/2.
#show maxsteps/1.
#show start/2.
#show goal/2.
#show mino/2.
#show wall/4.
% The start field must be visited
visit(X,Y) :- start(X,Y).

% The goal field must be visited
visit(X,Y) :- goal(X,Y).

% The Minotaur field must be visited
visit(X,Y) :- mino(X,Y).

% A field cannot be visited if it is a wall
:- visit(X,Y), wall(X,Y,X,Y).

% The Minotaur can move two fields in any direction
move(X1,Y1,X2,Y2) :- mino(X1,Y1), mino(X2,Y2), (X1 != X2 ; Y1 != Y2), abs(X1-X2) + abs(Y1-Y2) = 2.

% The Minotaur will try to move right or left to become closer to the player
move(X1,Y1,X2,Y2) :- mino(X1,Y1), mino(X2,Y2), (X1 = X2 ; Y1 = Y2), abs(X1-X2) + abs(Y1-Y2) = 2, (X1 = X2 ; Y1 != Y2).

% The Minotaur will try to move up and down to become closer to the player
move(X1,Y1,X2,Y2) :- mino(X1,Y1), mino(X2,Y2), (X1 = X2 ; Y1 = Y2), abs(X1-X2) + abs(Y1-Y2) = 2, (X1 != X2 ; Y1 = Y2).

% The Minotaur will not move if there is no possible move
:- mino(X,Y), not move(X,Y,_,_).

% The player can stay in their current field
move(X,Y,X,Y) :- not move(X,Y,_,_).

% The player can move one field in any direction: up, down, left, or right
move(X1,Y1,X2,Y2) :- not move(X1,Y1,X2,Y2), abs(X1-X2) + abs(Y1-Y2) = 1.

% The player cannot move through a wall
:- move(X1,Y1,X2,Y2), wall(X1,Y1,X2,Y2).

% The player cannot move more steps than the maximum allowed
:- move(X1,Y1,X2,Y2), steps(S), S > maxsteps.