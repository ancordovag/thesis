% The player is at the initial field at step 0
at(X,Y,0) :- initial(X,Y).

% The player can stay in the same field at each step
at(X,Y,S) :- at(X,Y,S-1).

% The player can move to an adjacent field at each step
at(XX,YY,S) :- at(X,Y,S-1), neighbour(X,Y,XX,YY), not minotaur(XX,YY,S).

% The Minotaur can move to an adjacent field at each step
minotaur(XX,YY,S) :- minotaur(X,Y,S-1), neighbour(X,Y,XX,YY), not at(XX,YY,S).

% The Minotaur tries to move right or left to become closer to the player
minotaur(XX,YY,S) :- minotaur(X,Y,S-1), XX=X+2, YY=Y, not at(XX,YY,S).

% The Minotaur tries to move up or down to become closer to the player
minotaur(XX,YY,S) :- minotaur(X,Y,S-1), XX=X, YY=Y+2, not at(XX,YY,S).

% The Minotaur does not move if it cannot become closer to the player
minotaur(X,Y,S) :- minotaur(X,Y,S-1), not at(X,Y,S).

% The player wins if they reach the goal field and the Minotaur never moves to the same field
:- at(X,Y,S), goal(X,Y), minotaur(X,Y,S).
% It cannot be the case that the player is at the same field as the Minotaur at any step
:- at(X,Y,S), minotaur(X,Y,S).

% It cannot be the case that the player is at the goal field and the Minotaur is also at the goal field at any step
:- at(X,Y,S), goal(X,Y), minotaur(X,Y,S).

% It cannot be the case that the player is at the same field as the Minotaur at consecutive steps
:- at(X,Y,S), at(X,Y,S+1), minotaur(X,Y,S), minotaur(X,Y,S+1).

% It cannot be the case that the player is at the same field as the Minotaur at consecutive steps in different directions
:- at(X,Y,S), at(XX,YY,S+1), minotaur(X,Y,S), minotaur(XX,YY,S+1), not neighbour(X,Y,XX,YY).

% It cannot be the case that the player is at the same field as the Minotaur at consecutive steps in the same direction
:- at(X,Y,S), at(XX,YY,S+1), minotaur(X,Y,S), minotaur(XX,YY,S+1), neighbour(X,Y,XX,YY), not same_direction(X,Y,XX,YY).

% Show output predicate
#show at/3.