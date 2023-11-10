%%%%%%%%%%  S   - start
%o2. . G3%  G   - goal
%. . . . %  o   - predetermined steps (dot)
%.1. . . %  0-3 - steps
%S0. . . %
%%%%%%%%%%

rows(4).
cols(4).
numsteps(3).
start(1,4).
goal(4,1).
dot(1,1).

%*
Answer: 1
step(1,4,0) step(1,3,1) step(1,1,2) step(4,1,3)
*%
