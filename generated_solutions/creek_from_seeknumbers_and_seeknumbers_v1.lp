% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not blackened. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not blackened(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is connected
connected(X,Y) :- first(X,Y).

% If a cell (X,Y) is connected, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also connected
connected(XX,YY) :- connected(X,Y), edge(X,Y,XX,YY,_).

% If a cell (X,Y) has a number N, then there must be exactly N blackened cells among its neighbors
{ blackened(XX,YY) : neighbour(X,Y,XX,YY,_) } = N :- number(X,Y,N).

% Show output predicates
#show path/4.
#show blackened/2.
% It cannot be the case that a cell is blackened and connected to another white cell
:- blackened(X,Y), connected(X,Y).
% It cannot be the case that a cell is not blackened and not connected to another white cell
:- not blackened(X,Y), not connected(X,Y).
% It cannot be the case that a cell is blackened and the number of blackened cells adjacent to it is not equal to the given number
:- blackened(X,Y), number(X,Y,N), not count_adjacent_blackened(X,Y,N).
% It cannot be the case that a cell is not blackened and the number of blackened cells adjacent to it is equal to the given number
:- not blackened(X,Y), number(X,Y,N), count_adjacent_blackened(X,Y,N).
% It cannot be the case that a cell is blackened and not adjacent to any white cell
:- blackened(X,Y), not adjacent_to_white(X,Y).
% It cannot be the case that a cell is not blackened and adjacent to a white cell
:- not blackened(X,Y), adjacent_to_white(X,Y).

% Show output predicates
#show blackened/2.
#show connected/2.