% Define the possible directions to move
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves for the player
move(X,Y,X+DX,Y+DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), S < maxsteps(S).

% Define the possible moves for the Minotaur
minotaur_move(X,Y,X+2*DX,Y+2*DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+2*DX,Y+2*DY), not wall(X,Y,X+2*DX,Y+2*DY), S < maxsteps(S).

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the goal position of the player
goal_reached(S) :- at(X,Y,S), goal(X,Y).

% Define the possible moves for the player and the Minotaur
{at(X,Y,S+1) : move(X,Y,X+DX,Y+DY,S+1)} 1 :- at(X,Y,S), dir(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), S < maxsteps(S), not goal_reached(S).
{at(X,Y,S+1) : minotaur_move(X,Y,X+2*DX,Y+2*DY,S+1)} 1 :- at(X,Y,S), dir(DX,DY), field(X+2*DX,Y+2*DY), not wall(X,Y,X+2*DX,Y+2*DY), S < maxsteps(S), not goal_reached(S).

% Show output predicate at
#show at/3.
% The player must start at the start field
:- not at(X,Y,0), start(X,Y).

% The player must reach the goal field within the maximum number of steps
:- not at(X,Y,S), goal(X,Y), maxsteps(S).

% The player can stay in their current field at any step
at(X,Y,S) :- at(X,Y,S-1).

% The player can move one field in any direction at any step
at(X,Y,S) :- at(X-1,Y,S-1), not wall(X,Y,X-1,Y).
at(X,Y,S) :- at(X+1,Y,S-1), not wall(X,Y,X+1,Y).
at(X,Y,S) :- at(X,Y-1,S-1), not wall(X,Y,X,Y-1).
at(X,Y,S) :- at(X,Y+1,S-1), not wall(X,Y,X,Y+1).

% The Minotaur can move two fields in any direction at any step
mino(X,Y,S) :- mino(X-2,Y,S-1), not wall(X,Y,X-2,Y).
mino(X,Y,S) :- mino(X+2,Y,S-1), not wall(X,Y,X+2,Y).
mino(X,Y,S) :- mino(X,Y-2,S-1), not wall(X,Y,X,Y-2).
mino(X,Y,S) :- mino(X,Y+2,S-1), not wall(X,Y,X,Y+2).

% The Minotaur will try to move right or left to become closer to the player
mino(X,Y,S) :- at(X-1,Y,S-1), mino(X-2,Y,S-1), not wall(X,Y,X-2,Y).
mino(X,Y,S) :- at(X+1,Y,S-1), mino(X+2,Y,S-1), not wall(X,Y,X+2,Y).

% The Minotaur will try to move up and down to become closer to the player
mino(X,Y,S) :- at(X,Y-1,S-1), mino(X,Y-2,S-1), not wall(X,Y,X,Y-2).
mino(X,Y,S) :- at(X,Y+1,S-1), mino(X,Y+2,S-1), not wall(X,Y,X,Y+2).

% The Minotaur will not move if it cannot become closer to the player
mino(X,Y,S) :- mino(X,Y,S-1), not (at(X-1,Y,S-1), mino(X-2,Y,S-1), not wall(X,Y,X-2,Y)).
mino(X,Y,S) :- mino(X,Y,S-1), not (at(X+1,Y,S-1), mino(X+2,Y,S-1), not wall(X,Y,X+2,Y)).
mino(X,Y,S) :- mino(X,Y,S-1), not (at(X,Y-1,S-1), mino(X,Y-2,S-1), not wall(X,Y,X,Y-2)).
mino(X,Y,S) :- mino(X,Y,S-1), not (at(X,Y+1,S-1), mino(X,Y+2,S-1), not wall(X,Y,X,Y+2)).