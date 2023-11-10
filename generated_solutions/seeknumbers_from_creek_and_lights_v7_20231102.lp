% The first cell of the path can be any cell in the grid
possible_path(X,Y,XX,YY) :- cell(X,Y), first(X,Y).

% The final cell of the path can be any cell in the grid
possible_path(X,Y,XX,YY) :- cell(XX,YY), final(XX,YY).

% The path can go from any cell to any adjacent cell
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (X-1=XX ; X+1=XX ; Y-1=YY ; Y+1=YY).

% The path can only bend if there is a hint number in the current cell
possible_path(X,Y,XX,YY) :- cell(X,Y), hint(X,Y,N), path_bends(X,Y,XX,YY,N).

% The path cannot bend if there is no hint number in the current cell
possible_path(X,Y,XX,YY) :- cell(X,Y), not hint(X,Y,_), path_straight(X,Y,XX,YY).

% The path can only bend if there is a hint number in the current cell and the next cell is also a hint cell
possible_path(X,Y,XX,YY) :- cell(X,Y), hint(X,Y,N), hint(XX,YY,_), path_bends(X,Y,XX,YY,N).

% The path cannot bend if there is a hint number in the current cell and the next cell is not a hint cell
possible_path(X,Y,XX,YY) :- cell(X,Y), hint(X,Y,N), not hint(XX,YY,_), path_straight(X,Y,XX,YY).

% The path can only bend if there is a hint number in the current cell and the next cell is the final cell
possible_path(X,Y,XX,YY) :- cell(X,Y), hint(X,Y,N), final(XX,YY), path_bends(X,Y,XX,YY,N).

% The path cannot bend if there is a hint number in the current cell and the next cell is not the final cell
possible_path(X,Y,XX,YY) :- cell(X,Y), hint(X,Y,N), not final(XX,YY), path_straight(X,Y,XX,YY).

% The path can only bend if the current cell is the first cell and the next cell is a hint cell
possible_path(X,Y,XX,YY) :- first(X,Y), hint(XX,YY,_), path_bends(X,Y,XX,YY,0).

% The path cannot bend if the current cell is the first cell and the next cell is not a hint cell
possible_path(X,Y,XX,YY) :- first(X,Y), not hint(XX,YY,_), path_straight(X,Y,XX,YY).

% The path can only bend if the current cell is the first cell and the next cell is the final cell
possible_path(X,Y,XX,YY) :- first(X,Y), final(XX,YY), path_bends(X,Y,XX,YY,0).

% The path cannot bend if the current cell is the first cell and the next cell is not the final cell
possible_path(X,Y,XX,YY) :- first(X,Y), not final(XX,YY), path_straight(X,Y,XX,YY).

% The path can only bend if the current cell is a hint cell and the next cell is the final cell
possible_path(X,Y,XX,YY) :- hint(X,Y,_), final(XX,YY), path_bends(X,Y,XX,YY,0).

% The path cannot bend if the current cell is a hint cell and the next cell is not the final cell
possible_path(X,Y,XX,YY) :- hint(X,Y,_), not final(XX,YY), path_straight(X,Y,XX,YY).

% The path can only bend if the current cell is the final cell
possible_path(X,Y,XX,YY) :- final(X,Y), path_bends(X,Y,XX,YY,0).

% The path cannot bend if the current cell is not the final cell
possible_path(X,Y,XX,YY) :- not final(X,Y), path_straight(X,Y,XX,YY).

% The path bends exactly N times between the current cell and the next cell
path_bends(X,Y,XX,YY,N) :- N > 0, path_straight(X,Y,XX,YY).
path_bends(X,Y,XX,YY,N) :- N > 0, path_bends(X,Y,XX,YY,N-1).

% The path does not bend between the current cell and the next cell
path_straight(X,Y,XX,YY) :- X = XX ; Y = YY.