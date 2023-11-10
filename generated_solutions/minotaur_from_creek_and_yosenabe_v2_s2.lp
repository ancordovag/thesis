% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% The player can stay in the same field
at(X,Y,S) :- start(X,Y), S = 0.
% The player can move to an adjacent field
at(X+DX,Y+DY,S) :- at(X,Y,S-1), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), dir(DX,DY).

% The Minotaur can move right or left to become closer to the player
mino(X+DX,Y+DY,S) :- mino(X,Y), at(X,Y,S-1), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), dir(DX,DY), DX != 0, DY = 0.
% The Minotaur can move up or down to become closer to the player
mino(X+DX,Y+DY,S) :- mino(X,Y), at(X,Y,S-1), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), dir(DX,DY), DX = 0, DY != 0.
% The Minotaur does not move if he cannot become closer to the player
mino(X,Y,S) :- mino(X,Y), at(X,Y,S-1).

% The player reaches the goal
reached_goal(X,Y,S) :- at(X,Y,S), goal(X,Y).

% The player does not get eaten by the Minotaur
:- at(X,Y,S), mino(X,Y,S).

% The player reaches the goal within the maximum number of steps
:- not reached_goal(_,_,S), maxsteps(S).

#show at/3.
% The player cannot be at a wall
:- at(X,Y,S), wall(X,Y,_,_), S <= maxsteps(S).

% The player cannot be at the same field as the Minotaur
:- at(X,Y,S), mino(X,Y), S <= maxsteps(S).

% The player must reach the goal within the maximum number of steps
:- not at(X,Y,S), goal(X,Y), S = maxsteps(S).