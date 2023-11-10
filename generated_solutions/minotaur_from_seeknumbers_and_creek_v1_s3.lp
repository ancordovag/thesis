% Generate all possible moves for the player
1 { move_player(X,Y,XX,YY,S) : directions(D), player_steps(S) } 1 :- at(X,Y,S), not wall(X,Y,XX,YY).

% Generate all possible moves for the Minotaur
1 { move_minotaur(X,Y,XX,YY,S) : directions(D), minotaur_steps(S) } 1 :- mino(X,Y,S), not wall(X,Y,XX,YY).

% The player can only move to a field if it is not occupied by the Minotaur
at(XX,YY,S+1) :- at(X,Y,S), move_player(X,Y,XX,YY,S), not mino(XX,YY,S).

% The Minotaur can only move to a field if it is not occupied by the player
mino(XX,YY,S+1) :- mino(X,Y,S), move_minotaur(X,Y,XX,YY,S), not at(XX,YY,S).

% The player wins if they reach the exit field
:- at(X,Y,S), exit(X,Y), not win(S).

% The player loses if they are in the same field as the Minotaur
:- at(X,Y,S), mino(X,Y,S).

% The player wins if they reach the exit field and there are no more steps for the Minotaur
win(S) :- at(X,Y,S), exit(X,Y), not move_minotaur(_,_,_,_,S).

% The player loses if they are in the same field as the Minotaur and there are no more steps for the player
:- at(X,Y,S), mino(X,Y,S), not move_player(_,_,_,_,S).
% The player cannot move to a field that is a wall.
:- at(X,Y,S), wall(X,Y,XX,YY), at(XX,YY,S-1).

% The player cannot move to a field that is outside the labyrinth.
:- at(X,Y,S), not field(X,Y).

% The player cannot move to a field that is occupied by the Minotaur.
:- at(X,Y,S), mino(X,Y,S).

% The player cannot move to a field that is occupied by the Minotaur in the previous step.
:- at(X,Y,S), mino(X,Y,S-1).

% The player cannot move to a field that is occupied by the Minotaur in the next step.
:- at(X,Y,S), mino(XX,YY,S+1), at(XX,YY,S).

% The Minotaur cannot move to a field that is a wall.
:- mino(X,Y,S), wall(X,Y,XX,YY), mino(XX,YY,S-1).

% The Minotaur cannot move to a field that is outside the labyrinth.
:- mino(X,Y,S), not field(X,Y).

% The Minotaur cannot move to a field that is occupied by the player.
:- mino(X,Y,S), at(X,Y,S).

% The Minotaur cannot move to a field that is occupied by the player in the previous step.
:- mino(X,Y,S), at(X,Y,S-1).

% The Minotaur cannot move to a field that is occupied by the player in the next step.
:- mino(X,Y,S), at(XX,YY,S+1), mino(XX,YY,S).

% The player cannot move to the same field as the Minotaur.
:- at(X,Y,S), mino(X,Y,S).

% The player cannot move to the same field as the Minotaur in the previous step.
:- at(X,Y,S), mino(X,Y,S-1).

% The player cannot move to the same field as the Minotaur in the next step.
:- at(X,Y,S), mino(XX,YY,S+1), at(XX,YY,S).

% The player cannot move more than one field in a step.
:- at(X,Y,S), at(XX,YY,S-1), abs(X-XX) + abs(Y-YY) > 1.

% The Minotaur cannot move more than two fields in a step.
:- mino(X,Y,S), mino(XX,YY,S-1), abs(X-XX) + abs(Y-YY) > 2.

% The player cannot move more than the specified number of steps.
:- maxsteps(S), S < 0, at(_,_,S).

% The Minotaur cannot move more than the specified number of steps.
:- maxsteps(S), S < 0, mino(_,_,S).

% Show output predicates.
#show at/3.
#show mino/3.