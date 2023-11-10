% All the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0). 

% A cell is adjacent to another cell if they have a difference of 1 in either the x or y coordinate
adjacent(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), (X1 = X2, (Y1 = Y2 + 1; Y1 = Y2 - 1); Y1 = Y2, (X1 = X2 + 1; X1 = X2 - 1)).

% A cell is connected to another cell if they are adjacent and both cells are white
connected(X1,Y1,X2,Y2) :- adjacent(X1,Y1,X2,Y2), not black(X1,Y1), not black(X2,Y2).

% A cell is black if it is a hint and the number of adjacent black cells matches the hint number
black(X,Y) :- hint(X,Y,N), countblack(X,Y,N).

% Count the number of adjacent black cells for a given cell
countblack(X,Y,N) :- N = #count{black(I,J) : adjacent(X,Y,I,J)}.

% A cell is white if it is not black
white(X,Y) :- cell(X,Y), not black(X,Y).

% All white cells must be connected
connected_white :- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).

% A solution is valid if all white cells are connected and the black cells match the hint numbers
valid_solution :- connected_white, black(X,Y), hint(X,Y,N), countblack(X,Y,N).