%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% File: plan.lp                                                               %
%                                                                             %
% Name: Martin Gebser                                                         %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

% Students, supervisors, and grades

stud(1..N)    :- numstudents(N).
stud(S,G)     :- stud(S), G := #min[ exp_grade(S,E) = E ].
stud(G,S1,S2) :- stud(S1;S2,G), S1 < S2, S <= S1 : stud(S,G) : S < S2.

card(s,N) :- numsupervisors(N), 0 < N.
card(G,N) :- grad(G), G != s, N := #count{ stud(_,G) }.
card(M)   :- M := #max[ card(_,N) = N ], 1 < M.
card      :- card(_).

grad(s)     :- card(s,_).
grad(G)     :- stud(_,G).
grad(G1,G2) :- grad(G1;G2), G1 < G2, G <= G1 : grad(G) : G < G2.

numb(G,S1,1)   :- grad(G), G != s, S1 := #min[ stud(S,G) = S ].
numb(G,S2,I+1) :- numb(G,S1,I), stud(G,S1,S2).

% Seats and observability

col(1..C) :- cols(C).  row(1..R) :- rows(R).
seat(X,Y) :- col(X), row(Y).
 :- cols(C), rows(R), not #sum[ card(_,N) = N ] C*R.

seat(X,Y,X,Y+1) :- seat(X,Y), row(Y+1), grad(#supremum) : not card.
seat(X,Y,X+1,1) :- seat(X,Y), col(X+1), grad(#supremum) : not card, rows(Y).

foll(C,R,1)   :- cols(C), rows(R), card.
foll(X,Y,N+1) :- seat(X,Y,XX,YY), foll(XX,YY,N), card(M), N < M.

dir(1,0;;-1,0;;0,1;;0,-1).
div(DX,DY)        :- dir(DX,DY), DY < |DX|.
div(DX,DY,-DY,DX) :- dir(DX,DY), DX < |DY|.

spot(X,Y,DX,DY)         :- seat(X,Y;;X+DX,Y+DY), dir(DX,DY).
spot(X,Y,DX,DY,DDX,DDY) :- spot(X,Y,DX,DY), seat(X+DX+DDX,Y+DY+DDY), dir(DDX,DDY),
                           DX*DDX+DY*DDY != -1.

% Generate seat plan

1 { occ(G,X,Y) : seat(X,Y) } 1 :- card(G,1), G != #supremum.
  { occ(G,X,Y) : seat(X,Y) }   :- card(G,N), G != #supremum, 1 < N.

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

% Unique grade per seat

low(G2,X,Y) :- occ(G1,X,Y), grad(G1,G2).
low(G2,X,Y) :- low(G1,X,Y), grad(G1,G2).
 :- low(G,X,Y), occ(G,X,Y).

% Exact placement

out(G,X,Y)         :- card(G,N), occ(G,X,Y), 1 < N.
out(#supremum,X,Y) :- grad(#supremum), seat(X,Y), not low(#supremum,X,Y).

out(G,X,Y,1)   :- card(G,N), out(G,X,Y), N <= M : foll(X,Y,M).
out(G,X,Y,I)   :- card(G,N), out(G,XX,YY,I), seat(XX,YY,X,Y), N-I < M : foll(X,Y,M).
out(G,X,Y,I+1) :- card(G,N), out(G,XX,YY,I), seat(XX,YY,X,Y), out(G,X,Y), I < N.
 :- card(G,N), out(G,XX,YY,N), seat(XX,YY,X,Y), occ(G,X,Y).
 :- card(G,N), cols(C), rows(R), G != #supremum, 1 < N, not out(G,C,R,N).

at(supervisor,X,Y) :- occ(s,X,Y).
at(student(S),X,Y) :- occ(G,X,Y), stud(S,G), card(G,1).
at(student(S),X,Y) :- out(G,X,Y,I), numb(G,S,I), not out(G,XX,YY,I) : seat(XX,YY,X,Y).

% Observed seats and students

obs(X+DX,Y+DY,DDX,DDY) :- occ(s,X,Y), spot(X,Y,DX,DY,DDX,DDY).
obs(X+DX,Y+DY)         :- occ(s,X,Y), spot(X,Y,DX,DY).
obs(X+DX,Y+DY)         :- obs(X,Y,DX,DY).
obs(S)                 :- obs(X,Y), at(student(S),X,Y), stud(S,G), grad(_,G), G < s.
 :- obs(X,Y), occ(s,X,Y), card(s,N), 1 < N.

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

ord(S1,S2) :- grad(_,G), stud(G,S1,S2), G < s.
ord(S1,S2) :- grad(_,G), card(G,N), numb(G,S1,N), grad(G,G2), numb(G2,S2,1), G2 < s.
ord(S)     :- grad(_,G), card(G,N), numb(G,S,N), s <= G2 : grad(G,G2).

can(0..(M*(M-1))/2) :- M := #sum[ G < s = N : card(G,N) ].

can(S,DX,DY) :- at(student(S),X,Y), stud(S,G), div(DX,DY), low(G,X+DX,Y+DY), G < s.

can(S,0,1,0)     :- stud(S,G), grad(_,G), G < s, not obs(S).
can(S,DX,DY,I)   :- can(S,DDX,DDY,I), div(DDX,DDY,DX,DY), can(I), 0 < I : DX == 1.
can(S,DX,DY,I+1) :- can(S,DDX,DDY,I), div(DDX,DDY,DX,DY), can(I+1), can(S,DX,DY).

can(S,I)    :- can(S,1,0,I).
can(S2,I)   :- ord(S1,S2), can(S1,I).
can(S2,I+J) :- ord(S1,S2), can(S1,I), can(S2,1,0,J), can(I+J).

mul(1) :- mode(uni).  mul(-1) :- mode(students).

#minimize[ can(S,_) = M : ord(S) : mul(M) ].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display only at/3                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show at(student(_),_,_).
#show at(supervisor,_,_).
