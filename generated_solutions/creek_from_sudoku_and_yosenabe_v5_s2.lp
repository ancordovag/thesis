% All the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0). 

% A cell is connected to another cell if they are adjacent and both are white
connected(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), dir(DX,DY), X2=X1+DX, Y2=Y1+DY, not black(X2,Y2).

% A cell is connected to itself
connected(X,Y,X,Y) :- cell(X,Y), not black(X,Y).

% A cell is black if it is a hint and the number of black cells adjacent to it is equal to the hint value
black(X,Y) :- hint(X,Y,N), countblack(X,Y,N).

% Count the number of black cells adjacent to a given cell
countblack(X,Y,N) :- cell(X,Y), dir(DX,DY), X2=X+DX, Y2=Y+DY, black(X2,Y2), N=#count{1: dir(DX,DY)}.

% A cell is white if it is not black
white(X,Y) :- cell(X,Y), not black(X,Y).

% All white cells must be connected
:- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).

% A hint is satisfied if the number of black cells adjacent to it is equal to the hint value
:- hint(X,Y,N), not countblack(X,Y,N).% A cell cannot be both black and white
:- black(X,Y), white(X,Y).

% A cell cannot be black if it is a hint
:- hint(X,Y,_), black(X,Y).

% A cell cannot be white if it is not connected to any other white cell
:- white(X,Y), not connected(X,Y,_,_).