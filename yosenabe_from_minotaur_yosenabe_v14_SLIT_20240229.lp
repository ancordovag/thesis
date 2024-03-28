% All the posible directionsdir(0,1). 
dir(0,-1). 
dir(1,0). 
dir(-1,0).% No different targets for the same number:- target(X,Y,I,J), target(X,Y,I',J'), I != I'.
:- target(X,Y,I,J), target(X,Y,I,J'), J != J'.% No different targets for the same number:- target(X,Y,I,J), target(X,Y,I',J'), I != I'.
:- target(X,Y,I,J), target(X,Y,I,J'), J != J'.% Only horizontal or vertical movements:- target(X,Y,I,J), X != I, Y != J.% Only one target point to one cell:- target(X,Y,I,J), target(X',Y',I,J), X != X', Y != Y'.% The paths are not crossed:- target(X,Y,I,J), target(X',Y',I',J'), I>I', X'<X.% Each gray area must be populated with at least one moved number.counttarget(T,A) :- T = #count{number(X,Y,Z): number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, area(_,_,A).
:- T = 0, counttarget(T,A).% The areas have valuestotal(A,S) :- S = #sum{ Z : number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, goal(A,V).
:- total(A,S), S != V, goal(A,V).% For each number, there is a target related to only one area1 { target(X,Y,I,J) : area(I,J,A) } 1 :- number(X,Y,Z).% Show output predicate#show target/4.