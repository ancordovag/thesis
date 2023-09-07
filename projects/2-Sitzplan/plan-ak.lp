%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% File: plan.lp                                                               %
%                                                                             %
% Name(s) und matriculation number(s):                                        %
%                                                                             %
% At most TWO members are allowed per group!!!                                %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seat(1..C, 1..R) :- cols(C), rows(R).
watched(X,Y) :- at(supervisor,XX,YY), #abs(X-XX) + #abs(Y-YY) < 3, seat(X,Y).
nwatched(X,Y) :- not watched(X,Y), seat(X,Y).
better(S, SS) :- exp_grade(S, G), exp_grade(SS, GG), G < GG.

%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

1 { at(student(S), X, Y) : seat(X,Y) } 1 :- S := 1..N, numstudents(N).
N { at(supervisor, X, Y) : seat(X,Y) } N :- numsupervisors(N).

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

:- at(supervisor, X, Y), at(supervisor, XX, YY), D := #abs(X-XX)+#abs(Y-YY), D < 3, D > 0.
:- not [ at(S,X,Y) ] 1, seat(X,Y).

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X, Y-1), better(SS, S), nwatched(X,Y).
gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X+1, Y), better(SS, S), nwatched(X,Y).
gains(p(S, SS)) :- at(student(S), X, Y), at(student(SS), X-1, Y), better(SS, S), nwatched(X,Y).
cheating(C) :- C := #count { gains(_) }.

#maximize [ gains(_)=1 :  mode(students), gains(_)=-1 : mode(uni) ].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show at(student(_),_,_).
#show at(supervisor,_,_).
