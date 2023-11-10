% Define the possible directions to move
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves for the player
move(X,Y,X+DX,Y+DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), S < maxsteps.

% Define the possible moves for the Minotaur
minotaur_move(X,Y,X+DX,Y+DY,S+1) :- at(X,Y,S), dir(DX,DY), field(X+2*DX,Y+2*DY), not wall(X,Y,X+2*DX,Y+2*DY), S < maxsteps.

% Define the initial position of the player
at(X,Y,0) :- start(X,Y).

% Define the goal position
goal_reached :- at(X,Y,S), goal(X,Y), S < maxsteps.

% Define the position of the Minotaur
at(X,Y,S+1) :- minotaur_move(X,Y,X+DX,Y+DY,S), not goal_reached.

% Show the output predicate
#show at/3.
:- not at(X,Y,S), field(X,Y), S > 0.
:- not at(X,Y,S), field(X,Y), S =< maxsteps(S).
:- not at(X,Y,S), field(X,Y), S = 0, not goal(X,Y).
:- not at(X,Y,S), field(X,Y), S = 0, not start(X,Y).
:- not at(X,Y,S), field(X,Y), S = 0, not mino(X,Y).
:- not at(X,Y,S), field(X,Y), S = 0, not wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, not adjacent(X,Y,XX,YY), not mino(XX,YY), not wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, not adjacent(X,Y,XX,YY), mino(XX,YY), not wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, not adjacent(X,Y,XX,YY), not mino(XX,YY), wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, not adjacent(X,Y,XX,YY), mino(XX,YY), wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, adjacent(X,Y,XX,YY), not mino(XX,YY), not wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, adjacent(X,Y,XX,YY), mino(XX,YY), not wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, adjacent(X,Y,XX,YY), not mino(XX,YY), wall(X,Y,XX,YY).
:- not at(X,Y,S), field(X,Y), S > 0, adjacent(X,Y,XX,YY), mino(XX,YY), wall(X,Y,XX,YY).