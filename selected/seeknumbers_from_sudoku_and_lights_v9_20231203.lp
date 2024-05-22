                    % Define the possible directions
direction(1,0). direction(-1,0). direction(0,1). direction(0,-1).

% Define the neighbors of a cell given a direction
neighbor(X1,Y1,X2,Y2,DX,DY) :- cell(X1,Y1), cell(X2,Y2), direction(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Define the path from a cell to another cell if they are neighbors
path(X1,Y1,X2,Y2) :- neighbor(X1,Y1,X2,Y2,DX,DY), not hint(X1,Y1,_), not hint(X2,Y2,_).
path(X1,Y1,X2,Y2) :- first(X1,Y1), neighbor(X1,Y1,X2,Y2,DX,DY), not hint(X2,Y2,_).
path(X1,Y1,X2,Y2) :- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2,DX,DY), not hint(X2,Y2,_), N = 0.
path(X1,Y1,X2,Y2) :- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2,DX,DY), hint(X2,Y2,M), N > 0, M = 0.

% Define the path from a cell to another cell if they are neighbors and the first cell is a hint with a number N and the second cell is a hint with a number M
path(X1,Y1,X2,Y2) :- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2,DX,DY), hint(X2,Y2,M), N > 0, M > 0.

% Define the path from a cell to another cell if they are neighbors and the first cell is a hint with a number N and the second cell is the final cell
path(X1,Y1,X2,Y2) :- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2,DX,DY), final(X2,Y2), N > 0.

% Define the path from a cell to another cell if they are neighbors and the first cell is the final cell and the second cell is a hint with a number N
path(X1,Y1,X2,Y2) :- final(X1,Y1), neighbor(X1,Y1,X2,Y2,DX,DY), hint(X2,Y2,N), N > 0.

% Define the path from a cell to another cell if they are neighbors and the first cell is the final cell and the second cell is the first cell
path(X1,Y1,X2,Y2) :- final(X1,Y1), neighbor(X1,Y1,X2,Y2,DX,DY), first(X2,Y2).

% Define the path from a cell to another cell if they are neighbors and the first cell is the first cell and the second cell is a hint with a number N
path(X1,Y1,X2,Y2) :- first(X1,Y1), neighbor(X1,Y1,X2,Y2,DX,DY), hint(X2,Y2,N), N > 0.

% Define the path from a cell to another cell if they are neighbors and the first cell is the first cell and the second cell is the final cell
path(X1,Y1,X2,Y2) :- first(X1,Y1), neighbor(X1,Y1,X2,Y2,DX,DY), final(X2,Y2).

% Show output predicate
#show path/4.