% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% If a cell is the first cell, it should have a path to an adjacent cell
path(X,Y,X+DX,Y+DY) :- first(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% If a cell is not the first or final cell and it has a hint, it should have a path to an adjacent cell
path(X,Y,X+DX,Y+DY) :- hint(X,Y,N), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y).

% If a cell is not the first or final cell and it does not have a hint, it should have a path to an adjacent cell
path(X,Y,X+DX,Y+DY) :- not hint(X,Y,N), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y).

% If a cell is the final cell, it should have a path from an adjacent cell
path(X+DX,Y+DY,X,Y) :- final(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% If a cell has a hint, it should have exactly N paths to/from adjacent cells
N = #count{XX,YY : path(X,Y,XX,YY)} :- hint(X,Y,N).

% If a cell does not have a hint, it should have exactly 2 paths to/from adjacent cells
2 = #count{XX,YY : path(X,Y,XX,YY)} :- not hint(X,Y,N), not first(X,Y), not final(X,Y).

% The first cell should have exactly 1 path to an adjacent cell
1 = #count{XX,YY : path(X,Y,XX,YY)} :- first(X,Y).

% The final cell should have exactly 1 path from an adjacent cell
1 = #count{XX,YY : path(XX,YY,X,Y)} :- final(X,Y).

% Show output predicate path
#show path/4.
                    % All cells must be visited
:- cell(X,Y), not visited(X,Y).
% The final cell must be visited
:- final(X,Y), not visited(X,Y).
% The final cell must have a counter xhint equal to 0
:- final(X,Y), xhint(X,Y,N,_), N!=0.
% If a cell (X,Y) has a hint, then the next cell (XX,YY) must have a counter xhint equal to N
:- hint(X,Y,N), edge(X,Y,XX,YY,_), not xhint(XX,YY,N,_).
% If a cell (X,Y) has a counter xhint equal to N, then the next cell (XX,YY) must have a counter xhint equal to N-1 if the direction changes
:- xhint(X,Y,N,D), N>=1, edge(X,Y,XX,YY,DD), D!=DD, not xhint(XX,YY,N-1,_).
% If a cell (X,Y) has a counter xhint equal to N, then the next cell (XX,YY) must have a counter xhint equal to N if the direction does not change
:- xhint(X,Y,N,D), edge(X,Y,XX,YY,DD), D=DD, not xhint(XX,YY,N,_).