full(X,Y) :- cell(X,Y), number(X,Y,N).
full(F)   :- F = { full(X,Y) : full(X,Y) }.
full      :- full(F), 0 < F.
free(X,Y) :- cell(X,Y), not full(X,Y).

delta(1,0) :- full. delta(-1,0) :- full.
delta(0,1) :- full. delta(0,-1) :- full.

segment(X1,Y1,X1+DX,Y1+DY,DX,DY) :-
  free(X1,Y1), delta(DX,DY), cell(X1+DX,Y1+DY).
segment(X1,Y1,X2,Y2,DX,DY) :-
  free(X1,Y1), delta(DX,DY), cell(X2,Y2), segment(X1+DX,Y1+DY,X2,Y2,DX,DY).

segment(X1,Y1,X2,Y2) :- segment(X1,Y1,X2,Y2,DX,DY).

1 { meet(X1,Y1)       : free(X1,Y1) } 1 :- full.
1 { turn(X,Y,X1,Y1,M) : free(X1,Y1) } 1 :- number(X,Y,N), M = 1..N.
turn(X,Y,X1,Y1,N+1)                     :- number(X,Y,N), meet(X1,Y1).
turn(X,Y,X,Y,0)                         :- full(X,Y).

:- turn(X,Y,X1,Y1,M), 0 < M, not turn(X,Y,X2,Y2,M-1) : segment(X1,Y1,X2,Y2).
:- number(X,Y,N), free(X1,Y1), 2 { turn(X,Y,X1,Y1,M) : M = 1..N+1 }.

turn(X,Y,X1,Y1) :- turn(X,Y,X1,Y1,M), number(X,Y,N), 0 < M, M <= N.
turn(X1,Y1)     :- turn(X,Y,X1,Y1).

:- free(X1,Y1), 2 { turn(X,Y,X1,Y1) : number(X,Y,N) : 0 < N }.

link(X,Y,X2,Y2,X2-DX,Y2-DY,M) :-
  segment(X1,Y1,X2,Y2,DX,DY), turn(X,Y,X1,Y1,M), turn(X,Y,X2,Y2,M-1).
link(X,Y,X2,Y2,X2-DX,Y2-DY,M) :-
  segment(X1,Y1,X2,Y2,DX,DY), turn(X,Y,X1,Y1,M), link(X,Y,X2+DX,Y2+DY,X2,Y2,M).

link(X1,Y1,X2,Y2) :- link(X,Y,X1,Y1,X2,Y2,M).

:- free(X1,Y1), 2 { link(X1,Y1,X1+DX,Y1+DY) : delta(DX,DY) }.
:- free(X1,Y1), 2 { link(X1-DX,Y1-DY,X1,Y1) : delta(DX,DY) }, not meet(X1,Y1).

:- meet(X1,Y1),              1 { link(X1,Y1,X1+DX,Y1+DY) : delta(DX,DY) }.
:- meet(X1,Y1), full(F), not F { link(X1-DX,Y1-DY,X1,Y1) : delta(DX,DY) } F.

pass(X1,Y1) :- delta(DX,DY), link(X1-DX,Y1-DY,X1,Y1), link(X1,Y1,X1+DX,Y1+DY).

:- turn(X1,Y1), pass(X1,Y1).

#hide.
#show link/4.