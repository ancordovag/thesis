time(1..N) :- maxsteps(N).

swall(X1,Y1,X2,Y2) :- wall(X1,Y1,X2,Y2).
swall(X2,Y2,X1,Y1) :- wall(X1,Y1,X2,Y2).

neighbor(X1,Y1,X2,Y2) :- #abs(X1-X2) + #abs(Y1-Y2) <= 1,
		      	 field(X1,Y1), field(X2,Y2),
			 not swall(X1,Y1,X2,Y2).

%%%% Startup

at(X,Y,0) :- start(X,Y).
mino(X,Y,0) :- mino(X,Y).

%%%% Player

% Generate a followup-field for each taken
%1{ at(X1,Y1,T) : neighbor(X,Y,X1,Y1) }1 :- at(X,Y,T-1), time(T), not goal(X,Y).
%:- 1{ at(X,Y,T) : #abs(X-X1) + #abs(Y-Y1) > #abs(N-T) } , goal(X1,Y1), maxsteps(N).

% This looks bad, but works...
% Combination of generator + constraint from above
1{ at(X1,Y1,T) : neighbor(X,Y,X1,Y1) : goal(X2,Y2) : maxsteps(N) : #abs(X2-X1) + #abs(Y2-Y1) <= #abs(N-T)}1 :- at(X,Y,T-1), time(T), not goal(X,Y).


% Brute force, as elegant as a cross dessing elephant
% But interestingly - also as fast
%1{ at(X,Y,T) : field(X,Y) :
%   goal(X1,Y1) : maxsteps(N) : #abs(X-X1) + #abs(Y-Y1) <= #abs(N-T) }1
%   :- time(T), not escaped(T1) : time(T1) : T1 < T.
%:- at(X,Y,T-1), at(X1,Y1,T), not neighbor(X,Y,X1,Y1).

at(T) :- at(X,Y,T).

#minimize{at(T)}.

%%%% Minotaur

% First step of the mino...
mino1(X1+1,Y1,T) :- mino(X1,Y1,T-1), 1{ at(X2,Y2,T) : X2 > X1 }, time(T),
	       	    neighbor(X1,Y1,X1+1,Y1).
mino1(X1-1,Y1,T) :- mino(X1,Y1,T-1), 1{ at(X2,Y2,T) : X2 < X1 }, time(T),
	       	    neighbor(X1,Y1,X1-1,Y1).
mino1(X1,Y1+1,T) :- mino(X1,Y1,T-1), 1{ at(X2,Y2,T) : Y2 > Y1 }, time(T),
	       	    neighbor(X1,Y1,X1,Y1+1),
		    { mino1(X1+1,Y1,T) , mino1(X1-1,Y1,T) }0.
mino1(X1,Y1-1,T) :- mino(X1,Y1,T-1), 1{ at(X2,Y2,T) : Y2 < Y1 }, time(T),
	       	    neighbor(X1,Y1,X1,Y1-1),
		    { mino1(X1+1,Y1,T) , mino1(X1-1,Y1,T) }0.
mino1(X1,Y1,T)   :- { mino1(X,Y,T):neighbor(X,Y,X1,Y1):p(X,Y)!=p(X1,Y1) }0,
	       	    time(T), mino(X1,Y1,T-1).

% Second step of the mino - based upon the first...
mino(X1+1,Y1,T) :- mino1(X1,Y1,T), 1{ at(X2,Y2,T) : X2 > X1 }, time(T),
	       	   neighbor(X1,Y1,X1+1,Y1).
mino(X1-1,Y1,T) :- mino1(X1,Y1,T), 1{ at(X2,Y2,T) : X2 < X1 }, time(T),
	       	   neighbor(X1,Y1,X1-1,Y1).
mino(X1,Y1+1,T) :- mino1(X1,Y1,T), 1{ at(X2,Y2,T) : Y2 > Y1 }, time(T),
	       	   neighbor(X1,Y1,X1,Y1+1),
		   { mino(X1+1,Y1,T) , mino(X1-1,Y1,T) }0.
mino(X1,Y1-1,T) :- mino1(X1,Y1,T), 1{ at(X2,Y2,T) : Y2 < Y1 }, time(T),
	       	   neighbor(X1,Y1,X1,Y1-1),
		   { mino(X1+1,Y1,T) , mino(X1-1,Y1,T) }0.
mino(X1,Y1,T)   :- { mino(X,Y,T):neighbor(X,Y,X1,Y1):p(X,Y)!=p(X1,Y1) }0,
	      	   time(T), mino1(X1,Y1,T).

% Not omnomnom
:- mino(X,Y,T), at(X,Y,T).

state(T,X,Y,X1,Y1) :- at(X,Y,T), mino(X1,Y1,T),
		      p(X,Y) != p(X1,Y1), not goal(X,Y).
:- 2{ state(_,X,Y,X1,Y1) }, field(X,Y), field(X1,Y1).

% This will find also the 1-step-standing-for-player-AND-mino solutions
% But it's slower (around x7)
%:- state(T,X,Y,X1,Y1) , 1{ state(T1,X,Y,X1,Y1):#abs(T-T1)>1 }.

#hide.
#show at/3.
