% Initial parameters
row(1..N).
column(1..M).
cell(X,Y) :- row(X), column(Y).

% A cell is blackened if it is not white
blackened(X,Y) :- cell(X,Y), not white(X,Y).

% A cell is white if it is not blackened
white(X,Y) :- cell(X,Y), not blackened(X,Y).

% A cell is connected to another cell if they are both white and there is a path between them
connected(X,Y,X',Y') :- white(X,Y), white(X',Y'), path(X,Y,X',Y').

% There must be a path between any two white cells
bad(X,Y,X',Y') :- white(X,Y), white(X',Y'), not connected(X,Y,X',Y').

% The number in a circle indicates how many of the 4 adjacent cells must be blackened
bad(X,Y) :- number(X,Y,N), count_blackened_adjacent(X,Y,C), N != C.

% Count the number of blackened cells adjacent to a given cell
count_blackened_adjacent(X,Y,C) :- blackened(X+1,Y), C = C+1.
count_blackened_adjacent(X,Y,C) :- blackened(X-1,Y), C = C+1.
count_blackened_adjacent(X,Y,C) :- blackened(X,Y+1), C = C+1.
count_blackened_adjacent(X,Y,C) :- blackened(X,Y-1), C = C+1.
count_blackened_adjacent(X,Y,C) :- C = 0.

% There should be no blackened cells adjacent to a number cell
bad(X,Y) :- number(X,Y), blackened(X+1,Y).
bad(X,Y) :- number(X,Y), blackened(X-1,Y).
bad(X,Y) :- number(X,Y), blackened(X,Y+1).
bad(X,Y) :- number(X,Y), blackened(X,Y-1).