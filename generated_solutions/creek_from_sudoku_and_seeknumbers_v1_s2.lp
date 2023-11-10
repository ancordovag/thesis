% Generate all possible combinations of blackened and white cells
1 { blackened(X,Y) ; white(X,Y) } 1 :- cell(X,Y).

% A cell cannot be both blackened and white
:- blackened(X,Y), white(X,Y).

% Generate all possible connections between white cells
connected(X1,Y1,X2,Y2) :- white(X1,Y1), white(X2,Y2), (X1,Y1) != (X2,Y2).

% Generate all possible combinations of blackened_adjacent
1 { blackened_adjacent(X,Y,N) : N=0..4 } 1 :- cell(X,Y), blackened(X,Y).

% A blackened_adjacent cell must have exactly N blackened cells adjacent to it
:- blackened_adjacent(X,Y,N), count_adjacent_blackened(X,Y,C), C != N.

% Count the number of blackened cells adjacent to a given cell
count_adjacent_blackened(X,Y,C) :- cell(X,Y), C = #count { blackened(XX,YY) : adjacent(X,Y,XX,YY) }.

% Define the adjacency relation between cells
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2,Y2+1).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2,Y2-1).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2+1,Y2).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2-1,Y2).

% Show output predicates
#show blackened/2.
#show white/2.
#show connected/4.
#show blackened_adjacent/3.
% It cannot be the case that a cell is both blackened and white
:- blackened(X,Y), white(X,Y).

% It cannot be the case that a cell is neither blackened nor white
:- not blackened(X,Y), not white(X,Y).

% It cannot be the case that a cell is blackened and has a hint
:- blackened(X,Y), hint(X,Y,_).

% It cannot be the case that a cell is white and has a hint
:- white(X,Y), hint(X,Y,_).

% There must be a connection between adjacent white cells
connected(X1,Y1,X2,Y2) :- white(X1,Y1), white(X2,Y2), neighbour(X1,Y1,X2,Y2).

% The number of blackened cells adjacent to a hint must be equal to the hint value
:- hint(X,Y,N), count_blackened_adjacent(X,Y,C), C != N.

% Count the number of blackened cells adjacent to a cell
count_blackened_adjacent(X,Y,C) :- blackened(X1,Y1), neighbour(X,Y,X1,Y1), C = #count { blackened(X1,Y1) : neighbour(X,Y,X1,Y1) }.

% Count the number of white cells adjacent to a cell
count_white_adjacent(X,Y,C) :- white(X1,Y1), neighbour(X,Y,X1,Y1), C = #count { white(X1,Y1) : neighbour(X,Y,X1,Y1) }.

% The number of blackened cells adjacent to a cell must be equal to the number of adjacent white cells minus the hint value
:- hint(X,Y,N), count_white_adjacent(X,Y,C), count_blackened_adjacent(X,Y,B), C - B != N.