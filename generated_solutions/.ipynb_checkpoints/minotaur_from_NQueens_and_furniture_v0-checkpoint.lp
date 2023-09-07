% Define the constants in each category.
start_field("start field").
goal_field("goal field").
direction("up"; "down"; "left"; "right").
% For each start field S and goal field G, there is exactly 1 direction D.
{relation(S, G, D): direction(D)}=1 :- start_field(S), goal_field(G).
% The start field and goal field cannot be the same.
:- relation(S, G, D), S=G.
% The direction can only be "up", "down", "left", or "right".
:- relation(S, G, D), D!="up", D!="down", D!="left", D!="right".