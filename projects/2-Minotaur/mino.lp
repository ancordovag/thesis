%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% File: mino.lp                                                               %
%                                                                             %
% Martin Gebser                                                               %
%                                                                             %
% At most TWO members are allowed per group!!!                                %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Domain

neighbor(X,Y,X,  Y, 0, 0) :- field(X,Y).
neighbor(X,Y,X+1,Y, 1, 0) :- field(X;X+1,Y), not wall(X,Y,X+1,Y).
neighbor(X,Y,X-1,Y,-1, 0) :- field(X;X-1,Y), not wall(X-1,Y,X,Y).
neighbor(X,Y,X,Y+1, 0, 1) :- field(X,Y;Y+1), not wall(X,Y,X,Y+1).
neighbor(X,Y,X,Y-1, 0,-1) :- field(X,Y;Y-1), not wall(X,Y-1,X,Y).

minox(XM,YM,XM1,YM,X,Y)   :- neighbor(XM,YM,XM1,YM, 1,0), field(X,Y), XM < X.
minox(XM,YM,XM1,YM,X,Y)   :- neighbor(XM,YM,XM1,YM,-1,0), field(X,Y), X < XM.
minox(XM,YM,X,Y)          :- minox(XM,YM,XM1,YM,X,Y).

minoy(XM,YM,XM,YM1,X,Y)   :- neighbor(XM,YM,XM,YM1,0, 1), field(X,Y), YM < Y,
                             not minox(XM,YM,X,Y).
minoy(XM,YM,XM,YM1,X,Y)   :- neighbor(XM,YM,XM,YM1,0,-1), field(X,Y), Y < YM,
                             not minox(XM,YM,X,Y).
minoy(XM,YM,X,Y)          :- minoy(XM,YM,XM,YM1,X,Y).

mino(XM,YM,XM1,YM,X,Y)    :- minox(XM,YM,XM1,YM,X,Y).
mino(XM,YM,XM,YM1,X,Y)    :- minoy(XM,YM,XM,YM1,X,Y).
mino(XM,YM,XM,YM, X,Y)    :- field(X,Y;;XM,YM), not minox(XM,YM,X,Y), not minoy(XM,YM,X,Y).

config(X,Y,XM,YM)         :- goal(X,Y), field(XM,YM), (X,Y) != (XM,YM).
config(X,Y,XM,YM)         :- trans(X,Y,XM,YM,X1,Y1,XM2,YM2).

trans(X,Y,XM,YM,X1,Y1,XM2,YM2) :- config(X1,Y1,XM2,YM2), neighbor(X,Y,X1,Y1,DX,DY),
                                  mino(XM,YM,XM1,YM1,X1,Y1), mino(XM1,YM1,XM2,YM2,X1,Y1),
                                  (X,Y) != (XM,YM), (X,Y,XM,YM) != (X1,Y1,XM2,YM2), not goal(X,Y).

% Generate

  at(X,Y,XM,YM,0)                         :- start(X,Y), mino(XM,YM), (X,Y) != (XM,YM).
{ at(X,Y,XM,YM,T) : config(X,Y,XM,YM) } 1 :- maxsteps(M), T = 1..M.

at(X,Y,T) :- at(X,Y,XM,YM,T).
at(T)     :- at(X,Y,T).

% Test

:- at(X1,Y1,XM2,YM2,T), 0 < T,
   not at(X,Y,XM,YM,T-1) : trans(X,Y,XM,YM,X1,Y1,XM2,YM2).
% :- at(X,Y,XM,YM,T), not goal(X,Y),
%    not at(X1,Y1,XM2,YM2,T+1) : trans(X,Y,XM,YM,X1,Y1,XM2,YM2).
:- not at(X,Y,T) : goal(X,Y) : maxsteps(M) : T = 0..M.

% Optimize

#minimize { at(T) }.

% Display

#hide.
#show at/3.
