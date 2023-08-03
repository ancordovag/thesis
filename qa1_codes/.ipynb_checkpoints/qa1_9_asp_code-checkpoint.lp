% Define the constants in each category.
object("M"; "V"; "T"; "W").
position("left"; "below and to the right"; "9:00").
% For each object O, it has exactly 1 position P.
{relation(O, P): position(P)}=1 :- object(O).
% No option in any category will ever be used more than once.
{O1=O2; P1=P2}=0 :- relation(O1,P1), relation(O2,P2), (O1,P1)!=(O2,P2).
% 1. M is to the left of V.
relation("M", "left") :- relation("V", P), P\="left".
% 2. T is below and to the right of W.
relation("T", "below and to the right") :- relation("W", P), P\="below and to the right".
% 3. V is at 9:00.
relation("V", "9:00").
% 4. W is not at 9:00.
relation("W", P) :- P\="9:00".