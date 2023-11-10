% Any empty cell can have a light placed on it
possible_light(X,Y) :- empty(X,Y).

% For each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light
possible_light(X,Y) :- digit(X,Y,N), count_adjacent_lights(X,Y,N).

% Helper rule to count the number of adjacent cells containing a light
count_adjacent_lights(X,Y,N) :- count_horizontal_lights(X,Y,N).
count_adjacent_lights(X,Y,N) :- count_vertical_lights(X,Y,N).

% Helper rule to count the number of horizontally adjacent cells containing a light
count_horizontal_lights(X,Y,N) :- count_lights(X,Y,1,0,N).
count_horizontal_lights(X,Y,N) :- count_lights(X,Y,-1,0,N).

% Helper rule to count the number of vertically adjacent cells containing a light
count_vertical_lights(X,Y,N) :- count_lights(X,Y,0,1,N).
count_vertical_lights(X,Y,N) :- count_lights(X,Y,0,-1,N).

% Helper rule to count the number of adjacent cells containing a light in a specific direction
count_lights(X,Y,DX,DY,0) :- \+light(X,Y).
count_lights(X,Y,DX,DY,N) :- light(X,Y), NX is X+DX, NY is Y+DY, N1 is N-1, count_lights(NX,NY,DX,DY,N1).