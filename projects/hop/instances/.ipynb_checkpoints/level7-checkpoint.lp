%%%%%%%%%%  S   - start
%. G6. . %  G   - goal
%. . . . %  o   - predetermined steps (dot)
%.1S0. . %  0-6 - steps
%. .5. .4%
%o2. . .3% This instance has two solutions!
%%%%%%%%%%
%%%%%%%%%%
%. G6. . %
%.3.4. . %
%.1S0. . %
%. .5. . %
%o2. . . %
%%%%%%%%%%

rows(5).
cols(4).
numsteps(6).
start(2,3).
goal(2,1).
dot(1,5).

%*
Answer: 1
step(2,3,0) step(1,3,1) step(1,5,2) step(4,5,3) step(4,4,4) step(2,4,5) step(2,1,6)
Answer: 2
step(2,3,0) step(1,3,1) step(1,5,2) step(1,2,3) step(2,2,4) step(2,4,5) step(2,1,6)
*%
