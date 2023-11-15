% Define fields at the combination of a row X and a column Y
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C.

% Define the possible numbers for each field
1 { number(X,Y,N): numbers(N) } 1 :- field(X,Y).

% Each number should appear exactly once in each row
:- rows(R), numbers(N), #count{ Y: number(R,Y,N) } != 1.

% Each number should appear exactly once in each column
:- cols(C), numbers(N), #count{ X: number(X,C,N) } != 1.

% Define the sub-grids
subgrid(X,Y,S) :- rows(R), cols(C), sub_grid_size(SGS), X = 1..R, Y = 1..C, S = ((X-1)/SGS)*SGS + ((Y-1)/SGS) + 1.

% Each number should appear exactly once in each sub-grid
:- sub_grid_size(SGS), numbers(N), #count{ field(X,Y): number(X,Y,N), subgrid(X,Y,S) } != 1. 

% Show output predicate
#show number/3.
% Each cell in the grid must have exactly one number
1 { number(X,Y,N) : numbers(N) } 1 :- grid_size(X), grid_size(Y).

% Each row must have all numbers from 1 to 9
1 { number(X,Y,N) : grid_size(Y) } 1 :- grid_size(X), numbers(N).

% Each column must have all numbers from 1 to 9
1 { number(X,Y,N) : grid_size(X) } 1 :- grid_size(Y), numbers(N).

% Each sub-grid must have all numbers from 1 to 9
1 { number(X,Y,N) : subgrid(X,Y,S) } 1 :- sub_grid_size(S), numbers(N).

% Show output predicate
#show number/3.