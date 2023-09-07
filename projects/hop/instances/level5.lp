%%%%%%%%%%  S   - start
%.7S0G8  %  G   - goal
%o6.1. .2%  o   - predetermined steps (dot)
%. . . . %  0-8 - steps
%. . . . %
%.5. .4o3%
%%%%%%%%%%

rows(5).
cols(4).
numsteps(8).
start(2,1).
goal(3,1).
dot(1,2).
dot(4,5).

%*
Answer: 1
step(2,1,0) step(2,2,1) step(4,2,2) step(4,5,3) step(3,5,4) step(1,5,5) step(1,2,6) step(1,1,7) step(3,1,8)
*%
