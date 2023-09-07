% The cell (X,Y) is blackened if there is a hint at that cell
black(X,Y) :- hint(X,Y,_).

% The cell (X,Y) is not blackened if there is no hint at that cell
not black(X,Y) :- cell(X,Y), not hint(X,Y,_).

% The cell (X,Y) is blackened if there is a hint at that cell and the number of adjacent black cells is equal to the hint number
black(X,Y) :- hint(X,Y,N), count_black_adjacent(X,Y,N).

% The cell (X,Y) is not blackened if there is a hint at that cell and the number of adjacent black cells is not equal to the hint number
not black(X,Y) :- hint(X,Y,N), not count_black_adjacent(X,Y,N).

% Counts the number of adjacent black cells to the cell (X,Y)
count_black_adjacent(X,Y,N) :- count_adjacent(X,Y,0,N).

% Base case: If the number of adjacent cells counted is equal to the hint number, stop counting
count_adjacent(_,_,N,N).

% Recursive case: Count the number of adjacent black cells
count_adjacent(X,Y,Count,N) :- black_adjacent(X,Y), NewCount is Count + 1, count_adjacent(X,Y,NewCount,N).

% Check if there is a blackened cell adjacent to the cell (X,Y)
black_adjacent(X,Y) :- cell(X,Y), adjacent(X,Y,XX,YY), black(XX,YY).

% Generate all possible adjacent cells to the cell (X,Y)
adjacent(X,Y,XX,YY) :- XX=X+1, YY=Y, cell(X,Y), cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX=X-1, YY=Y, cell(X,Y), cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX=X, YY=Y+1, cell(X,Y), cell(XX,YY).
adjacent(X,Y,XX,YY) :- XX=X, YY=Y-1, cell(X,Y), cell(XX,YY).
% It cannot be the case that a cell is blackened and also a hint cell
:- black(X,Y), hint(X,Y,_).

% It cannot be the case that a cell is not blackened and also not a hint cell
:- not black(X,Y), not hint(X,Y,_).

% It cannot be the case that a cell is blackened and has more than N blackened neighbors
:- black(X,Y), hint(X,Y,N), count_black_neighbors(X,Y,C), C > N.

% It cannot be the case that a cell is not blackened and has less than N blackened neighbors
:- not black(X,Y), hint(X,Y,N), count_black_neighbors(X,Y,C), C < N.

% Count the number of blackened neighbors of a cell
count_black_neighbors(X,Y,C) :- black(X+1,Y), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X,Y+1), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X+1,Y+1), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X-1,Y), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X,Y-1), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X-1,Y-1), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X+1,Y-1), C = C + 1.
count_black_neighbors(X,Y,C) :- black(X-1,Y+1), C = C + 1.

% Show output predicate
#show black/2.