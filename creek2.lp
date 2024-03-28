% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY) :- XX=X, YY=Y+1, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X, YY=Y-1, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X+1, YY=Y, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X-1, YY=Y, cell(X,Y), cell(XX,YY).

% If a cell (X,Y) has a hint N, then exactly N of its neighbours must be blackened.
N { black(XX,YY) : neighbour(X,Y,XX,YY) } N :- hint(X,Y,N).

% If a cell (X,Y) does not have a hint, then it can be blackened or not.
{ black(X,Y) } :- cell(X,Y), not hint(X,Y,_).

% A cell (X,Y) is white if it is not blackened.
white(X,Y) :- cell(X,Y), not black(X,Y).

% A white cell (X,Y) is connected to another white cell (XX,YY) if they are neighbours and both are white.
connected(X,Y,XX,YY) :- neighbour(X,Y,XX,YY), white(X,Y), white(XX,YY).

% A white cell (X,Y) is reachable from another white cell (XX,YY) if they are connected or if there is a white cell (XXX,YYY) from which (X,Y) is reachable and (XX,YY) is connected to (XXX,YYY).
reachable(X,Y,XX,YY) :- connected(X,Y,XX,YY).
reachable(X,Y,XX,YY) :- reachable(X,Y,XXX,YYY), connected(XXX,YYY,XX,YY).

% All white cells must be reachable from each other.
:- white(X,Y), white(XX,YY), not reachable(X,Y,XX,YY).

% Show output predicate
#show black/2.
% It cannot be the case that a cell is black and has a hint
:- black(X,Y), hint(X,Y,_).
% It cannot be the case that a cell is black and is not connected to any other black cell
:- black(X,Y), not 1 { black(XX,YY) : neighbour(X,Y,XX,YY) } 1.
% It cannot be the case that a cell with a hint does not have the correct number of black neighbours
:- hint(X,Y,N), N != #count { black(XX,YY) : neighbour(X,Y,XX,YY) }.
% It cannot be the case that a cell is white and is not connected to any other white cell
:- cell(X,Y), not black(X,Y), not 1 { not black(XX,YY) : neighbour(X,Y,XX,YY) } 1.