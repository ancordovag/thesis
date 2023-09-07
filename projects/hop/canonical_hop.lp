%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

% start at "start"
step(X,Y,0) :- start(X,Y).
% move S % 3 + 1 squares in step S
1 { step(X+L;X-L,Y,S+1); step(X,Y+L;Y-L,S+1) } 1 :- step(X,Y,S), L = S \ 3 + 1, not numsteps(S).

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

% stay within bounds
:- step(X,Y,_), 1 { X < 1; Y < 1; X > C; Y > R }, rows(R), cols(C).
% don't visit one square twice
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
% visit every "dotted" square
:- dot(X,Y), { step(X,Y,S) } 0.
% end at "goal"
:- goal(X,Y), { step(X,Y,_) } 0.

%%%%%%%%%%%%%%%%%%%%%%%%
% Display only step/3  %
%%%%%%%%%%%%%%%%%%%%%%%%
#show step/3.
