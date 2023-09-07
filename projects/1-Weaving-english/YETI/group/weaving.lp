
%%% fix paint/4 for painted/4
paint(A,N,C,T) :- painted(A,N,C,T).

%%% at each step, paint one row or column
1 { paint(x,X,C,T) : X = 1..DX, dim(DX), color(C); 
    paint(y,Y,C,T) : Y = 1..DY, dim(DY), color(C) } 1 :- T = 1..S, steps(S).

%%% paint each row and column once
axis(x). axis(y).
1 { paint(A,X,C,T) : color(C), T = 1..S, steps(S) } 1 :- axis(A), X = 1..DX, dim(DX).

%%% [X,Y] is a well colored goal cell
colored(X,Y) :- goal(X,Y,C), paint(x,X,C,TX),  paint(y,Y,CY,TY), TY < TX.
colored(X,Y) :- goal(X,Y,C), paint(x,X,CX,TX), paint(y,Y,C,TY),  TY > TX.

%%% every goal cell must be well colored
:- goal(X,Y,C), not colored(X,Y).

#show paint/4.

