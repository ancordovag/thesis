% Define the possible directions for a cell
direction(1,0). direction(-1,0). direction(0,1). direction(0,-1).

% Define neighbors for each cell given a direction
neighbor(X1,Y1,X2,Y2,DX,DY) :- cell(X1,Y1), cell(X2,Y2), direction(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Generate minimum 0 and maximum 4 predicate black for cell(X,Y) if this is a hint.  
{ black(X,Y) } 0..4 :- hint(X,Y,_).

% If a cell is black, then it is not white
not_white(X,Y) :- black(X,Y).

% If a cell is not black and not a hint, then it is white
white(X,Y) :- cell(X,Y), not black(X,Y), not hint(X,Y,_).

% If a cell is white and has a white neighbor, then it is connected
connected(X1,Y1,X2,Y2) :- white(X1,Y1), neighbor(X1,Y1,X2,Y2,_,_), white(X2,Y2).

% Transitive property of relation "connected": all white cells that are neighbors, are connected
connected(X1,Y1,X3,Y3) :- connected(X1,Y1,X2,Y2), connected(X2,Y2,X3,Y3).

% All white cells must be connected
:- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).

% The number of black neighbors for a hint cell must be equal to the hint number
:- hint(X,Y,N), #count{X1,Y1 : neighbor(X,Y,X1,Y1,_,_), black(X1,Y1)} != N.

% Show output predicate
#show black/2.
                    % It cannot be the case that a white cell is not visited
:- white(X,Y), not visit(X,Y).
% It cannot be the case that a black cell is visited
:- black(X,Y), visit(X,Y).