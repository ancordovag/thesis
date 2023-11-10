% The first cell of the path can be any cell in the grid
possible_path(X,Y,XX,YY) :- cell(X,Y), first(X,Y).

% The final cell of the path can be any cell in the grid
possible_path(X,Y,XX,YY) :- cell(XX,YY), final(XX,YY).

% The path can go from any cell to any adjacent cell
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (X-1=XX ; X+1=XX ; Y-1=YY ; Y+1=YY).

% The path can bend between a cell with a number and the next cell with a number or the final cell
possible_path(X,Y,XX,YY) :- hint(X,Y,_), hint(XX,YY,_), path(X,Y,XX,YY).

% The path does not bend between the first cell and the first cell with a number
possible_path(X,Y,XX,YY) :- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY).