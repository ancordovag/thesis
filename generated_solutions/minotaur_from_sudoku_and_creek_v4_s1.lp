% Define the possible directions to move
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves for the player
move(X,Y,X+DX,Y+DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), S < maxsteps(S).

% Define the possible moves for the Minotaur
minotaur_move(X,Y,X+DX,Y+DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+2*DX,Y+2*DY), not wall(X,Y,X+2*DX,Y+2*DY), S < maxsteps(S).

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the initial position of the Minotaur
at(X,Y,0) :- mino(X,Y).

% Define the goal position
goal_reached(S) :- at(X,Y,S), goal(X,Y).

% Define the condition for the player to be eaten by the Minotaur
eaten(S) :- at(X,Y,S), at(X,Y,S+1), minotaur_move(X,Y,_,_,S).

% Define the condition for the player to win
win(S) :- goal_reached(S), not eaten(S).

% Show the output predicate
#show at/3.