                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% possible directions for light rays
direction(0,1). direction(0,-1). direction(1,0). direction(-1,0).
% a light can be placed in a cell if it is not a digit cell or an empty cell
possible_light(X,Y) :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).
% a cell is illuminated if there is a light in the same row or column, and there are no digits or empty cells blocking the light
possible_illuminated(X,Y) :- possible_light(XX,YY), direction(DX,DY), X=XX+DX, Y=YY+DY, not digit(X,Y,_), not empty(X,Y).
% a cell with a digit must have exactly that many adjacent cells with lights
possible_light(X+DX,Y+DY) :- digit(X,Y,D), direction(DX,DY), #count{ XX,YY : possible_light(XX,YY), XX=X+DX, YY=Y+DY } = D.