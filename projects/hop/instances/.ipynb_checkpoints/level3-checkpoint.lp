%%%%%%%%%%%%  S   - start
%. . . . G4%  G   - goal
%. o2. . .3%  o   - predetermined steps (dot)
%. . . . . %  0-4 - steps
%S0.1. . . %
%%%%%%%%%%%%

rows(4).
cols(5).
numsteps(4).
start(1,4).
goal(5,1).
dot(2,2).

%*
Answer: 1
step(1,4,0) step(2,4,1) step(2,2,2) step(5,2,3) step(5,1,4)
*%
