% A cell can have a light if it is not initially given
possible_light(X,Y) :- empty(X,Y), not digit(X,Y,_).

% A cell can have a light if it is adjacent to a cell with a number 'n' and there are exactly 'n' adjacent cells with lights
possible_light(X,Y) :- digit(X,Y,N), count_adjacent_lights(X,Y,N).

% Count the number of adjacent cells with lights
count_adjacent_lights(X,Y,N) :- count_adjacent_lights(X,Y,0,N).

% Base case: when N is 0, there are no more adjacent cells with lights to count
count_adjacent_lights(_,_,N,N).

% Recursive case: count the number of adjacent cells with lights
count_adjacent_lights(X,Y,Count,N) :- 
    adjacent(X,Y,XX,YY), light(XX,YY),
    NewCount is Count + 1,
    count_adjacent_lights(X,Y,NewCount,N).

% Define the adjacency relation between cells
adjacent(X,Y,XX,YY) :- X = XX, Y = YY-1. % left
adjacent(X,Y,XX,YY) :- X = XX, Y = YY+1. % right
adjacent(X,Y,XX,YY) :- X = XX-1, Y = YY. % up
adjacent(X,Y,XX,YY) :- X = XX+1, Y = YY. % down