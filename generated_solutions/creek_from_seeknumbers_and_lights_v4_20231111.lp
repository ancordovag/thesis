% Define the possible directions from a cell, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

% Define neighbors for each cell given a delta
neighbor(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Generate minimum 0 predicate black for cell(X,Y) if this is not a hint.  
{ black(X,Y) } :- cell(X,Y), not hint(X,Y,_).

% A cell with a hint N must have exactly N black neighbors
:- hint(X1,Y1,N), not N { black(X2,Y2) : neighbor(X1,Y1,X2,Y2) } N.

% Define a predicate white for cells that are not black
white(X,Y) :- cell(X,Y), not black(X,Y).

% Define a predicate connected for white cells that are neighbors
connected(X1,Y1,X2,Y2) :- white(X1,Y1), white(X2,Y2), neighbor(X1,Y1,X2,Y2).

% Transitive property of relation "connected": all white cells that are neighbors, have a relation connected
connected(X1,Y1,X3,Y3) :- connected(X1,Y1,X2,Y2), connected(X2,Y2,X3,Y3).

% It cannot be the case that there are two white cells that are not connected
:- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).

% Show output predicate
#show black/2.