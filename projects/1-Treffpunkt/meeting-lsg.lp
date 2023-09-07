% Domains

number(X,Y) :- number(X,Y,N).

neighbor(X,Y,X+1,Y,x) :- cell(X;X+1,Y), not number(X+1,Y).
neighbor(X,Y,X-1,Y,x) :- cell(X;X-1,Y), not number(X-1,Y).
neighbor(X,Y,X,Y+1,y) :- cell(X,Y;Y+1), not number(X,Y+1).
neighbor(X,Y,X,Y-1,y) :- cell(X,Y;Y-1), not number(X,Y-1).

neighbor(X1,Y1,X2,Y2) :- neighbor(X1,Y1,X2,Y2,D).

% Generate

1 { link(X1,Y1,X2,Y2) : neighbor(X1,Y1,X2,Y2) } :- number(X1,Y1).
{ link(X1,Y1,X2,Y2) : neighbor(X1,Y1,X2,Y2) } 1 :- cell(X1,Y1).

% Test

from(X1,Y1) :- link(X1,Y1,X2,Y2), not number(X1,Y1).
goto(X2,Y2) :- link(X1,Y1,X2,Y2).

:- from(X,Y), not goto(X,Y).

meeting(X,Y) :- goto(X,Y), not from(X,Y).

:- not 1 { meeting(X,Y) } 1.
:- not M { link(X1,Y1,X2,Y2) } M, meeting(X2,Y2), M = { number(X,Y) }.
:- 2 { link(X1,Y1,X2,Y2) }, cell(X2,Y2), not meeting(X2,Y2).

reach(X,Y,X2,Y2) :- number(X,Y), link(X,Y,X2,Y2).
reach(X,Y,X2,Y2) :- reach(X,Y,X1,Y1), link(X1,Y1,X2,Y2).

:- number(X,Y), meeting(X2,Y2), not reach(X,Y,X2,Y2).
:- goto(X2,Y2), not reach(X,Y,X2,Y2) : number(X,Y).

linked(X1,Y1,X2,Y2) :- link(X1,Y1,X2,Y2).
linked(X2,Y2,X1,Y1) :- link(X1,Y1,X2,Y2), not number(X1,Y1).

turn(X,Y) :- linked(X1,Y1,X,Y), linked(X2,Y2,X,Y), neighbor(X1,Y1,X,Y,x), neighbor(X2,Y2,X,Y,y),
             not meeting(X,Y).

turn(X,Y,X2,Y2) :- reach(X,Y,X2,Y2), turn(X2,Y2).

:- not N { turn(X,Y,X2,Y2) } N, number(X,Y,N).

% Display

#hide.
#show link/4.
% #show number/3. % add for visualization (only)
