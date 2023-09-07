% The first cell of the path is visited
visited(X,Y) :- first(X,Y).

% The final cell of the path is visited
visited(X,Y) :- final(X,Y).

% A cell is visited if there is a path from a visited cell to that cell
visited(X,Y) :- visited(P,Q), path(P,Q,X,Y).

% A cell is visited if there is a hint number in that cell
visited(X,Y) :- hint(X,Y,_).

% A cell is visited if there is a hint number in a neighboring cell and the path bends the correct number of times
visited(X,Y) :- hint(P,Q,N), path(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends the correct number of times
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), bend_count(P,Q,X,Y,N).

% A cell is visited if it is a neighboring cell of a visited cell and the path does not bend
visited(X,Y) :- visited(P,Q), neighbor(P,Q,X,Y), not bend(P,Q,X,Y).

% A cell is visited if it is a neighboring cell of a visited cell and the path bends
visited(X,Y)
visited(X,Y) :- path(X,Y,_,_).
visited(X,Y) :- path(_,_,X,Y).

path(X,Y,XX,YY) :- first(X,Y), hint(X,Y,_), final(XX,YY).
path(X,Y,XX,YY) :- hint(X,Y,_), hint(XX,YY,_), X != XX, Y != YY.
path(X,Y,XX,YY) :- hint(X,Y,N), hint(XX,YY,M), N != M, X != XX, Y != YY.
path(X,Y,XX,YY) :- hint(X,Y,N), hint(XX,YY,M), N = M, X != XX, Y != YY, bend(X,Y,XX,YY).
path(X,Y,XX,YY) :- hint(X,Y,_), final(XX,YY), bend(X,Y,XX,YY).

bend(X,Y,XX,YY) :- X = XX, Y != YY.
bend(X,Y,XX,YY) :- X != XX, Y = YY.

:- not visited(X,Y), cell(X,Y).
:- not visited(X,Y), first(X,Y).
:- not visited(X,Y), final(X,Y).
:- not path(X,Y,_,_), cell(X,Y).
:- not path(_,_,X,Y), cell(X,Y).
:- not path(X,Y,_,_), first(X,Y).
:- not path(_,_,X,Y), first(X,Y).
:- not path(X,Y,_,_), final(X,Y).
:- not path(_,_,X,Y), final(X,Y).
:- not bend(X,Y,XX,YY), hint(X,Y,_), hint(XX,YY,_), X != XX, Y != YY.
:- not bend(X,Y,XX,YY), hint(X,Y,_), final(XX,YY), X != XX, Y != YY.