% The maximum number of black cells in a 2x2 square is 4
:- hint(X,Y,N), N > 4.

% The number of black cells in a 2x2 square is equal to the sum of black cells in the four corners
hint(X,Y,N) :- black(X,Y), black(X+1,Y), black(X,Y+1), black(X+1,Y+1), N=4.

% The number of black cells in a 2x2 square is equal to the sum of black cells in the two opposite corners
hint(X,Y,N) :- black(X,Y), black(X+1,Y+1), N=2.
hint(X,Y,N) :- black(X+1,Y), black(X,Y+1), N=2.

% The number of black cells in a 2x2 square is equal to the sum of black cells in the two adjacent corners
hint(X,Y,N) :- black(X,Y), black(X+1,Y), N=2.
hint(X,Y,N) :- black(X,Y), black(X,Y+1), N=2.
hint(X,Y,N) :- black(X+1,Y), black(X+1,Y+1), N=2.
hint(X,Y,N) :- black(X,Y+1), black(X+1,Y+1), N=2.

% The number of black cells in a 2x2 square is equal to the number of black cells in one corner
hint(X,Y,N) :- black(X,Y), N=1.
hint(X,Y,N) :- black(X+1,Y), N=1.
hint(X,Y,N) :- black(X,Y+1), N=1.
hint(X,Y,N) :- black(X+1,Y+1), N=1.

% The number of black cells in a 2x2 square is 0 if there are no black cells in the corners
hint(X,Y,N) :- not black(X,Y), not black(X+1,Y), not black(X,Y+1), not black(X+1,Y+1), N=0.
% At least one of the cells at coordinates (X,Y), (X+1,Y), (X,Y+1) and (X+1,Y+1) must be blackened
:- cell(X,Y), not black(X,Y), cell(X+1,Y), not black(X+1,Y), cell(X,Y+1), not black(X,Y+1), cell(X+1,Y+1), not black(X+1,Y+1).

% The number of blackened cells at coordinates (X,Y), (X+1,Y), (X,Y+1) and (X+1,Y+1) must be equal to N
:- hint(X,Y,N), #count{1, X1,Y1 : black(X1,Y1), (X1=X; X1=X+1), (Y1=Y; Y1=Y+1)} != N.

% Show output predicate
#show black/2.