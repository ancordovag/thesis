
% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction. 
neighbour(v,X,Y,X,Y+1) :- cell(X,Y), cell(X,Y+1).
neighbour(v,X,Y+1,X,Y) :- cell(X,Y), cell(X,Y+1).
neighbour(h,X,Y,X+1,Y) :- cell(X,Y), cell(X+1,Y).
neighbour(h,X+1,Y,X,Y) :- cell(X,Y), cell(X+1,Y). 
% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final.  
edge(X,Y,XX,YY) :- neighbour(_,X,Y,XX,YY), not final(X,Y). 
% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D. 
path(X,Y,XX,YY) :- neighbour(D,X,Y,XX,YY), not final(X,Y). 
% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one :- not edge(XX,YY,X,Y), not first(X,Y), cell(X,Y), not final(XX,YY). 
% The first cell is visited 
visit(X,Y) :- first(X,Y). 
% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited 
visit(XX,YY) :- visit(X,Y), edge(X,Y,XX,YY). 
% it cannot be the case that a cell is not visited 
:- not visit(X,Y), cell(X,Y). 
% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D 
xhint(N,X,Y,D,XX,YY) :- hint(X,Y,N), edge(X,Y,XX,YY), neighbour(D,X,Y,XX,YY). 
% xhint in cell (XX,YY), and it is 0 in the cell (XX,YY) 
xhint(0,XX,YY,D,XX,YY) :- xhint(N,X,Y,D,XX,YY), N = 0. 
% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same 
xhint(N,X,Y,D,XXX,YYY) :- xhint(N,XX,YY,D,XXX,YYY), edge(X,Y,XX,YY), not hint(X,Y,_), neighbour(D,X,Y,XX,YY). 
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one 
xhint(N-1,X,Y,DD,XXX,YYY) :- xhint(N,XX,YY,D,XXX,YYY), edge(X,Y,XX,YY), not hint(X,Y,_), neighbour(DD,X,Y,XX,YY), D != DD. 
% It cannot be the case that the counter xhint is not 0 in the cell of a hint 
:- xhint(N,X,Y,_,_,_), hint(X,Y,_), N != 0. 
% It cannot be the case that the counter xhint is not 0 in the final cell 
:- xhint(N,X,Y,_,_,_), final(X,Y), N != 0. 
% Show output predicate 
#show edge/4.