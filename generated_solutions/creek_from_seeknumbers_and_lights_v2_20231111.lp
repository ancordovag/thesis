% Define the possible directions from a cell, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

% Define neighbors for each cell given a delta
neighbor(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Generate minimum 0 and maximum 4 predicate black for cell(X,Y) if this is a hint.  
{ black(X,Y) } 0..4 :- hint(X,Y,_).

% Mark a cell as white
white(X,Y) :- cell(X,Y), not black(X,Y).

% All white cells must be connected. If a cell (X,Y) is white, and it has a white neighbor (XX,YY), then there is a connection between them.
connected(X,Y,XX,YY) :- white(X,Y), neighbor(X,Y,XX,YY), white(XX,YY).

% Transitive property of relation "connected": all white cells that are neighbors, have a relation connected
connected(X,Y,XX,YY) :- connected(X,Y,Z,W), neighbor(Z,W,XX,YY), white(XX,YY).

% The number of blackened cells around a hint must be equal to the hint number
:- hint(X,Y,N), #count{ XX,YY : neighbor(X,Y,XX,YY), black(XX,YY) } != N.

% All white cells must be connected to each other
:- white(X,Y), not #count{ XX,YY : connected(X,Y,XX,YY) } = #count{ XX,YY : white(XX,YY) }.

% Show output predicate
#show black/2.
% A cell with a hint N must have exactly N blackened neighbors
:- hint(X,Y,N), not N { black(XX,YY) : neighbor(X,Y,XX,YY) } N.
% It cannot be the case that a white cell is not connected to another white cell
:- cell(X,Y), not black(X,Y), not 1 { connected(XX,YY,X,Y) : cell(XX,YY), not black(XX,YY) } 1.
% It cannot be the case that a cell is black and has a black neighbor
:- black(X,Y), black(XX,YY), neighbor(X,Y,XX,YY).