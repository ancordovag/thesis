% Any empty cell can have a light placed on it
possible_light(X,Y) :- empty(X,Y).

% A cell with a number 'n' must have exactly 'n' adjacent cells with lights
possible_light(X,Y) :- digit(X,Y,N), count_adjacent_lights(X,Y,N).

% Count the number of adjacent cells with lights
count_adjacent_lights(X,Y,N) :- count_horizontal_lights(X,Y,N).
count_adjacent_lights(X,Y,N) :- count_vertical_lights(X,Y,N).

% Count the number of horizontally adjacent cells with lights
count_horizontal_lights(X,Y,N) :- count_left_lights(X,Y,N).
count_horizontal_lights(X,Y,N) :- count_right_lights(X,Y,N).

% Count the number of vertically adjacent cells with lights
count_vertical_lights(X,Y,N) :- count_up_lights(X,Y,N).
count_vertical_lights(X,Y,N) :- count_down_lights(X,Y,N).

% Count the number of lights to the left of the cell
count_left_lights(X,Y,N) :- X1 is X-1, count_left_lights(X1,Y,N1), light(X1,Y), N is N1+1.
count_left_lights(X,Y,0) :- \+light(X,Y).

% Count the number of lights to the right of the cell
count_right_lights(X,Y,N) :- X1 is X+1, count_right_lights(X1,Y,N1), light(X1,Y), N is N1+1.
count_right_lights(X,Y,0) :- \+light(X,Y).

% Count the number of lights above the cell
count_up_lights(X,Y,N) :- Y1 is Y-1, count_up_lights(X,Y1,N1), light(X,Y1), N is N1+1.
count_up_lights(X,Y,0) :- \+light(X,Y).

% Count the number of lights below the cell
count_down_lights(X,Y,N) :- Y1 is Y+1, count_down_lights(X,Y1,N1), light(X,Y1), N is N1+1.
count_down_lights(X,Y,0) :- \+light(X,Y).