% Define the constants in each category.
cell((X,Y)) :- X=1..9, Y=1..9.
first((X,Y)) :- X=1..9, Y=1..9.
final((X,Y)) :- X=1..9, Y=1..9.
hint((X,Y,N)) :- X=1..9, Y=1..9, N=1..9.

% For each cell (X,Y), it can be either the first cell or the final cell.
{first((X,Y)), final((X,Y))} :- cell((X,Y)).

% For each cell (X,Y), if it is not the first cell or the final cell, it can be a hint cell.
{hint((X,Y,N))} :- cell((X,Y)), not first((X,Y)), not final((X,Y)), N=1..9.
% No option in any category will ever be used more than once.
{X1=X2; Y1=Y2}=0 :- cell(X1,Y1), cell(X2,Y2), (X1,Y1)!=(X2,Y2).
{X1=X2; Y1=Y2}=0 :- first(X1,Y1), first(X2,Y2), (X1,Y1)!=(X2,Y2).
{X1=X2; Y1=Y2}=0 :- final(X1,Y1), final(X2,Y2), (X1,Y1)!=(X2,Y2).
{X1=X2; Y1=Y2; N1=N2}=0 :- hint(X1,Y1,N1), hint(X2,Y2,N2), (X1,Y1,N1)!=(X2,Y2,N2).

% Constraints from the problem:
% 1. The first cell is (X,Y).
first(X,Y) :- cell(X,Y).

% 2. The final cell is (X,Y).
final(X,Y) :- cell(X,Y).

% 3. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 1.

% 4. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 2.

% 5. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 3.

% 6. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 4.

% 7. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 5.

% 8. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 6.

% 9. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 7.

% 10. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 8.

% 11. The hint at cell (X,Y) is N.
hint(X,Y,N) :- cell(X,Y), N is 9.