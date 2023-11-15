                    % Any cell, in principle, could be part of the path
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), adjacent(X,Y,XX,YY).
% The first cell of the path is "first"
possible_path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY), adjacent(X,Y,XX,YY).
% The next possible cell in the path depends on the previous one, given that it is a cell and it is not the final cell
possible_path(X,Y,XX,YY) :- possible_path(X,Y,A,B), cell(XX,YY), adjacent(A,B,XX,YY), not final(A,B).
% The final cell of the path is "final"
possible_path(X,Y,XX,YY) :- possible_path(X,Y,A,B), final(XX,YY), adjacent(A,B,XX,YY).

% Define adjacency for cells
adjacent(X,Y,XX,YY) :- XX=X, YY=Y+1.
adjacent(X,Y,XX,YY) :- XX=X, YY=Y-1.
adjacent(X,Y,XX,YY) :- XX=X+1, YY=Y.
adjacent(X,Y,XX,YY) :- XX=X-1, YY=Y.