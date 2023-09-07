% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the starting cell of the path
path(X,Y,X,Y) :- first(X,Y).

% Define the ending cell of the path
path(X,Y,X,Y) :- final(X,Y).

% Define the path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the path between a cell with a number and the next cell with a number or the final cell
path(X,Y,XX,YY) :- hint(X,Y,N), cell(XX,YY), |X-XX| + |Y-YY| = 1, N > 0, path(X,Y,XX,YY), N-1 = #count{A,B : path(X,Y,A,B), cell(A,B), |A-XX| + |B-YY| = 1}.

% Define the path between the starting cell and the first cell with a number
path(X,Y,XX,YY) :- first(X,Y), hint(XX,YY,N), |X-XX| + |Y-YY| = 1, N = #count{A,B : path(X,Y,A,B), cell(A,B), |A-XX| + |B-YY| = 1}.

% Define the path between the starting cell and the final cell
path(X,Y,XX,YY) :- first(X,Y), final(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the path between a cell with a number and the final cell
path(X,Y,XX,YY) :- hint(X,Y,N), final(XX,YY), |X-XX| + |Y-YY| = 1, N = #count{A,B : path(X,Y,A,B), cell(A,B), |A-XX| + |B-YY| = 1}.

% Define the path between two cells with numbers
path(X,Y,XX,YY) :- hint(X,Y,N), hint(XX,YY,M), |X-XX| + |Y-YY| = 1, N = #count{A,B : path(X,Y,A,B), cell(A,B), |A-XX| + |B-YY| = 1}, M = #count{A,B : path(XX,YY,A,B), cell(A,B), |A-X| + |B-Y| = 1}.

% Define the path between two cells with numbers and the final cell
path(X,Y,XX,YY) :- hint(X,Y,N), hint(XX,YY,M), final(XX,YY), |X-XX| + |Y-YY| = 1, N = #count{A,B : path(X,Y,A,B), cell(A,B), |A-XX| + |B-YY| = 1}, M = #count{A,B : path(XX,YY,A,B), cell(A,B), |A-X| + |B-Y| = 1}.
% The path must start at the first cell
:- not path(X,Y,_,_), first(X,Y).

% The path must end at the final cell
:- not path(_,_,X,Y), final(X,Y).

% The path must traverse each remaining cell without crossing or intersecting itself
:- path(X,Y,_,_), path(XX,YY,_,_), path(XXX,YYY,_,_), path(XXXX,YYYY,_,_), X=XX, Y=YY, X=XXX, Y=YYY, X=XXXX, Y=YYYY, (XX\=XXX; YY\=YYY), (XX\=XXXX; YY\=YYYY), (XXX\=XXXX; YYY\=YYYY).

% The path must bend exactly as often as the number in the first cell indicates
:- path(X,Y,XX,YY), hint(X,Y,N), count_bends(X,Y,XX,YY,C), C\=N.

% The path must not bend between the first cell and the first cell with a number
:- path(X,Y,XX,YY), first(X,Y), hint(XX,YY,_), count_bends(X,Y,XX,YY,C), C\=0.

% The path must bend between a cell with a number and the next cell with a number or the final cell
:- path(X,Y,XX,YY), hint(X,Y,N), hint(XX,YY,_), count_bends(X,Y,XX,YY,C), C\=N.

% Count the number of bends between two cells
count_bends(X,Y,XX,YY,C) :- path(X,Y,XX,YY), bend(X,Y,XX,YY,C).

% A bend occurs when the path changes direction
bend(X,Y,XX,YY,1) :- path(X,Y,XX,YY), (X\=XX; Y\=YY).

% No bend occurs when the path continues in the same direction
bend(X,Y,XX,YY,0) :- path(X,Y,XX,YY), X=XX, Y=YY.