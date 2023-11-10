% Generate a predicate called neighbour that specifies if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generate one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not blackened.
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not black(X,Y).

% If there is a hint in cell (X,Y), then exactly N of the adjacent cells must be blackened.
:- hint(X,Y,N), count{black(XX,YY) : neighbour(X,Y,XX,YY,_)} != N.

% If there is no hint in cell (X,Y), then none of the adjacent cells must be blackened.
:- cell(X,Y), not hint(X,Y,_), black(XX,YY), neighbour(X,Y,XX,YY,_).

% Show the goal predicate
#show black/2.
% All white cells must be connected
:- cell(X,Y), not connected(X,Y).

% The number of blackened cells around a hint must be equal to the hint value
:- hint(X,Y,N), not blackened(X,Y,N).

% Show output predicate
#show black/2.