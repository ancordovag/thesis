                    % Any cell, in principle, could be part of the path
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY).
% The first cell of the path is "first"
possible_path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).
% The final cell of the path is "final"
possible_path(X,Y,XX,YY) :- cell(X,Y), final(XX,YY).
% If a cell contains a hint, it must be part of the path
possible_path(X,Y,XX,YY) :- hint(X,Y,N), cell(XX,YY).