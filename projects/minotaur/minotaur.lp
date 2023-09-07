% Please insert the names and email addresses of the group members:
% Andrés Alejandro Córdova Galleguillos	
% cordovagalle@uni-potsdam.de

%
% Guess solution candidates
%
time(1..H) :- maxsteps(H).
diff(1,0). diff(0,1). diff(-1,0). diff(0,-1).
neighbor(X1,Y1,X2,Y2) :- field(X1,Y1), field(X2,Y2), diff(DX,DY), |X2-X1| = |DX|, |Y2-Y1| = |DY|, not wall(X1,Y1,X2,Y2), not wall(X2,Y2,X1,Y1).

% Movements of Teseo
% Teseo starts at the start point
at(X,Y,0) :- start(X,Y).
{at(X1,Y1,T)} 1 :-  neighbor(X,Y,X1,Y1), at(X,Y,T-1), time(T), not goal(X,Y).
{at(X,Y,T+1)} :- at(X,Y,T), time(T), not goal(X,Y).
%at(2,3,0). at(2,2,1). at(2,1,2). at(1,1,3). at(1,1,4). at(2,1,5). at(2,2,6). at(3,2,7). at(3,3,8).

% Movement of Minotaur
% The minotaur starts at its start point
mino_at(X,Y,0,2) :- mino(X,Y).
% First case: Teseo is at the left or the right
mino_at(A-1,B,T,1) :- at(X,Y,T), mino_at(A,B,T-1,2), X<A, neighbor(A,B,A-1,B).
mino_at(A+1,B,T,1):- at(X,Y,T), mino_at(A,B,T-1,2), X>A, neighbor(A,B,A+1,B).
mino_at(A-1,B,T,2):- at(X,Y,T), mino_at(A,B,T,1), X<A, neighbor(A,B,A-1,B).
mino_at(A+1,B,T,2):- at(X,Y,T), mino_at(A,B,T,1), X>A, neighbor(A,B,A+1,B).

% Second case: Teseo is up or down and left and rigt movements are not possible
mino_at(A,B+1,T,1):- at(X,Y,T), mino_at(A,B,T-1,2), Y>B, neighbor(A,B,A,B+1), not mino_at(A-1,B,T,1), not mino_at(A+1,B,T,1).
mino_at(A,B-1,T,1):- at(X,Y,T), mino_at(A,B,T-1,2), Y<B, neighbor(A,B,A,B-1), not mino_at(A-1,B,T,1), not mino_at(A+1,B,T,1).
mino_at(A,B+1,T,2):- at(X,Y,T), mino_at(A,B,T,1), 	Y>B, neighbor(A,B,A,B+1), not mino_at(A-1,B,T,2), not mino_at(A+1,B,T,2).
mino_at(A,B-1,T,2):- at(X,Y,T), mino_at(A,B,T,1), 	Y<B, neighbor(A,B,A,B-1), not mino_at(A-1,B,T,2), not mino_at(A+1,B,T,2).

%Third case: Minotaur reaches Teseo
mino_at(X,Y,T,1) :- at(X,Y,T), mino_at(X,Y,T-1,2), time(T).
mino_at(X,Y,T,2) :- at(X,Y,T), mino_at(X,Y,T,1), time(T).

%mino(X,Y,T,1) :- not mino_at(A,B,T,1), mino_at(X,Y,T-1,2), field(X,Y), field(A,B), (X,Y)!=(A,B), time(T).
%mino(X,Y,T,2) :- not mino_at(A,B,T,2), mino_at(X,Y,T,1), field(X,Y), field(A,B), (X,Y)!=(A,B), time(T).
{mino_at(X,Y,T,1)} 1 :- mino_at(X,Y,T-1,2), at(_,_,T).
{mino_at(X,Y,T,2)} 1 :- mino_at(X,Y,T,1), at(_,_,T).
%% There should be always a position for the minotaur
:- not mino_at(_,_,T,_), at(_,_,T).

mino(X,Y,T) :- mino_at(X,Y,T,2).
%
% Check solution candidates
%
%It cannot be possible that Teseo is in two cells at the same time
:- at(X,Y,T), at(A,B,T), (X,Y) < (A,B).
% Teseo reahes the goal
reached(T) :- at(X,Y,T), goal(X,Y).
:- not reached(_).
% Minotaur is not in two cells at the same time.
:- mino_at(X,Y,T,S), mino_at(A,B,T,S), (A,B) < (X,Y).
gotcha(X,Y,T) :- at(X,Y,T), mino_at(X,Y,T,_).
:- gotcha(X,Y,T).

%
% Optimize solutions
%
#minimize{1,X,Y,T: at(X,Y,T)}.


%
% Display
%

%#show mino_at/4.
%#show mino/3.
#show at/3.