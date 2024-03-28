
% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,Y,h) :- cell(X,Y), cell(XX,Y), X = XX+1.
neighbour(X,Y,XX,Y,h) :- cell(X,Y), cell(XX,Y), X = XX-1.
neighbour(X,Y,X,YY,v) :- cell(X,Y), cell(X,YY), Y = YY+1.
neighbour(X,Y,X,YY,v) :- cell(X,Y), cell(X,YY), Y = YY-1.
% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
edge(X,Y,XX,YY) :- neighbour(X,Y,XX,YY,_), not final(X,Y).
% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) :- edge(X,Y,XX,YY).
% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one:- not edge(XX,YY,X,Y), not first(X,Y), cell(X,Y).
% The first cell is visited
visit(X,Y) :- first(X,Y).
% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visit(XX,YY) :- visit(X,Y), edge(X,Y,XX,YY).
% it cannot be the case that a cell is not visited
:- not visit(X,Y), cell(X,Y).
% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY), neighbour(X,Y,XX,YY,D).
% xhint in cell (XX,YY), and it is 0 in the cell (XX,YY)
xhint(XX,YY,0,D) :- xhint(X,Y,0,D), edge(X,Y,XX,YY), neighbour(X,Y,XX,YY,D).
% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,D) :- not hint(X,Y,_), xhint(X,Y,N,D), edge(X,Y,XX,YY), neighbour(X,Y,XX,YY,D).
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- not hint(X,Y,_), xhint(X,Y,N,D), edge(X,Y,XX,YY), neighbour(X,Y,XX,YY,DD), D != DD.