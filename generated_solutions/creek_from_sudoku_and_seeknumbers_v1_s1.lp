% Generate all possible cells
cell(X,Y) :- rows(X), columns(Y).

% Generate all possible connections between white cells
connected(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), X1!=X2, Y1!=Y2.

% Generate all possible numbers that can be blackened in a cell
blackened(X,Y,N) :- cell(X,Y), digits(N).

% Show output predicates
#show connected/4.
#show blackened/3.
% It cannot be the case that a cell is both blackened and white
:- cell(X,Y), blackened(X,Y,_), not blackened(X,Y,0).
% It cannot be the case that a cell is neither blackened nor white
:- cell(X,Y), not blackened(X,Y,_), not blackened(X,Y,0).
% It cannot be the case that a cell is connected to another cell if they are not both white
:- connected(X1,Y1,X2,Y2), not cell(X1,Y1), cell(X2,Y2).
% It cannot be the case that a cell is connected to another cell if they are not both white
:- connected(X1,Y1,X2,Y2), cell(X1,Y1), not cell(X2,Y2).
% For each cell, the number of adjacent blackened cells must be equal to the number in the circle
:- blackened(X,Y,N), count_blackened_adjacent(X,Y,C), N != C.
% For each cell, the number of adjacent blackened cells must be less than or equal to 4
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C > 4.
% For each cell, the number of adjacent blackened cells must be greater than or equal to 0
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C < 0.
% For each cell, the number of adjacent blackened cells must be less than or equal to 4
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C > 4.
% For each cell, the number of adjacent blackened cells must be greater than or equal to 0
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C < 0.
% For each cell, if it is blackened, then it must have at least one adjacent white cell
:- blackened(X,Y,_), not has_white_adjacent(X,Y).
% For each cell, if it is white, then it must have at least one adjacent blackened cell
:- cell(X,Y), not blackened(X,Y,_), not has_blackened_adjacent(X,Y).
% For each cell, if it is blackened, then it must have at most three adjacent blackened cells
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C > 3.
% For each cell, if it is white, then it must have at most three adjacent white cells
:- cell(X,Y), not blackened(X,Y,_), count_white_adjacent(X,Y,C), C > 3.
% For each cell, if it is blackened, then it must have at least one adjacent white cell
:- blackened(X,Y,_), not has_white_adjacent(X,Y).
% For each cell, if it is white, then it must have at least one adjacent blackened cell
:- cell(X,Y), not blackened(X,Y,_), not has_blackened_adjacent(X,Y).
% For each cell, if it is blackened, then it must have at most three adjacent blackened cells
:- blackened(X,Y,_), count_blackened_adjacent(X,Y,C), C > 3.
% For each cell, if it is white, then it must have at most three adjacent white cells
:- cell(X,Y), not blackened(X,Y,_), count_white_adjacent(X,Y,C), C > 3.