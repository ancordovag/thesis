% The size of the subgrid is defined
size(Subgrid) :- subgrid(Subgrid).% The possible digits are from 1 to S times S, being S the size of the subgrid
digit(1..S*S).% The identifier of the subgrid goes from 0 to the possible digits minus 1
subgrid(ID) :- ID = 0..digits-1.% A map is defined between X and Y, indicating the number of subgrid in which they belong
% The corresponding ASP rule would be:

belongs(X,Y) :- map(X,Y).% A predicate that indicates which cell has a value in the beginning
initial_cell(X, Y, Value) :- cell(X, Y), number(Value).% the initial value of each cell in another predicate poss
cell(X,Y) :- poss(X,Y,_).% Generation of all possible digits for the cells that were not initialized 
% ASP rule
{ cell(X,Y,N) : digit(N) } 1 :- not initial(X,Y,N), cell(X,Y).% For each cell, choose only one possibility of digit 
1 { cell(X,Y,N) : digit(N) } 1 :- cell(X,Y,_).% For each column and digit, choose only one possibility of row 
1 { chosen(R, C, D) : row(R) } 1 :- column(C), digit(D).% For each row and digit, choose only one possibility of column
1 { chosen(R, D, C) : column(C) } 1 :- row(R), digit(D).% For each digit and subgrid, choose only one possibility for each subgrid identifier in map
1 { digit(X,Y,N) : num(N) } 1 :- subgrid(X,Y), map(X,Y,N).% It cannot be the case that a initial value in cell (X,Y) is not the same as sudoku in cell (X,Y)
:- not sudoku(X,Y,N), initial(X,Y,N).% Show the goal predicate
goal :- not not_goal.