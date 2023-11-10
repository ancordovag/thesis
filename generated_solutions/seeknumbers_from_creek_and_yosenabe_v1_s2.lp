% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the starting cell
start(X,Y) :- position(X,Y), first(X,Y).

% Define the ending cell
end(X,Y) :- position(X,Y), final(X,Y).

% Define the number of bends in a cell
bends(X,Y,B) :- position(X,Y), cell(X,Y), B = #count{X1,Y1 : position(X1,Y1), cell(X1,Y1), path(X,Y,X1,Y1), dir(DX,DY), DX != 0, DY != 0}.

% Define the hint number in a cell
hint(X,Y,N) :- position(X,Y), cell(X,Y), hint(X,Y,N).

% Define a path between two cells
path(X,Y,P,Q) :- position(X,Y), position(P,Q), |P-X| + |Q-Y| = 1.

% Show output predicates
#show start/2.
#show end/2.
#show bends/3.
#show hint/3.
% The starting cell must be visited
visit(X,Y) :- start(X,Y).

% The ending cell must be visited
visit(X,Y) :- end(X,Y).

% The path must traverse each remaining cell without crossing or intersecting itself
:- visit(X,Y), visit(X,Y), (X,Y) != (X,Y).

% The path must bend exactly as many times as indicated by the number in the cell
bends(X,Y,B) :- hint(X,Y,N), B = N.

% There must be no bends between the starting cell and the first cell with a number
:- start(X,Y), hint(X,Y,_), bends(X,Y,_).

% There must be no bends between a cell with a number and the next cell with a number or the ending cell
:- hint(X1,Y1,_), hint(X2,Y2,_), (X1,Y1) != (X2,Y2), bends(X1,Y1,_), not bends(X2,Y2,_).
:- hint(X,Y,_), end(X,Y), bends(X,Y,_).