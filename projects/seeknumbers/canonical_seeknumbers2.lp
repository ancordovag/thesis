neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v,
                          cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v,
                          cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h,
                          cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h,
                          cell(X,Y), cell(XX,YY).

1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y),   not final(X,Y).
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).

visited(X,Y) :- first(X,Y).
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

:- cell(X,Y), not visited(X,Y).

xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_),
                     edge(X,Y,XX,YY,DD),
                     D=DD.
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_),
                       edge(X,Y,XX,YY,DD),
                       D!=DD.

:- hint(X,Y,_), not xhint(X,Y,0,_).
:-  final(X,Y), not xhint(X,Y,0,_).

#show.
#show path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

