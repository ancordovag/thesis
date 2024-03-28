% Andres (cordovagalle@uni-potsdam.de)
% Yulia (yulia.constien@uni-potsdam.de)

% Tips:
% - You may include the facts below to represent the differences
%   between the coordinates of neighboring cells
%
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).  

% Your encoding please...

%marks the first cells as seen
seen(X1,Y1):- first(X1,Y1).    


% define the neighbors of a cell
neighbor(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), diff(DX,DY), |X2-X1| = |DX|, |Y2-Y1| = |DY|.

%generate path between seen cell and a neighboring cell
{path(X1,Y1,X2,Y2)} 1 :- seen(X1,Y1), neighbor(X1,Y1,X2,Y2).

% Path should be continuous
:- not path(X,Y,_,_), cell(X,Y), not final(X,Y).
:- not path(_,_,X,Y), cell(X,Y), not first(X,Y).

% if there is a path between 2 cells then the second one marked as visited
seen(X2,Y2) :- path(X1,Y1,X2,Y2), seen(X1,Y1).


%makes sure all cells were seen
:- cell(X,Y), not seen(X,Y).

% makes sure no cell is visited twice
:- path(A,B,X,Y), path(P,Q,X,Y), (P,Q) < (A,B).

% makes sure there is always a path coming out from the first cell
:- first(X,Y), not path(X,Y,_,_).

% makes sure that there is no path coming out of the final cell
:- final(X,Y), path(X,Y,_,_).

%makes sure no path going into the first cell
:- path(_,_,X,Y), first(X,Y).

% makes sure that final cell has a path going in
:- not path(_,_,X,Y), final(X,Y).

%sets the bending counter to 0 so there wont be bends between first cell and first hint
bend(A,B,0) :- first(X,Y), path(X,Y,A,B).

%bend as many times as the hint says 
bend(A,B,N) :- hint(X,Y,N), path(X,Y,A,B).

% change the hint counter eitehr by decreasing if the direction is changed or by keeping the same if direction dosent change 

bend(X3,Y3,N-1):- path(X1,Y1,X2,Y2), path(X2,Y2,X3,Y3), (X2-X1,Y2-Y1)!=(X3-X2,Y3-Y2), bend(X2,Y2,N), N>0, not hint(X2,Y2,_).
bend(X3,Y3,N):-  path(X1,Y1,X2,Y2), path(X2,Y2,X3,Y3), (X2-X1,Y2-Y1)==(X3-X2,Y3-Y2), bend(X2,Y2,N), not hint(X2,Y2,_).

%makes sure counter is 0 whenever there is a hint or at final cell

:- hint(X,Y,N), not bend(X,Y,0).
:- final(X,Y), not bend(X,Y,0).


#show path/4.
