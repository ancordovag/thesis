% All the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% A cell is black if it is not white
black(X,Y) :- cell(X,Y), not white(X,Y).

% A cell is white if it is not black
white(X,Y) :- cell(X,Y), not black(X,Y).

% A cell is black if it is adjacent to a hint and the hint requires it to be black
black(X,Y) :- hint(X,Y,N), black_adjacent(X,Y,N).

% A cell is white if it is not black and not adjacent to a hint
white(X,Y) :- cell(X,Y), not black(X,Y), not hint(X,Y,_).

% A cell is black_adjacent to a hint if it is black and adjacent to the hint
black_adjacent(X,Y,N) :- black(X,Y), adjacent(X,Y,N).

% A cell is adjacent to a hint if it is in one of the four possible directions from the hint
adjacent(X,Y,N) :- hint(X,Y,_), dir(DX,DY), X+DX >= 1, X+DX <= 3, Y+DY >= 1, Y+DY <= 4, N > 0, N-1 = #count{black(X+DX,Y+DY) : cell(X+DX,Y+DY)}.

% The white cells must form an orthogonally connected area
:- white(X,Y), not connected(X,Y).

% A cell is connected if it is white and there is a path to it from another white cell
connected(X,Y) :- white(X,Y), not black(X,Y), not visited(X,Y), visit(X,Y).

% A cell is visited if it has been visited during the search for connected cells
visited(X,Y) :- visit(X,Y).

% A cell is visited if it is white and there is a path to it from another visited cell
visit(X,Y) :- white(X,Y), not visited(X,Y), dir(DX,DY), X+DX >= 1, X+DX <= 3, Y+DY >= 1, Y+DY <= 4, visited(X+DX,Y+DY).

% Show the black cells
#show black/2.