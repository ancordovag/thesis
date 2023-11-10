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

% It cannot be the case that a initial value in cell (X,Y) is not the same as sudoku in cell (X,Y)
:- initial(X,Y,N), not sudoku(X,Y,N).

% Show the goal predicate
#show sudoku/3.


