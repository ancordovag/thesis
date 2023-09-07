% auxiliary predicates
p(student(1..N)) :- numstudents(N).
place(1..C,1..R) :- cols(C), rows(R).

% types of terms in atoms over at/3
error(type(X,Y)) :- at(_,X,Y), not place(X,Y).
error(type(A))   :- at(A,_,_), A != supervisor, not p(A).

% exactly one place per student
error(zero(A)) :- p(A), not at(A,X,Y) : place(X,Y).
error(more(A)) :- p(A), at(A,X1,Y1;;A,X2,Y2), (X1,Y1) < (X2,Y2).

% minimum distance between supervisors
error(sups(X1,Y1,X2,Y2)) :- at(supervisor,X1,Y1;;supervisor,X2,Y2),
                            (X1,Y1) < (X2,Y2), X2-X1+|Y2-Y1| < 3.

% unambiguous placement of students and supervisors
error(ambi(X,Y)) :- at(A;B,X,Y), A < B.
error(placement) :- numstudents(N), numsupervisors(M),
                    not M+N #count{ at(_,_,_) } M+N.

% cheating pairs of students
cheat(A,B) :- at(student(A),X1,Y1;;student(B),X2,Y2),
              Y1-1 <= Y2, Y2 <= Y1, |X2-X1| == Y2-Y1+1,
              exp_grade(A,G1), exp_grade(B,G2), G2 < G1,
              2 < |X-X1|+|Y-Y1| : at(supervisor,X,Y).

% evaluate number of cheating pairs w.r.t. correct solution (-1 indicates error)
error    :- error(_).
value(V) :- V := #sum[ error = -1, cheat(_,_) = 1 : not error ].

% hide additional predicates except for value/1
#hide p/1.
#hide place/2.
#hide error/1.
#hide error.
#hide cheat/2.

% values obtained w.r.t. optimal solutions for test instances
%*
$ for test in test??.lp; do echo -n "${test}: "; gringo plan.lp ${test} | clasp 0 | grep -B 2 -e "OPTIMUM FOUND" | head -n 1 | sed -e 's/ /\. /g' -e 's/)$/)\./' | gringo - evaluate.lp ${test} | clasp 1 | grep -o -e "value([-0-9]*)"; done
test01.lp: value(7)
test02.lp: value(6)
test03.lp: value(0)
test04.lp: value(7)
test05.lp: value(0)
test06.lp: value(0)
test07.lp: value(0)
test08.lp: value(7)
test09.lp: value(7)
test10.lp: value(5)
test11.lp: value(6)
test12.lp: value(8)
test13.lp: value(11)
test14.lp: value(12)
test15.lp: value(11)
test16.lp: value(12)
*%
