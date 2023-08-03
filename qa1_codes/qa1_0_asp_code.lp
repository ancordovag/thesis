% Define the constants in each category.
agent("A"; "Q"; "H"; "K"; "X").
relation("bottom-right"; "right"; "left"; "same horizontal plane").

% Define the relations between agents.
{relation(R1, A, Q): relation(R1), agent(A), agent(Q)}=1.
{relation(R2, H, K): relation(R2), agent(H), agent(K)}=1.
{relation(R3, X, K): relation(R3), agent(X), agent(K)}=1.
% No option in any category will ever be used more than once.
{A1=A2; Q1=Q2; H1=H2; K1=K2; X1=X2; R1=R2; R1=R3; R2=R3}=0 :- relation(R1,A1,Q1), relation(R2,H1,K1), relation(R3,X1,K2), (A1,Q1,H1,K1,X1,R1,R2,R3)!=(A2,Q2,H2,K2,X2,R1,R2,R3).
% The relation between agent A and agent Q is "bottom-right".
R="bottom-right" :- relation(R,A,Q), A="A", Q="Q".
% The relation between agent H and agent K is "right".
R="right" :- relation(R,H,K), H="H", K="K".
% The relation between agent X and agent K is "same horizontal plane".
R="same horizontal plane" :- relation(R,X,K), X="X", K="K".