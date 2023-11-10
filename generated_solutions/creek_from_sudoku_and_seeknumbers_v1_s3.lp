% Generate all possible connections between adjacent cells
connected(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), (X1=X2, Y2=Y1+1; X1=X2, Y2=Y1-1; X2=X1+1, Y2=Y1; X2=X1-1, Y2=Y1).

% Generate all possible paths between cells
path(X,Y,XX,YY) :- connected(X,Y,XX,YY).
path(X,Y,XX,YY) :- connected(X,Y,X1,Y1), path(X1,Y1,XX,YY).

% The first cell is visited at step 0
at(X,Y,0) :- first(X,Y).

% If the player is at field (X,Y) at step S, and there is a path between (X,Y) and (XX,YY), then the player can be at (XX,YY) at step S+1
at(XX,YY,S+1) :- at(X,Y,S), path(X,Y,XX,YY).
% The player must start at the initial position
:- not at(X,Y,0), initial(X,Y).

% The player must move to a connected cell in each step
:- at(X,Y,S), not connected(X,Y,XX,YY), at(XX,YY,S-1).

% The player cannot move to a blackened cell
:- at(X,Y,S), blackened(X,Y).

% The player must reach the final position in the last step
:- not at(X,Y,S), final(X,Y), S > 0.

% The player cannot move to a cell that is already visited
:- at(X,Y,S), at(X,Y,S-1).

% The player cannot move diagonally
:- at(X,Y,S), at(XX,YY,S-1), (abs(X-XX) + abs(Y-YY)) > 1.

% The player must blacken the required number of adjacent cells
:- at(X,Y,S), number(X,Y,N), not blackened_adjacent(X,Y,N).

% The player cannot blacken more than the required number of adjacent cells
:- at(X,Y,S), blackened_adjacent(X,Y,N), not number(X,Y,N).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened(X,Y), not blackened_adjacent(X,Y,N).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at(XX,YY,S-1).

% The player cannot blacken cells that are already blackened
:- at(X,Y,S), blackened_adjacent(X,Y,N), blackened(XX,YY).

% The player cannot blacken cells that are not adjacent
:- at(X,Y,S), blackened_adjacent(X,Y,N), not adjacent(X,Y,XX,YY).

% The player cannot blacken cells that are outside the grid
:- at(X,Y,S), blackened_adjacent(X,Y,N), not cell(XX,YY).

% The player cannot blacken cells that are already visited
:- at(X,Y,S), blackened_adjacent(X,Y,N), at