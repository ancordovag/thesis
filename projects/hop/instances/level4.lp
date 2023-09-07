%%%%%%%%%%%%  S   - start
%. . . . . %  G   - goal
%.2. . .3o4%  o   - predetermined steps (dot)
%. . . . . %  0-5 - steps
%o1S0. . G5%
%%%%%%%%%%%%

rows(4).
cols(5).
numsteps(5).
start(2,4).
goal(5,4).
dot(1,4).
dot(4,2).

%*
Answer: 1
step(2,4,0) step(1,4,1) step(1,2,2) step(4,2,3) step(5,2,4) step(5,4,5)
*%
