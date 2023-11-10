% All the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% A cell is black if it is a hint
black(X,Y) :- hint(X,Y,_).

% A cell is white if it is not black
white(X,Y) :- cell(X,Y), not black(X,Y).

% A cell is black if it has N black neighbors
black(X,Y) :- cell(X,Y), hint(X,Y,N), countblack(X,Y,N).

% Count the number of black neighbors of a cell
countblack(X,Y,N) :- N = #count{black(X1,Y1) : dir(DX,DY), X1 = X+DX, Y1 = Y+DY}.

% All white cells must be connected
connected(X,Y) :- white(X,Y), not disconnected(X,Y).
disconnected(X,Y) :- white(X,Y), not connected(X,Y), cell(X1,Y1), white(X1,Y1), not connected(X1,Y1), X != X1, Y != Y1.

% Show the goal predicate
#show black/2.
% For each hint, blacken the appropriate number of adjacent cells
            { black(X+1,Y) : hint(X,Y,N) } = N :- cell(X,Y), hint(X,Y,N).
            { black(X,Y+1) : hint(X,Y,N) } = N :- cell(X,Y), hint(X,Y,N).
            { black(X+1,Y+1) : hint(X,Y,N) } = N :- cell(X,Y), hint(X,Y,N).
            
            % All white cells must be connected
            connected(X,Y) :- cell(X,Y), not black(X,Y).
            connected(X,Y) :- cell(X,Y), not black(X,Y), connected(X-1,Y).
            connected(X,Y) :- cell(X,Y), not black(X,Y), connected(X+1,Y).
            connected(X,Y) :- cell(X,Y), not black(X,Y), connected(X,Y-1).
            connected(X,Y) :- cell(X,Y), not black(X,Y), connected(X,Y+1).
            
            % A white cell must be connected to all other white cells
            :- cell(X,Y), not black(X,Y), not connected(X,Y).
            
            % A black cell cannot be connected to any other cell
            :- cell(X,Y), black(X,Y), connected(X,Y).