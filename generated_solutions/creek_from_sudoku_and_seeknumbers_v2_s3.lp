% Generate all possible positions for the player at step S
at(X,Y,S) :- cell(X,Y), S>=0.

% Generate all possible positions for the player at step S-1, if there is a position at step S
at(XX,YY,S-1) :- at(X,Y,S), cell(XX,YY), S>0.

% Generate all possible blackened cells based on the hints
black(X,Y) :- hint(X,Y,N), N=0.
black(X,Y) :- hint(X,Y,N), N=1, black(X+1,Y).
black(X,Y) :- hint(X,Y,N), N=1, black(X,Y+1).
black(X,Y) :- hint(X,Y,N), N=2, black(X+1,Y), black(X,Y+1).
black(X,Y) :- hint(X,Y,N), N=3, black(X+1,Y), black(X,Y+1), black(X+1,Y+1).
black(X,Y) :- hint(X,Y,N), N=4, black(X+1,Y), black(X,Y+1), black(X+1,Y+1), black(X-1,Y+1).

% Show the goal predicate
#show black/2.
% For each cell, it is either black or white
{ black(X,Y) } 1 :- cell(X,Y).
{ white(X,Y) } 1 :- cell(X,Y).

% A white cell is connected to another white cell if they are horizontally or vertically adjacent and both cells are not black
connected(X1,Y1,X2,Y2) :- white(X1,Y1), white(X2,Y2), neighbour(X1,Y1,X2,Y2), not black(X1,Y1), not black(X2,Y2).

% All white cells must form an orthogonally connected area
:- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).

% A number in a circle indicates how many of the 4 adjacent cells must be blackened
:- hint(X,Y,N), count_black(X,Y,C), C != N.

% Count the number of black cells adjacent to a given cell
count_black(X,Y,C) :- black(X+1,Y), C = C + 1.
count_black(X,Y,C) :- black(X,Y+1), C = C + 1.
count_black(X,Y,C) :- black(X+1,Y+1), C = C + 1.
count_black(X,Y,C) :- black(X-1,Y), C = C + 1.
count_black(X,Y,C) :- black(X,Y-1), C = C + 1.
count_black(X,Y,C) :- black(X-1,Y-1), C = C + 1.
count_black(X,Y,C) :- black(X+1,Y-1), C = C + 1.
count_black(X,Y,C) :- black(X-1,Y+1), C = C + 1.

% Show output predicate
#show black/2.