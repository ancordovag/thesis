% Define the constants in each category.
category("cell"; "hint"; "black").
constant("X"; "Y"; "N").
% For each category C, there is exactly 1 constant V.
{relation(C, V): constant(V)}=1 :- category(C).
% All white cells must form an orthogonally connected area.
:- black(X1,Y1), black(X2,Y2), cell(X1,Y1), cell(X2,Y2), (X1!=X2; Y1!=Y2), not black(X,Y), cell(X,Y), (X1=X; Y1=Y; X2=X; Y2=Y).

% The number in a circle indicates how many adjacent cells must be blackened.
:- hint(X,Y,N), count_black(X,Y,C), C!=N.

% Count the number of adjacent black cells.
count_black(X,Y,C) :- black(X+1,Y), black(X,Y+1), black(X+1,Y+1), C=3.
count_black(X,Y,C) :- black(X+1,Y), black(X,Y+1), not black(X+1,Y+1), C=2.
count_black(X,Y,C) :- black(X+1,Y), not black(X,Y+1), black(X+1,Y+1), C=2.
count_black(X,Y,C) :- not black(X+1,Y), black(X,Y+1), black(X+1,Y+1), C=2.
count_black(X,Y,C) :- black(X+1,Y), not black(X,Y+1), not black(X+1,Y+1), C=1.
count_black(X,Y,C) :- not black(X+1,Y), black(X,Y+1), not black(X+1,Y+1), C=1.
count_black(X,Y,C) :- not black(X+1,Y), not black(X,Y+1), black(X+1,Y+1), C=1.
count_black(X,Y,C) :- not black(X+1,Y), not black(X,Y+1), not black(X+1,Y+1), C=0.