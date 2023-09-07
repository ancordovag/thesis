% map each task to a workplace
1 { map_task(P,R) : workplace(R) } 1 :- task(P,_).
% ensure the limits of workers
:- workplace(R), T+1 [ map_task(P,R) : task(P,C) = C ], time(T).

% root resource of communication task
root(C,R) :- produce(P,C), map_task(P,R).
% resources of communication task per target
sink(C,R,P) :- consume(P,C), map_task(P,R).
sink(C,R,P) :- sink(C,S,P), reached(C,R,S).
% reach communication root resource
:- consume(P,C), root(C,R), not sink(C,R,P).

% resources of communication task
reached(C,R) :- sink(C,R,_).
% backward hops of communication task
1 { reached(C,R,S) : conveyor(R,S) } 1 :- reached(C,S), not root(C,S).

% accounting
used_workplace(W) :- map_task(_,W).
%workplaces_used(X) :- X := #count { used_workplace(A) }.
%load(W,L) :- L := #sum [ map_task(P,W) : task(P,C) = C ], workplace(W).
% make sure that the instance can be solved
%:- T * CW < S, S := #sum  task(P, C) = C ],  time(T), CW := #count { workplace(W) }.

% optimization
#minimize { used_workplace(A) @ 1 }.


#hide.
#show map_task/2.
%#show workplaces_used/1.
