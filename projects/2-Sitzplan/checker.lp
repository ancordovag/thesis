seat(1..C, 1..R) :- cols(C), rows(R).
watched(X,Y) :- at(supervisor,XX,YY), #abs(X-XX) + #abs(Y-YY) < 3, seat(X,Y).
nwatched(X,Y) :- not watched(X,Y), seat(X,Y).
better(S, SS) :- exp_grade(S, G), exp_grade(SS, GG), G < GG.

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

:- not 1 { at(student(S), X, Y) : seat(X,Y) } 1, S := 1..N, numstudents(N).
:- not N [ at(supervisor, X, Y) : seat(X,Y) ] N, numsupervisors(N).

:- at(supervisor, X, Y), at(supervisor, XX, YY), D := #abs(X-XX)+#abs(Y-YY), D < 3, D > 0.
:- not [ at(S,X,Y) ] 1, seat(X,Y).

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X, Y-1), better(SS, S), nwatched(X,Y).
gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X+1, Y), better(SS, S), nwatched(X,Y).
gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X-1, Y), better(SS, S), nwatched(X,Y).
cheating(C) :- C := #count { gains(_) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
%#show at/3.
#show cheating/1.
