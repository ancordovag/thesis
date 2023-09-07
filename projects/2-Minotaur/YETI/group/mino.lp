
%%%
%%% player movements
%%%

next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
next(X,Y,X,Y)   :- field(X,Y).
next(X,Y,XX,YY) :- next(XX,YY,X,Y).

at(X,Y,0) :- start(X,Y).

1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y),
                                           maxsteps(S), T < S.


%%%
%%% mino movements
%%%

mino_next0(X,Y,XX,YY,plus_x) :- field(X,Y), field(XX,YY), X < XX, next(X,Y,X+1,Y).
mino_next0(X,Y,XX,YY,less_x) :- field(X,Y), field(XX,YY), X > XX, next(X,Y,X-1,Y).
mino_next0(X,Y,XX,YY,plus_y) :- field(X,Y), field(XX,YY), Y < YY, next(X,Y,X,Y+1), 
                                not mino_next0(X,Y,XX,YY,plus_x), not mino_next0(X,Y,XX,YY,less_x).
mino_next0(X,Y,XX,YY,less_y) :- field(X,Y), field(XX,YY), Y > YY, next(X,Y,X,Y-1),
                                not mino_next0(X,Y,XX,YY,plus_x), not mino_next0(X,Y,XX,YY,less_x).
mino_next0(X,Y,XX,YY,zero)   :- field(X,Y), field(XX,YY), 
                                not mino_next0(X,Y,XX,YY,plus_x), not mino_next0(X,Y,XX,YY,less_x),
                                not mino_next0(X,Y,XX,YY,plus_y), not mino_next0(X,Y,XX,YY,less_y).
                                
x(plus_x,1). x(less_x,-1). x(plus_y,0). x(less_y,0).  x(zero,0). 
y(plus_x,0). y(less_x,0).  y(plus_y,1). y(less_y,-1). y(zero,0).

mino_next(X,Y,XX,YY,X+XD+XDD,Y+YD+YDD) :- 
                                mino_next0(X,Y,XX,YY,D),        x(D,XD),   y(D,YD), 
                                mino_next0(X+XD,Y+YD,XX,YY,DD), x(DD,XDD), y(DD,YDD).

mino(X,Y,0) :- mino(X,Y).
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

#minimize { 1,T : at(X,Y,T) }.

%%%
%%% display
%%%
#show at/3.

