% Define the constants in each category.
agent("A"; "Q"; "H"; "K"; "X").
relation("bottom-right"; "right"; "left"; "same horizontal plane").

% Define the relations between agents.
relation(A, Q, "bottom-right") :- agent(A), agent(Q), A != Q.
relation(H, K, "right") :- agent(H), agent(K), H != K.
relation(X, K, "left") :- agent(X), agent(K), X != K.
relation(X, K, "same horizontal plane") :- agent(X), agent(K), X != K.
% Define the constants in each category.
agent("A"; "Q"; "H"; "K"; "X").
relation("bottom-right"; "right"; "left"; "same horizontal plane").

% Define the relations between agents.
relation(A, Q, "bottom-right") :- agent(A), agent(Q), A != Q.
relation(H, K, "right") :- agent(H), agent(K), H != K.
relation(X, K, "left") :- agent(X), agent(K), X != K.
relation(X, K, "same horizontal plane") :- agent(X), agent(K), X != K.