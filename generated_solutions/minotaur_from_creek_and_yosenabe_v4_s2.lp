% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the possible movements of the player
at(X,Y,S+1) :- at(X,Y,S), dir(DX,DY), not wall(X,Y,X+DX,Y+DY), field(X+DX,Y+DY), S < #maxsteps.

% Define the possible movements of the Minotaur
mino(X,Y,S+1) :- mino(X,Y), dir(DX,DY), not wall(X,Y,X+DX,Y+DY), field(X+DX,Y+DY), S < #maxsteps.

% Define the goal condition
:- at(X,Y,S), goal(X,Y), S < #maxsteps.

% Define the condition to avoid being eaten by the Minotaur
:- at(X,Y,S), mino(X,Y,S), S < #maxsteps.

% Show output predicate at
#show at/3.