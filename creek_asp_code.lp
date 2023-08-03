%% Definition
% Differences between the coordinates of neighboring cells
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).  

% define the neighbors of a cell
neighbor(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), diff(DX,DY), |X2-X1| = |DX|, |Y2-Y1| = |DY|.


%% Initialization
%marks the cells with hints as black
black(X,Y) :- hint(X,Y,_).


%% Generation
%generate black cells around a cell with a hint
{black(X2,Y2)} 1 :- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2), not black(X2,Y2), N>0.

%generate white cells around a cell with a hint
:- hint(X1,Y1,N), neighbor(X1,Y1,X2,Y2), not black(X2,Y2), not hint(X2,Y2,_), N=0.


%% Test
% All white cells must be connected
:- cell(X,Y), not black(X,Y), not connected(X,Y).

% Check if two cells are connected
connected(X1,Y1) :- cell(X1,Y1), not black(X1,Y1).
connected(X2,Y2) :- connected(X1,Y1), neighbor(X1,Y1,X2,Y2), not black(X2,Y2).

% A cell with a hint must have the correct number of black neighbors
:- hint(X,Y,N), neighbor(X,Y,X2,Y2), black(X2,Y2), N!=1.

% A cell without a hint must not have any black neighbors
:- cell(X,Y), not hint(X,Y,_), neighbor(X,Y,X2,Y2), black(X2,Y2).

% A cell with a hint must not have any white neighbors
:- hint(X,Y,_), neighbor(X,Y,X2,Y2), not black(X2,Y2), not hint(X2,Y2,_).

% A cell without a hint must have at least one white neighbor
:- cell(X,Y), not hint(X,Y,_), neighbor(X,Y,X2,Y2), black(X2,Y2), not hint(X2,Y2,_).

% A cell with a hint must not have any black neighbors if the hint is 0
:- hint(X,Y,0), neighbor(X,Y,X2,Y2), black(X2,Y2).

% A cell without a hint must not have any white neighbors if it is black
:- cell(X,Y), not hint(X,Y,_), neighbor(X,Y,X2,Y2), not black(X2,Y2), not hint(X2,Y2,_), black(X,Y).

% A cell without a hint must not have any black neighbors if it is white
:- cell(X,Y), not hint(X,Y,_), neighbor(X,Y,X2,Y2), black(X2,Y2), not hint(X2,Y2,_), not black(X,Y).

% A cell without a hint must not have any white neighbors if it is black
:- cell(X,Y), not hint(X,Y,_), neighbor(X,Y,X2,Y2), not black(X2,Y2), not hint(X2,Y2,_), not black(X,Y).