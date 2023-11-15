                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% possible directions for light rays
direction(0,1). direction(0,-1). direction(1,0). direction(-1,0).
% a cell can have a light if it is not a digit cell and not an empty cell
possible_light(X,Y) :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).
% a cell is illuminated if it has a light or if it is in the direction of a light
possible_illuminated(X,Y) :- possible_light(X,Y).
possible_illuminated(X+DX,Y+DY) :- possible_illuminated(X,Y), direction(DX,DY), cell(X+DX,Y+DY), not digit(X+DX,Y+DY,_), not empty(X+DX,Y+DY).