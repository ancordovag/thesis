% Define the constants in each category.
position("6:00"; "6 o'clock").
agent("A"; "D"; "G"; "R").
relation("over there"; "directly below").
% For each agent G, it has a relation with exactly 1 agent R.
{relation(G, R): agent(R)}=1 :- agent(G).
% No option in any category will ever be used more than once.
{P1=P2; A1=A2; R1=R2}=0 :- relation(A1,R1), relation(A2,R2), (P1,A1,R1)!=(P2,A2,R2).
% The agent at 6 o'clock is directly below agent D.
R="directly below" :- relation("D",R), P="6 o'clock".
% Agent G is over there.
R="over there" :- relation("G",R).