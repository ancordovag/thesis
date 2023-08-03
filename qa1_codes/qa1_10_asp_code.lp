% Define the constants in the object category.
object("A"; "Z"; "H"; "E"; "M").
% For each object O1, it can have a relation with any other object O2.
{relation(O1, O2): object(O2)} :- object(O1).
% No option in any category will ever be used more than once.
{O1=O2}=0 :- relation(O1,O2), O1!=O2.