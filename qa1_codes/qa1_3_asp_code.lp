% Define the constants in the agent category.
agent("D"; "U"; "E"; "V"; "A").
% For each agent A1, it can have a relation with any other agent A2.
relation(A1, A2) :- agent(A1), agent(A2).
% Define the constants in the agent category.
agent("D"; "U"; "E"; "V"; "A").
% For each agent A1, it can have a relation with any other agent A2.
relation(A1, A2) :- agent(A1), agent(A2).