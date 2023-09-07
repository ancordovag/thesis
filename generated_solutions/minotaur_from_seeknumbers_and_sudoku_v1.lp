Problem 1:

% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, rows(X), columns(Y), rows(XX), columns(YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, rows(X), columns(Y), rows(XX), columns(YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, rows(X), columns(Y), rows(XX), columns(YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, rows(X), columns(Y), rows(XX), columns(YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- rows(X), columns(Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhintand cell (XX,YY), and it is 0 in the cell (XX,YY) when 
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

Problem 2:

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

% Show the goal predicate
#show sudoku/3.

Problem 3:

% Define the field
field(X,Y) :- rows(X), columns(Y).

% Define the start position
start(X,Y) :- initial(X,Y).

% Define the goal position
goal(X,Y) :- final(X,Y).

% Define the mino position
mino(X,Y) :- mino(X,Y).

% Define the wall position
wall(X,Y,XX,YY) :- walls(X,Y,XX,YY).

% Define the maximum number of steps
maxsteps(S) :- steps(S).

% Define the current position at step S
at(X,Y,S) :- current(X,Y,S).
Problem 1:
Constraints:
- It cannot be the case that there is not an incoming edge to a cell if that cell is not the first one.
- It cannot be the case that a cell is not visited.
- It cannot be the case that the counter xhint is not 0 in the cell of a hint.
- It cannot be the case that the counter xhint is not 0 in the final cell.

Problem 2:
Constraints:
- It cannot be the case that the initial state of the grid does not satisfy the Sudoku rules.

Problem 3:
Constraints:
No constraints found.