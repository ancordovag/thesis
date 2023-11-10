%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%
% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% start at "start"
step(X,Y,0) :- start(X,Y).
% possible hops
hop(0,1). hop(0,2). hop(0,3). hop(0,-1). hop(0,-2). hop(0,-3).
hop(1,0). hop(2,0). hop(3,0). hop(-1,0). hop(-2,0). hop(-3,0).
% move S % 3 + 1 squares in step S
1 {step(X+A,Y+B,S+1) : hop(A,B), cell(X+A,Y+B)} 1 :- step(X,Y,S), not numsteps(S).
% taken hops
actual_hop(A,B,S) :- step(X,Y,S-1), step(P,Q,S), A=P-X, B=Q-Y.
:- actual_hop(A,B,1), |A+B| > 1.

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%
% if last hop was length 1, this one is length 2
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=1, |C+D| != 2.
% if last hop was length 2, this one is length 3
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=2, |C+D| != 3.
% if last hop was length 3, this one is length 1
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=3, |C+D| != 1.
% don't visit one square twice
visited(X,Y) :- step(X,Y,S).
:- not visited(X,Y), dot(X,Y).
:- not visited(X,Y), goal(X,Y).
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
:- goal(X,Y), step(X,Y,S), step(P,Q,S+1).

%%%%%%%%%%%%%%%%%%%%%%%%
% Display only step/3  %
%%%%%%%%%%%%%%%%%%%%%%%%
#show step/3.
