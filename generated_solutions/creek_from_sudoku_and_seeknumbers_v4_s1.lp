% Generate a predicate called neighbour that specifies if two cells are horizontally or vertically adjacent
neighbour(X,Y,XX,YY) :- XX=X+1, YY=Y, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X-1, YY=Y, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X, YY=Y+1, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY) :- XX=X, YY=Y-1, cell(X,Y), cell(XX,YY).

% Generate one edge between cell (X,Y) and one of its neighbours (XX,YY) if (X,Y) is not blackened
1 { edge(X,Y,XX,YY) : neighbour(X,Y,XX,YY) } 1 :- cell(X,Y), not hint(X,Y,_).

% If a cell (X,Y) is blackened, then there is an edge between (X,Y) and each of its neighbours (XX,YY)
edge(X,Y,XX,YY) :- hint(X,Y,_), neighbour(X,Y,XX,YY).

% The white cells are the cells that are not blackened
white(X,Y) :- cell(X,Y), not hint(X,Y,_).

% The white cells must form an orthogonally connected area
connected(X,Y) :- white(X,Y), visited(X,Y).
connected(XX,YY) :- connected(X,Y), edge(X,Y,XX,YY).

% It cannot be the case that there is a white cell that is not connected to any other white cell
:- white(X,Y), not connected(X,Y).

% Show output predicate
#show cell/2.