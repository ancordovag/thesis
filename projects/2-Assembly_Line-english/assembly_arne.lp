%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

% map each task to a workplace
1 { map_task(P,R) : workplace(R) } 1 :- task(P,_).

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

% ensure the limits of workers
:- workplace(R), T+1 [ map_task(P,R) : task(P,C) = C ], time(T).

% reachability check
connected(A,A) :- workplace(A).
connected(A,B) :- conveyor(A,B).
connected(A,C) :- connected(A,B), connected(B,C), sorter(B).
:- produce(A,P), consume(B,P), map_task(A,R), map_task(B,S), not connected(R,S), R != S.

% make sure that the instance can be solved
used_workplace(W) :- map_task(_,W).
:- X * T < W, X := #count { used_workplace(A) }, W := #sum [task(_, C) = C ], time(T).

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

#minimize { used_workplace(A) @ 1 }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display only map_task/2 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show map_task/2.
