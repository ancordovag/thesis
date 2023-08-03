%% Definition
% Define the neighbors of a cell
neighbor(X1, Y1, X2, Y2) :- cell(X1, Y1), cell(X2, Y2), abs(X2 - X1) = 1, Y2 = Y1; abs(Y2 - Y1) = 1, X2 = X1.

% Define the valid directions (up, down, left, right)
direction(1, 0). % up
direction(-1, 0). % down
direction(0, 1). % right
direction(0, -1). % left

%% Initialization
% Initialize all cells as white
white(X, Y) :- cell(X, Y), not black(X, Y).

% Initialize all adjacent cells of a black cell as seen
seen(X, Y) :- black(X, Y), neighbor(X, Y, X1, Y1), white(X1, Y1).

%% Generation
% Generate a path between two seen cells
path(X1, Y1, X2, Y2) :- seen(X1, Y1), seen(X2, Y2), neighbor(X1, Y1, X2, Y2).

% Generate a path between a seen cell and a neighboring white cell
path(X1, Y1, X2, Y2) :- seen(X1, Y1), neighbor(X1, Y1, X2, Y2), white(X2, Y2).

% Generate a path between a white cell and a neighboring seen cell
path(X1, Y1, X2, Y2) :- white(X1, Y1), neighbor(X1, Y1, X2, Y2), seen(X2, Y2).

%% Test
% All white cells must form an orthogonally connected area
:- white(X, Y), not seen(X, Y).

% A cell with a number must have the specified number of adjacent black cells
:- hint(X, Y, N), count_black(X, Y, N1), N1 != N.

% Count the number of adjacent black cells for a given cell
count_black(X, Y, N) :- hint(X, Y, _), findall(black(X1, Y1), neighbor(X, Y, X1, Y1), L), length(L, N).

% No two black cells can be adjacent
:- black(X, Y), black(X1, Y1), neighbor(X, Y, X1, Y1).

% The path cannot cross or intersect with black cells
:- path(X1, Y1, X2, Y2), black(X, Y), X = X1, Y = Y1; X = X2, Y = Y2.

%% Optimization
% Ensure there are no unnecessary white cells (no isolated white cells)
:- white(X, Y), not path(X, Y, _, _), not path(_, _, X, Y).