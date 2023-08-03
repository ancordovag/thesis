% Define the constants in each category.
relation("parallel"; "on top of"; "placed in the left direction of"; "to the bottom-left of").
agent("Y"; "I"; "X"; "Q"; "T").
% For each agent A, it has a relation R.
{relation(A, R): relation(R)}=1 :- agent(A).
% No option in any category will ever be used more than once.
{A1=A2; R1=R2}=0 :- relation(A1,R1), relation(A2,R2), (A1,R1)!=(A2,R2).
% 1. Agent Y is placed in the left direction of agent I.
R="placed in the left direction of" :- relation("Y",R), relation("I",R).
% 2. Agent X is on top of agent Q.
R="on top of" :- relation("X",R), relation("Q",R).
% 3. Agent T is parallel to agent I.
R="parallel" :- relation("T",R), relation("I",R).
% 4. Agent Q is to the bottom-left of agent Y.
R="to the bottom-left of" :- relation("Q",R), relation("Y",R).