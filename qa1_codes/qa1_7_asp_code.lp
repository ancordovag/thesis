% Define the constants in the agent category.
agent("S"; "P"; "W"; "H"; "F").
% For each agent A1, it can have a relation with any other agent A2.
relation(A1, A2) :- agent(A1), agent(A2), A1 != A2.
% No option in any category will ever be used more than once.
{A1=A2}=0 :- relation(A1,A2), A1!=A2.