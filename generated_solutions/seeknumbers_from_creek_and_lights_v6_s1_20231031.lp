% The first cell of the path must be the cell marked with a white circle
possible_path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).

% The final cell of the path must be the cell marked with a black circle
possible_path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY).

% The path must traverse each remaining cell of the grid without crossing or intersecting itself
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), not path(XX,YY,X,Y).

% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path must bend exactly as often as the number in the first cell indicates
possible_path(X,Y,XX,YY) :- hint(X,Y,N), cell(XX,YY), (N=0 ; path_bends(X,Y,XX,YY,N)).

% The path must not bend between the cell marked with a white circle and the first cell with a number
possible_path(X,Y,XX,YY) :- first(X,Y), hint(XX,YY,_), not path_bends(X,Y,XX,YY,_).

% Helper rule to check if the path bends exactly as often as the number in the first cell indicates
path_bends(X,Y,XX,YY,N) :- count_bends(X,Y,XX,YY,C), C=N.

% Helper rule to count the number of bends in the path between two cells
count_bends(X,Y,XX,YY,C) :- path(X,Y,XX,YY), count_bends_helper(X,Y,XX,YY,0,C).

% Base case: When the two cells are adjacent, there are no bends
count_bends_helper(X,Y,XX,YY,C,C) :- adjacent(X,Y,XX,YY).

% Recursive case: Count bends by checking each adjacent pair of cells in the path
count_bends_helper(X,Y,XX,YY,Acc,C) :- path(X,Y,X1,Y1), path(X1,Y1,XX,YY), bend(X,Y,X1,Y1,X2,Y2), NewAcc is Acc+1, count_bends_helper(X1,Y1,XX,YY,NewAcc,C).

% Helper rule to check if two cells are adjacent
adjacent(X,Y,XX,YY) :- (X=XX, abs(Y-YY)=1) ; (Y=YY, abs(X-XX)=1).

% Helper rule to check if there is a bend between two cells
bend(X,Y,X1,Y1,X2,Y2) :- (X=X1, Y1\=Y2, X2\=X1, Y2\=Y1) ; (Y=Y1, X1\=X2, Y2\=Y1, X2\=X1).