% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define the start and goal positions
start(X,Y) :- cell(X,Y), start(X,Y).
goal(X,Y) :- cell(X,Y), goal(X,Y).
% Define the possible moves for the player
move(X,Y,X+DX,Y+DY) :- start(X,Y), dir(DX,DY), cell(X+DX,Y+DY).
% Define the possible moves for the Minotaur
minotaur_move(X,Y,X+DX,Y+DY) :- minotaur(X,Y), dir(DX,DY), cell(X+DX,Y+DY).
% Define the new position of the player after a move
new_position(X,Y,X+DX,Y+DY) :- move(X,Y,X+DX,Y+DY).
% Define the new position of the Minotaur after a move
new_minotaur_position(X,Y,X+DX,Y+DY) :- minotaur_move(X,Y,X+DX,Y+DY).
% Define the possible moves for the player and the Minotaur
possible_move(X,Y,X+DX,Y+DY,X+DX',Y+DY') :- new_position(X,Y,X+DX,Y+DY), new_minotaur_position(X,Y,X+DX',Y+DY').
% Define the possible moves for the player and the Minotaur when the Minotaur cannot move
possible_move(X,Y,X+DX,Y+DY,X,Y) :- new_position(X,Y,X+DX,Y+DY), not new_minotaur_position(X,Y,X+DX',Y+DY').
% Define the possible moves for the player and the Minotaur when the player cannot move
possible_move(X,Y,X,Y,X+DX',Y+DY') :- not new_position(X,Y,X+DX,Y+DY), new_minotaur_position(X,Y,X+DX',Y+DY').
% Define the possible moves for the player and the Minotaur when neither can move
possible_move(X,Y,X,Y,X,Y) :- not new_position(X,Y,X+DX,Y+DY), not new_minotaur_position(X,Y,X+DX',Y+DY').
% Define the path from the start to the goal
path(X,Y,X+DX,Y+DY) :- start(X,Y), goal(X+DX,Y+DY), dir(DX,DY).
% Define the path from the start to the goal with the Minotaur's moves
path(X,Y,X+DX,Y+DY) :- start(X,Y), minotaur_move(X,Y,X+DX,Y+DY), goal(X+DX,Y+DY), dir(DX,DY).
% Define the path from the start to the goal with the player's moves and the Minotaur's moves
path(X,Y,X+DX,Y+DY) :- start(X,Y), possible_move(X,Y,X+DX,Y+DY,X+DX',Y+DY'), goal(X+DX,Y+DY), dir(DX,DY), dir(DX',DY').
% If the player is at the goal, it is a valid solution
:- goal(X,Y), start(X,Y).
% If the player is not at the goal, it is a bad solution
bad :- not goal(X,Y), start(X,Y).