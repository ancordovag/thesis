% Define the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between two adjacent cells
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.
% Define the starting cell as the one marked with a white circle
start(X,Y) :- white_circle(X,Y).
% Define the ending cell as the one marked with a black circle
end(X,Y) :- black_circle(X,Y).
% Define a cell as visited if there is an incoming path from a previously visited cell
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Define a cell as visited if there is an incoming path from the starting cell
visit(X+DX,Y+DY) :- start(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Define a cell as visited if there is an incoming path from a cell with a number
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY), number(X,Y).
% Define a cell as visited if there is an incoming path from a cell with a number and the path bends exactly as many times as the number indicates
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY), number(X,Y), bend(X,Y).
% Define a cell as visited if there is an incoming path from the ending cell
visit(X+DX,Y+DY) :- end(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Define a cell as unvisited if it is not visited
unvisited(X,Y) :- cell(X,Y), not visit(X,Y).
% Define a cell as empty if it is not visited and it is not the starting or ending cell
empty(X,Y) :- unvisited(X,Y), not start(X,Y), not end(X,Y).% It cannot be that a cell marked with a white circle is unvisited
:- white_circle(X,Y), unvisited(X,Y).

% It cannot be that a cell marked with a black circle is unvisited
:- black_circle(X,Y), unvisited(X,Y).

% It cannot be that a cell with a number is unvisited
:- number(X,Y), unvisited(X,Y).

% It cannot be that a cell with a number has a bend if it is unvisited
:- number(X,Y), bend(X,Y), unvisited(X,Y).

% It cannot be that a cell is empty if it is visited
:- visit(X,Y), empty(X,Y).