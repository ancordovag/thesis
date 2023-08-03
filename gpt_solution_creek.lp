%%% Solution of Creek
%% Header
% None

%% Initialization
plus(0, 0). plus(0, 1). plus(1, 0). plus(1, 1).
dir(0, 1). dir(0, -1). dir(1, 0). dir(-1, 0).

%% Generation
% Generate black cells based on the hints
black(X, Y) :- hint(X, Y, N), count_black_neighbors(X, Y, N).
% Count the number of black neighbors for a given cell
count_black_neighbors(X, Y, N) :- N = #count { 1 : neighbor(X, Y, X2, Y2), black(X2, Y2) }.
% Check if a cell is connected to the boundary and is not black
connected_to_boundary(X, Y) :- cell(X, Y), not black(X, Y), boundary(X, Y, _).
% Define the boundary of the white area
boundary(X, Y, N) :- cell(X, Y), not black(X, Y), N = #count { 1 : neighbor(X, Y, X2, Y2), black(X2, Y2) }.
% Generate the white area (non-blackened cells) from the boundary
:- connected_to_boundary(X, Y), not boundary(X, Y, _).

%% Test
% Ensure that all the blackened cells are adjacent to the hint cells
:- hint(X, Y, N), black(X, Y), not black(X+A, Y+B), plus(A, B), cell(X+A, Y+B).
% Ensure that there are no black cells adjacent to other black cells
:- black(X, Y), black(X+A, Y+B), plus(A, B), cell(X+A, Y+B).
% Ensure that there is a path between any two white cells that are neighbors
:- white(X, Y), white(P, Q), |P-X| + |Q-Y| = 1, not path(X, Y, P, Q).
% Ensure that all white cells are marked as either black or white
:- cell(X, Y), not white(X, Y), not black(X, Y).
% Ensure that all cells marked as black are blackened
:- black(X, Y), not black(X, Y).
% Ensure that there is no path between the first visited cell and its neighbor
:- first_visit(X, Y), path(X, Y, X+DX, Y+DY), dir(DX, DY).
% Ensure that all white cells are in the same orthogonally connected area
:- white(X, Y), white(P, Q), not path(X, Y, P, Q), not black(X, Y), not black(P, Q).