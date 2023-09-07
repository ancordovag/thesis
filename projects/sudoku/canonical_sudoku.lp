% Please insert the names and email addresses of the group members:
%
%

subgrid_size(3).

% HINTS:
% - For subgrid_size(s), subgrids can be identified by labels 0..s*s-1
% - A cell (x,y) can be mapped to the subgrid labeled (((x-1)/s)*s + (y-1)/s)

% Your implementation please...

dim(1..S*S) :- subgrid_size(S).

subgrid(D-1) :- dim(D).

map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).

init(X,Y) :- initial(X,Y,N).

poss(X,Y,N) :- initial(X,Y,N).
poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).

1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).

:- initial(X,Y,N), not sudoku(X,Y,N).

#show sudoku/3.