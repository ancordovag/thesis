% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible positions of cells
cell(X,Y) :- rows(X), columns(Y).

% Define the possible positions of numbers
number(X,Y,N) :- numbers(N), cell(X,Y).

% Define the possible positions of black cells
black(X,Y) :- area(black), cell(X,Y).

% Define the possible positions of white cells
white(X,Y) :- area(white), cell(X,Y).

% Define the possible paths between cells
path(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), (X1 != X2 ; Y1 != Y2), |X1-X2| + |Y1-Y2| = 1.

% Define the number of bends in a path segment
bends(X1,Y1,X2,Y2,B) :- path(X1,Y1,X2,Y2), B = #count{X,Y : path(X1,Y1,X,Y), path(X,Y,X2,Y2), (X != X1 ; Y != Y1)}.

% Define the start and end cells of a path
start(X,Y) :- path(X,Y,_,_).
end(X,Y) :- path(_,_,X,Y).

% If a cell is not black, it should be white
white(X,Y) :- not black(X,Y), cell(X,Y).
% If a cell is not white, it should be black
black(X,Y) :- not white(X,Y), cell(X,Y).

% Show output predicates
#show black/2.
#show white/2.
#show number/3.
#show path/4.
#show bends/5.
#show start/2.
#show end/2.
% The path starts at the cell marked with a white circle
start(X,Y) :- white(X,Y).

% The path ends at the cell marked with a black circle
end(X,Y) :- black(X,Y).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- direction(X1,Y1,X2,Y2), direction(X3,Y3,X4,Y4), (X1,Y1) != (X3,Y3), (X1,Y1) != (X4,Y4), (X2,Y2) != (X3,Y3), (X2,Y2) != (X4,Y4), intersects(X1,Y1,X2,Y2,X3,Y3,X4,Y4).

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
bends(X1,Y1,X2,Y2,B) :- number(X1,Y1,N), direction(X1,Y1,X2,Y2), count_bends(X1,Y1,X2,Y2,B), B != N.

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- white(X1,Y1), number(X2,Y2,_), direction(X1,Y1,X2,Y2), bends(X1,Y1,X2,Y2,_).

% Helper predicate to count the number of bends in a path segment
count_bends(X1,Y1,X2,Y2,B) :- B = #count {X3,Y3 : direction(X1,Y1,X3,Y3), (X3,Y3) != (X1,Y1), (X3,Y3) != (X2,Y2)}.

% Helper predicate to check if two path segments intersect
intersects(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- (X1,Y1) != (X2,Y2), (X1,Y1) != (X3,Y3), (X1,Y1) != (X4,Y4), (X2,Y2) != (X3,Y3), (X2,Y2) != (X4,Y4), intersects_horizontal(X1,Y1,X2,Y2,X3,Y3,X4,Y4), intersects_vertical(X1,Y1,X2,Y2,X3,Y3,X4,Y4).

% Helper predicate to check if two horizontal path segments intersect
intersects_horizontal(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- Y1 = Y2, Y3 = Y4, Y1 = Y3, X1 < X3, X3 < X2, X2 < X4.
intersects_horizontal(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- Y1 = Y2, Y3 = Y4, Y1 = Y3, X3 < X1, X1 < X4, X4 < X2.

% Helper predicate to check if two vertical path segments intersect
intersects_vertical(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- X1 = X2, X3 = X4, X1 = X3, Y1 < Y3, Y3 < Y2, Y2 < Y4.
intersects_vertical(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- X1 = X2, X3 = X4, X1 = X3, Y3 < Y1, Y1 < Y4, Y4 < Y2.