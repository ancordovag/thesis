% Define the constants in each category.
position("Minotaur"; "Player").
movement("Up"; "Down"; "Left"; "Right").
% For each position P, it is assigned with exactly 1 movement M.
{assign(P, M): movement(M)}=1 :- position(P).
% No option in any category will ever be used more than once.
{P1=P2; M1=M2}=0 :- position(P1), position(P2), movement(M1), movement(M2), (P1,M1)!=(P2,M2).