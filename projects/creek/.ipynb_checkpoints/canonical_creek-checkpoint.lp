% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% Andrés Córdova
% cordovagalle@uni-potsdam.de

plus(0,0). plus(0,1). plus(1,0). plus(1,1).
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Your implementation please...
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).

path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.
%path(X,Y,A,B) :- path(X,Y,P,Q), path(P,Q,A,B).
%:- not path(X,Y,P,Q), white(X,Y), white(P,Q).

visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
visit(X+DX,Y+DY) :- first_visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
:- not visit(X,Y), white(X,Y).	

white(X,Y) :- not black(X,Y), cell(X,Y).
black(X,Y) :- not white(X,Y), cell(X,Y).

mini_x(M) :- M = #min{X,Y : white(X,Y)}.
mini_y(N) :- N = #min{Y : white(M,Y), mini_x(M)}.
first_visit(M,N) :- mini_x(M), mini_y(N).

#show black/2.