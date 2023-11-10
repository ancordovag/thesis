% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define a path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the starting cell of the path
start(X,Y) :- first(X,Y), cell(X,Y).

% Define the final cell of the path
end(X,Y) :- final(X,Y), cell(X,Y).

% Define the number of bends in the path between two hint cells
bends(X,Y,XX,YY,N) :- hint(X,Y,N), hint(XX,YY,_), path(X,Y,XX,YY).

% Define the number of bends in the path between the starting cell and the first hint cell
bends_start(X,Y,XX,YY,N) :- start(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), bends(X,Y,XX,YY,N).

% Define the number of bends in the path between the last hint cell and the final cell
bends_end(X,Y,XX,YY,N) :- hint(X,Y,_), end(XX,YY), path(X,Y,XX,YY), bends(X,Y,XX,YY,N).

% Define the number of bends in the path between two hint cells
bends_between(X,Y,XX,YY,N) :- hint(X,Y,_), hint(XX,YY,_), path(X,Y,XX,YY), bends(X,Y,XX,YY,N).

% Define the number of bends in the path between the starting cell and the final cell
bends_total(N) :- start(X,Y), end(XX,YY), path(X,Y,XX,YY), bends_start(X,Y,XX,YY,N1), bends_between(X,Y,XX,YY,N2), bends_end(X,Y,XX,YY,N3), N = N1 + N2 + N3.

% Show output predicate path
#show path/4.
% The path starts at the first cell
:- not visited(X,Y), first(X,Y).

% The path ends at the final cell
:- not visited(X,Y), final(X,Y).

% The path cannot cross or intersect itself
:- path(X,Y,XX,YY), path(XX,YY,X,Y), (X!=XX ; Y!=YY).

% The path bends exactly as many times as indicated by the hint number
:- xhint(X,Y,N,D), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), D=h, (X!=XX ; XX!=XXX ; XXX!=XXXX).
:- xhint(X,Y,N,D), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), D=v, (Y!=YY ; YY!=YYY ; YYY!=YYYY).

% The path does not bend between the first cell and the first cell with a number
:- path(X,Y,XX,YY), first(X,Y), hint(XX,YY,_), (X!=XX ; Y!=YY).

% The path does not bend between a cell with a number and the final cell
:- path(X,Y,XX,YY), hint(X,Y,_), final(XX,YY), (X!=XX ; Y!=YY).