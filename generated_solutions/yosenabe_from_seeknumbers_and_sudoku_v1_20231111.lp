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

% Show output predicate
#show path/4.
% It cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).
% It cannot be the case that the counter goal_number is not 0 in the cell of a goal
:- goal(X,Y,_), not goal_number(X,Y,0,_).
% It cannot be the case that the counter goal_number is not 0 in the final cell
:-  final(X,Y), not goal_number(X,Y,0,_).