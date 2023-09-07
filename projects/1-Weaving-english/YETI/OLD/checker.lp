paint(A,N,C,T) :- gets_painted(A,N,C,T).
1 { paint(x,X,C,T) : X = 1..DX : dim(DX) : color(C), paint(y,Y,C,T) : Y = 1..DY : dim(DY) : color(C) } 1 :- T = 1..S, steps(S).
1 { paint(x,X,C,T) : color(C) : T = 1..S : steps(S) } 1 :- X = 1..DX, dim(DX).
1 { paint(y,Y,C,T) : color(C) : T = 1..S : steps(S) } 1 :- Y = 1..DY, dim(DY).

colored(X,Y) :- square_color(X,Y,C), paint(x,X,C,TX), paint(y,Y,CY,TY), TY < TX.
colored(X,Y) :- square_color(X,Y,C), paint(x,X,CX,TX), paint(y,Y,C,TY), TY > TX.

:- square_color(X,Y,C), not colored(X,Y).
#hide.
#show paint/4.
