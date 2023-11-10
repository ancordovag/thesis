% Define the possible movements of the player
move(X,Y,X+1,Y) :- player(X,Y), not wall(X+1,Y).
move(X,Y,X-1,Y) :- player(X,Y), not wall(X-1,Y).
move(X,Y,X,Y+1) :- player(X,Y), not wall(X,Y+1).
move(X,Y,X,Y-1) :- player(X,Y), not wall(X,Y-1).

% Define the possible movements of the Minotaur
move_minotaur(X,Y,X+1,Y) :- minotaur(X,Y), not wall(X+1,Y).
move_minotaur(X,Y,X-1,Y) :- minotaur(X,Y), not wall(X-1,Y).
move_minotaur(X,Y,X,Y+1) :- minotaur(X,Y), not wall(X,Y+1).
move_minotaur(X,Y,X,Y-1) :- minotaur(X,Y), not wall(X,Y-1).

% The player can move to a new position if it is not the same as the Minotaur's position
can_move(X,Y) :- move(X,Y,X1,Y1), not minotaur(X1,Y1).

% The Minotaur can move to a new position if it is not the same as the player's position
can_move_minotaur(X,Y) :- move_minotaur(X,Y,X1,Y1), not player(X1,Y1).

% The player wins if they reach the goal field
win :- player(X,Y), goal_field(X,Y).

% The player loses if they are in the same position as the Minotaur
lose :- player(X,Y), minotaur(X,Y).

% Show the output predicates
#show player/2.
#show minotaur/2.
#show wall/2.
% The player cannot be in the same position as the Minotaur
:- player(X,Y), minotaur(X,Y).

% The player cannot be in a position that is a wall
:- player(X,Y), wall(X,Y).

% The Minotaur cannot be in a position that is a wall
:- minotaur(X,Y), wall(X,Y).

% The player can stay in their current field
player(X,Y) :- player(X,Y).

% The player can move one field in any direction
player(X2,Y) :- player(X1,Y), X2 = X1 + 1, not wall(X2,Y).
player(X2,Y) :- player(X1,Y), X2 = X1 - 1, not wall(X2,Y).
player(X,Y2) :- player(X,Y1), Y2 = Y1 + 1, not wall(X,Y2).
player(X,Y2) :- player(X,Y1), Y2 = Y1 - 1, not wall(X,Y2).

% The Minotaur can move two fields in any direction
minotaur(X2,Y) :- minotaur(X1,Y), X2 = X1 + 2, not wall(X2,Y).
minotaur(X2,Y) :- minotaur(X1,Y), X2 = X1 - 2, not wall(X2,Y).
minotaur(X,Y2) :- minotaur(X,Y1), Y2 = Y1 + 2, not wall(X,Y2).
minotaur(X,Y2) :- minotaur(X,Y1), Y2 = Y1 - 2, not wall(X,Y2).