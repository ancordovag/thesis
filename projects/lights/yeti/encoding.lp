field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
digit(X,Y) :- digit(X,Y,N).

delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

{ light(X,Y) } :- field(X,Y), not digit(X,Y).

lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

:- light(X,Y), lighted(X,Y).
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

#hide.
#show light/2.