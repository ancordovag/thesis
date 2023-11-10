% Generate all possible positions for the cells
position(X,Y) :- category(index_of_row), constant(X), category(index_of_column), constant(Y).

% Generate all possible blackened cells
blackened(X,Y) :- position(X,Y), category(area), constant(gray area).

% Generate all possible numbers for the cells
number(X,Y,N) :- position(X,Y), category(digits), constant(N).

% Generate all possible orthogonally connected areas
connected(X,Y) :- position(X,Y), category(area), constant(gray area).

#show position/2.
#show blackened/2.
#show number/3.
#show connected/2.
% For each cell, it must be either blackened or connected
:- position(X,Y), not blackened(X,Y), not connected(X,Y).
% For each blackened cell, it must not be connected to any other blackened cell
:- blackened(X,Y), connected(X,Y), blackened(X1,Y1), connected(X1,Y1), (X,Y) != (X1,Y1).
% For each number, the number of blackened cells adjacent to it must be equal to the number itself
:- number(X,Y,N), count_adjacent_blackened(X,Y,C), C != N.
% For each white cell, it must be connected to at least one other white cell
:- position(X,Y), not connected(X,Y), position(X1,Y1), not connected(X1,Y1), (X,Y) != (X1,Y1).
% For each white cell, it must not be connected to any blackened cell
:- position(X,Y), connected(X,Y), blackened(X1,Y1), (X,Y) != (X1,Y1).
% For each blackened cell, it must be connected to at least one other blackened cell
:- blackened(X,Y), not connected(X,Y), blackened(X1,Y1), not connected(X1,Y1), (X,Y) != (X1,Y1).
% For each blackened cell, it must not be connected to any white cell
:- blackened(X,Y), connected(X,Y), position(X1,Y1), (X,Y) != (X1,Y1).