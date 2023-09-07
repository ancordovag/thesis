% The player can move to any adjacent cell that is not a wall or the Minotaur
move(X,Y,XX,YY) :- player(X,Y), not wall(XX,YY), not minotaur(XX,YY), |X-XX| + |Y-YY| = 1.

% The Minotaur can move to any adjacent cell that is not a wall or the player
move(X,Y,XX,YY) :- minotaur(X,Y), not wall(XX,YY), not player(XX,YY), |X-XX| + |Y-YY| = 1.

% The player can move to any adjacent cell that is not a wall or the Minotaur, and the Minotaur moves after the player
move(X,Y,XX,YY) :- player(X,Y), not wall(XX,YY), not minotaur(XX,YY), |X-XX| + |Y-YY| = 1, not move(XX,YY,_,_).

% The Minotaur can move to any adjacent cell that is not a wall or the player, and the player moves after the Minotaur
move(X,Y,XX,YY) :- minotaur(X,Y), not wall(XX,YY), not player(XX,YY), |X-XX| + |Y-YY| = 1, not move(XX,YY,_,_).

% The player can move to the goal cell if it is adjacent and there is no Minotaur in the goal cell
move(X,Y,XX,YY) :- player(X,Y), goal(XX,YY), not minotaur(XX,YY), |X-XX| + |Y-YY| = 1.

% The player wins if it reaches the goal cell
win :- player(X,Y), goal(X,Y).

% The player loses if it is in the same cell as the Minotaur
lose :- player(X,Y), minotaur(X,Y).

% The player can only move if the game is not over
:- move(_,_,_,_), win.
:- move(_,_,_,_), lose.

% Show output predicates
#show move/4.
#show win/0.
#show lose/0.
% The player cannot be in the same position as the Minotaur
:- player(X,Y), minotaur(X,Y).
% The player cannot be in the same position as the goal
:- player(X,Y), goal(X,Y).
% The Minotaur cannot be in the same position as the goal
:- minotaur(X,Y), goal(X,Y).
% The player cannot be in a wall position
:- player(X,Y), wall(X,Y).
% The Minotaur cannot be in a wall position
:- minotaur(X,Y), wall(X,Y).
% The goal cannot be in a wall position
:- goal(X,Y), wall(X,Y).