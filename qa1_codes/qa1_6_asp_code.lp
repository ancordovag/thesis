% Define the constants in each category.
agent("P"; "N").
position("right"; "above"; "12:00").
% For each agent A, it has a relation with exactly 1 position B.
{relation(A, B): position(B)}=1 :- agent(A).
% No option in any category will ever be used more than once.
{A1=A2; B1=B2}=0 :- relation(A1,B1), relation(A2,B2), (A1,B1)!=(A2,B2).
% 1. The agent "P" is positioned to the right.
B="right" :- relation(A,B), A="P".
% 2. The agent "N" is positioned above.
B="above" :- relation(A,B), A="N".
% 3. The agent "P" is not positioned at 12:00.
B!="12:00" :- relation(A,B), A="P".