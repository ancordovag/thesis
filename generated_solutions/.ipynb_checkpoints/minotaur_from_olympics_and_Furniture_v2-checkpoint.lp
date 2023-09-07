% Define the constants in each category.
start_field("initial field").
goal_field("goal field").
% There is a relation between the start field S and the goal field G.
relation(S, G) :- start_field(S), goal_field(G).
% No option in any category will ever be used more than once.
{S1=S2; G1=G2}=0 :- relation(S1,G1), relation(S2,G2), (S1,G1)!=(S2,G2).
% The start field is not the same as the goal field.
S!=G :- relation(S,G).
% The start field is "initial field".
S="initial field" :- relation(S,G).
% The goal field is "goal field".
G="goal field" :- relation(S,G).