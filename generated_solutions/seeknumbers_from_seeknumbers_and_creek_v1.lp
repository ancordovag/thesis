% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhintand cell (XX,YY), and it is 0 in the cell (XX,YY) when 
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% Resulting Predicate representing blackened cells: black/2. The cell at the coordinates (X,Y) is blackened
black(X,Y) 

% The possible aditions for a hint cell
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define minimum N and maximum N cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y, 
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).

% Define a path between 2 white cells when they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.

% If a cell is not black, it should be white
white(X,Y) :- not black(X,Y), cell(X,Y).
% If a cell is not white, it should be black
black(X,Y) :- not white(X,Y), cell(X,Y).

% Find the minimum column containing a white cell 
mini_x(M) :- M = #min{X,Y : white(X,Y)}.
% Find the minimum row containing a white cell in the minimum column containing a white cell
mini_y(N) :- N = #min{Y : white(M,Y), mini_x(M)}.
% Declare the first visit as the minimum column and minimum row
first_visit(M,N) :- mini_x(M), mini_y(N).
% Declare a cell as visited if there is an incoming path from the first visited cell
visit(X+DX,Y+DY) :- first_visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Declare a cell as visited if there is an incoming path from a already visited cell
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Show output predicate black
#show black/2.

% Every cell cell(X,Y) should be traversed, that means visited
visited(X,Y)
% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY)
% It cannot be the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).
% It cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).
% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_). 

% Show output predicate
#show path/4.