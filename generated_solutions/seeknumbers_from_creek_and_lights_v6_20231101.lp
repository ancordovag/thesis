% The first cell of the path must be the cell marked with a white circle
possible_path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).

% The final cell of the path must be the cell marked with a black circle
possible_path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY).

% The path must traverse each remaining cell of the grid without crossing or intersecting itself
possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), not path(XX,YY,X,Y).

% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path must bend exactly as often as the number in the first cell indicates
possible_path(X,Y,XX,YY) :- hint(X,Y,N), cell(XX,YY), (N=0 ; path_bends(X,Y,XX,YY,N)).

% The path must not bend between the cell marked with a white circle and the first cell with a number
possible_path(X,Y,XX,YY) :- first(X,Y), hint(XX,YY,_), not path_bends(X,Y,XX,YY,_).

% Helper rule to check if the path bends exactly as often as the number in the first cell indicates
path_bends(X,Y,XX,YY,N) :- path(X,Y,_,_), path(_,_,XX,YY), bends(X,Y,_,_,_,_,N).

% Helper rule to count the number of bends in the path
bends(X1,Y1,X2,Y2,X3,Y3,N) :- path(X1,Y1,X2,Y2), path(X2,Y2,X3,Y3), (X1\=X3 ; Y1\=Y3), N=1.
bends(X1,Y1,X2,Y2,X3,Y3,N) :- path(X1,Y1,X2,Y2), path(X2,Y2,X3,Y3), (X1=X3 ; Y1=Y3), N=0.