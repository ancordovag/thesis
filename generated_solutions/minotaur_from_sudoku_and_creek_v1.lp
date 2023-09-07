% Define the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves from one field to another
move(X,Y,XX,YY) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY).

% Define the possible moves from one field to another considering the Minotaur's position
move(X,Y,XX,YY) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY).

% Define the possible moves from one field to another considering the player's position at a certain step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), at(X,Y,S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the goal field
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), goal(XX,YY).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1), mino(XX,YY,S-1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1), mino(XX,YY,S-1), mino(XX,YY,S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the Minotaur's position at the previous step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1), mino(XX,YY,S-1), mino(XX,YY,S), mino(XX,YY,S-1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1), mino(XX,YY,S-1), mino(XX,YY,S), mino(XX,YY,S-1), mino(XX,YY,S).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the player's position at the previous step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y-YY| = 1, not wall(X,Y,XX,YY), not mino(XX,YY), at(X,Y,S), maxsteps(S), start(X,Y), goal(XX,YY), move(XX,YY,X,Y,S-1), move(XX,YY,X,Y,S), move(XX,YY,X,Y,S+1), mino(XX,YY,S+1), mino(XX,YY,S-1), mino(XX,YY,S), mino(XX,YY,S-1), mino(XX,YY,S), at(X,Y,S-1).

% Define the possible moves from one field to another considering the Minotaur's position and the player's position at a certain step, and the maximum number of steps, and the start field, and the goal field, and the previous move, and the current move, and the next move, and the Minotaur's position at the next step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the Minotaur's position at the previous step, and the Minotaur's position at the current step, and the player's position at the previous step, and the player's position at the current step
move(X,Y,XX,YY,S) :- field(X,Y), field(XX,YY), |X-XX| + |Y
% The player cannot be in the same field as the Minotaur
:- at(X,Y,S), mino(X,Y).

% The player cannot move to a field that is not adjacent to their current position
:- at(X,Y,S), not at(XX,YY,S-1), not wall(X,Y,XX,YY).

% The player cannot move to a field that is blocked by a wall
:- at(X,Y,S), wall(X,Y,XX,YY), at(XX,YY,S-1).

% The player cannot move more than the maximum number of steps
:- at(X,Y,S), S > maxsteps(S).

% The player must reach the goal field
:- not at(X,Y,S), goal(X,Y).

% The player must start at the start field
:- not at(X,Y,0), start(X,Y).

% The player must move to an adjacent field
:- at(X,Y,S), not at(XX,YY,S-1), not wall(X,Y,XX,YY), abs(X-XX) + abs(Y-YY) > 1.