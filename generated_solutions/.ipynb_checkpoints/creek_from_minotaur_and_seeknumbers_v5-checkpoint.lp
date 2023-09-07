% The cell at coordinates (X,Y) is blackened if there is a number in a circle indicating that exactly N of its 4 adjacent cells must be blackened
black(X,Y) :- number(X,Y,N), black_adjacent(X,Y,N).

% The cell at coordinates (X,Y) has N blackened adjacent cells
black_adjacent(X,Y,N) :- count_adjacent(X,Y,N).

% Count the number of blackened adjacent cells for a given cell at coordinates (X,Y)
count_adjacent(X,Y,N) :- count_black(X,Y,0,N).

% Base case: If N is 0, there are no more blackened adjacent cells to count
count_black(_,_,N,N).

% Recursive case: Count the number of blackened adjacent cells by incrementing the count for each blackened adjacent cell
count_black(X,Y,Count,N) :- adjacent(X,Y,XX,YY), black(XX,YY), NewCount is Count + 1, count_black(X,Y,NewCount,N).

% Define the adjacent cells for a given cell at coordinates (X,Y)
adjacent(X,Y,XX,YY) :- XX is X+1, YY is Y, cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX is X-1, YY is Y, cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX is X, YY is Y+1, cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX is X, YY is Y-1, cell(XX,YY).
% It cannot be the case that a cell is blackened and also visited
:- black(X,Y), visited(X,Y).

% It cannot be the case that a cell is blackened and also a hint
:- black(X,Y), hint(X,Y,_).

% It cannot be the case that a cell is not blackened and also not visited
:- not black(X,Y), not visited(X,Y).

% It cannot be the case that a cell is not blackened and also not a hint
:- not black(X,Y), not hint(X,Y,_).

% Show output predicate
#show black/2.