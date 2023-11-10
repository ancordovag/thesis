% Generate all possible matches between index of row, index of column, and digit
match(Ir,Ic,D) :- index_of_row(Ir), index_of_column(Ic), digits(D).

% Generate all possible blackened cells
black(X,Y) :- rows(X), columns(Y).

% Generate all possible paths between cells
path(X1,Y1,X2,Y2) :- rows(X1), columns(Y1), rows(X2), columns(Y2), (X1,Y1) != (X2,Y2).
% The path starts at the cell marked with a white circle and ends at the cell marked with a black circle
path(X1,Y1,X2,Y2) :- first(X1,Y1), final(X2,Y2).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- path(X1,Y1,X2,Y2), path(X3,Y3,X4,Y4), (X1,Y1) != (X3,Y3), (X1,Y1) != (X4,Y4), (X2,Y2) != (X3,Y3), (X2,Y2) != (X4,Y4), intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4).

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
:- hint(X1,Y1,N), path(X1,Y1,X2,Y2), not bend(X1,Y1,X2,Y2,N).

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- first(X1,Y1), hint(X2,Y2,_), path(X1,Y1,X2,Y2), not bend(X1,Y1,X2,Y2,0).

% Every problem instance contains exactly one fact over first/2 and one fact over final/2
1 { first(X,Y) } 1 :- cell(X,Y).
1 { final(X,Y) } 1 :- cell(X,Y).

% There should be a match between index of row, index of column and digit
match(Ir,Ic,D) :- index_of_row(Ir), index_of_column(Ic), digits(D).

% The cell at the coordinates (X,Y) is blackened
black(X,Y) :- cell(X,Y), not white(X,Y).

% The path has an edge between the cells (X1,Y1) and (X2,Y2)
path(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), adjacent(X1,Y1,X2,Y2).

% The cells (X1,Y1) and (X2,Y2) are adjacent
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2,Y2+1).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2,Y2-1).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2+1,Y2).
adjacent(X1,Y1,X2,Y2) :- (X1,Y1) = (X2-1,Y2).

% The cells (X1,Y1) and (X2,Y2) intersect
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X3,Y3), (X2,Y2) = (X4,Y4).
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X4,Y4), (X2,Y2) = (X3,Y3).
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X3,Y3), (X2,Y2) = (X4,Y4+1).
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X3,Y3), (X2,Y2) = (X4,Y4-1).
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X3,Y3+1), (X2,Y2) = (X4,Y4).
intersect(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) = (X3,Y3-1), (X2,Y2) = (X4,Y4).

% The path bends exactly N times between the cells (X1,Y1) and (X2,Y2)
bend(X1,Y1,X2,Y2,N) :- path(X1,Y1,X2,Y2), count_bends(X1,Y1,X2,Y2,N).

% Count the number of bends between the cells (X1,Y1) and (X2,Y2)
count_bends(X1,Y1,X2,Y2,N) :- count_bends(X1,Y1,X2,Y2,0,N).

% Base case: no more cells to check
count_bends(X1,Y1,X2,Y2,N,N) :- (X1,Y1) = (X2,Y2).

% Case 1: the next cell is to the right
count_bends(X1,Y1,X2,Y2,Count,N) :- (X1,Y1) = (X2-1,Y2), count_bends(X2,Y2,X2-1,Y2,Count+1,N).

% Case 2: the next cell is to the left
count_bends(X1,Y1,X2,Y2,Count,N) :- (X1,Y1) = (X2+1,Y2), count_bends(X2,Y2,X2+1,Y2,Count+1,N).

% Case 3: the next cell is above
count_bends(X1,Y1,X2,Y2,Count,N) :- (X1,Y1) = (X2,Y2+1), count_bends(X2,Y2,X2,Y2+1,Count+1,N).

% Case 4: the next cell is below
count_bends(X1,Y1,X2,Y2,Count,N) :- (X1,Y1) = (X2,Y2-1), count_bends(X2,Y2,X2,Y2-1,Count+1,N).