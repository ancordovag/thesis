%%%
%%% player movements
%%%

next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
next(X,Y,X,Y)   :- field(X,Y).
next(X,Y,XX,YY) :- next(XX,YY,X,Y).

at(X,Y,0) :- start(X,Y).

1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :-
   at(X,Y,T), 
   not goal(X,Y),
   maxsteps(S), T < S.


%%%
%%% mino movements
%%%

mino_step(X,Y,XX,YY,( 1, 0)) :- field(X,Y), field(XX,YY), X < XX, next(X,Y,X+1,Y).
mino_step(X,Y,XX,YY,(-1, 0)) :- field(X,Y), field(XX,YY), X > XX, next(X,Y,X-1,Y).

mino_step(X,Y,XX,YY,( 0, 1)) :- field(X,Y), field(XX,YY), Y < YY, next(X,Y,X,Y+1),
                                not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).
mino_step(X,Y,XX,YY,( 0,-1)) :- field(X,Y), field(XX,YY), Y > YY, next(X,Y,X,Y-1),
                                not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).

mino_step(X,Y,XX,YY,( 0, 0)) :- field(X,Y), field(XX,YY),
                                not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)),
                                not mino_step(X,Y,XX,YY,( 0, 1)), not mino_step(X,Y,XX,YY,( 0,-1)).

mino_next(X,Y,XX,YY,X+DX1+DX2,Y+DY1+DY2) :- mino_step(    X,    Y,XX,YY,(DX1,DY1)),
                                            mino_step(X+DX1,Y+DY1,XX,YY,(DX2,DY2)).

mino(  X,  Y,  0) :- mino(X,Y).
mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S,
                     at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY).


%%%
%%% test
%%%

:- at(X,Y,T), mino(X,Y,T).
goal :- at(X,Y,T), goal(X,Y).
:- not goal.

%%%
%%% optimize
%%%

#minimize{ T : at(X,Y,T) }.

%%%
%%% display
%%%
#show at/3.