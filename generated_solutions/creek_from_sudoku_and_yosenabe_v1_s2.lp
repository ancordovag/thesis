% Each cell must have a position
1 { position(X,Y) : rows(X), columns(Y) } 1 :- not blackened(X,Y).

% Each cell can have at most one hint
:- hint(X,Y,N), hint(X,Y,M), N != M.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X = X'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X = X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y'), X != X', Y != Y'.

% Each cell can have at most one position
:- position(X,Y), position(X',Y), X != X', Y = Y'.

% Each cell can have at most one position
:- position(X,Y), position(X,Y'), Y = Y
% For each cell, it is either blackened or not
{ blackened(X,Y) } :- position(X,Y).

% A cell is blackened if and only if it has a hint
blackened(X,Y) :- hint(X,Y,_).

% A cell is not blackened if and only if it does not have a hint
:- position(X,Y), not blackened(X,Y), hint(X,Y,_).

% A cell is blackened if and only if it has the required number of blackened adjacent cells
blackened(X,Y) :- hint(X,Y,N), count_blackened_adjacent(X,Y,N).

% A cell is not blackened if and only if it does not have the required number of blackened adjacent cells
:- position(X,Y), not blackened(X,Y), hint(X,Y,N), not count_blackened_adjacent(X,Y,N).

% Count the number of blackened adjacent cells for a given cell
count_blackened_adjacent(X,Y,N) :- count_adjacent(X,Y,Count), Count = N.

% Count the number of blackened adjacent cells for a given cell
count_adjacent(X,Y,Count) :- count_adjacent_right(X,Y,Count1), count_adjacent_left(X,Y,Count2), count_adjacent_up(X,Y,Count3), count_adjacent_down(X,Y,Count4), Count = Count1 + Count2 + Count3 + Count4.

% Count the number of blackened adjacent cells to the right of a given cell
count_adjacent_right(X,Y,Count) :- position(X,Y), position(X+1,Y), blackened(X+1,Y), Count = 1.
count_adjacent_right(X,Y,Count) :- position(X,Y), position(X+1,Y), not blackened(X+1,Y), Count = 0.

% Count the number of blackened adjacent cells to the left of a given cell
count_adjacent_left(X,Y,Count) :- position(X,Y), position(X-1,Y), blackened(X-1,Y), Count = 1.
count_adjacent_left(X,Y,Count) :- position(X,Y), position(X-1,Y), not blackened(X-1,Y), Count = 0.

% Count the number of blackened adjacent cells above a given cell
count_adjacent_up(X,Y,Count) :- position(X,Y), position(X,Y-1), blackened(X,Y-1), Count = 1.
count_adjacent_up(X,Y,Count) :- position(X,Y), position(X,Y-1), not blackened(X,Y-1), Count = 0.

% Count the number of blackened adjacent cells below a given cell
count_adjacent_down(X,Y,Count) :- position(X,Y), position(X,Y+1), blackened(X,Y+1), Count = 1.
count_adjacent_down(X,Y,Count) :- position(X,Y), position(X,Y+1), not blackened(X,Y+1), Count = 0.