% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not black.
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not black(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhint is 0 in the cell (XX,YY) when there is an edge between first cell (X,Y)
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction is the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% There should be a match between index of row, index of column and digit.
match(Ir,Ic,D) :- index_of_row(Ir), index_of_column(Ic), digits(D).

% The size of the subgrid is defined
subgrid_size(3).
% The possible digits are from 1 to S times S, being S the size of the subgrid
dim(1..S*S) :- subgrid_size(S).
% The identifier of the subgrid goes from 0 to the possible digits minus 1
subgrid(D-1) :- dim(D).
% A map is defined between X and Y, indicating the number of subgrid in which they belong
map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).
% A predicate that indicates which cell has a value in the beginning
init(X,Y) :- initial(X,Y,N).
% the initial value of each cell in another predicate poss
poss(X,Y,N) :- initial(X,Y,N).
% Generation of all possible digits for the cells that were not initialized 
poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).

% For each cell, choose only one possibility of digit 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
% For each column and digit, choose only one possibility of row 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
% For each row and digit, choose only one possibility of column
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
% For each digit and subgrid, choose only one possibility for each subgrid identifier in map
1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).

% Every cell cell(X,Y) should be either black or white
color(X,Y,C).

% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY).

% The cell at coordinates (X,Y) is blackened
black(X,Y).
% It cannot be the case that a cell is not colored
:- cell(X,Y), not color(X,Y,_).
% It cannot be the case that a cell is both black and white
:- black(X,Y), color(X,Y,white).
% It cannot be the case that a cell is neither black nor white
:- cell(X,Y), not color(X,Y,black), not color(X,Y,white).
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,black), N = 4.
% It cannot be the case that a cell is white and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,white), N = 4.
% It cannot be the case that a cell is black and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,black), N < 4.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,white), N < 4.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,black), N = 4.
% It cannot be the case that a cell is white and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,white), N = 4.
% It cannot be the case that a cell is black and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,black), N < 4.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,white), N < 4.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,black), N = 4.
% It cannot be the case that a cell is white and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,white), N = 4.
% It cannot be the case that a cell is black and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,black), N < 4.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,white), N < 4.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,black), N = 4.
% It cannot be the case that a cell is white and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,white), N = 4.
% It cannot be the case that a cell is black and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,black), N < 4.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,white), N < 4.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,black), N = 4.
% It cannot be the case that a cell is white and has a hint number equal to 4
:- hint(X,Y,N), color(X,Y,white), N = 4.
% It cannot be the case that a cell is black and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,black), N < 4.
% It cannot be the case that a cell is white and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,white), N > 0.
% It cannot be the case that a cell is black and has a hint number greater than 0
:- hint(X,Y,N), color(X,Y,black), N > 0.
% It cannot be the case that a cell is white and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,white), N = 0.
% It cannot be the case that a cell is black and has a hint number equal to 0
:- hint(X,Y,N), color(X,Y,black), N = 0.
% It cannot be the case that a cell is white and has a hint number less than 4
:- hint(X,Y,N), color(X,Y,white), N < 4.
% It cannot be the case that a cell is black and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,black), N > 4.
% It cannot be the case that a cell is white and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,white), N < 0.
% It cannot be the case that a cell is black and has a hint number less than 0
:- hint(X,Y,N), color(X,Y,black), N < 0.
% It cannot be the case that a cell is white and has a hint number greater than 4
:- hint(X,Y,N), color(X,Y,white), N > 4.
% It cannot be the case that a cell is black and has a hint number equal to 4
