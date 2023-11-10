% Define the neighbours of a cell X,Y
neighbour(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (XX = X+1 ; XX = X-1 ; YY = Y+1 ; YY = Y-1).
% Generate black cells based on the hint numbers
{ black(X,Y) } :- hint(X,Y,N), neighbour(X,Y,XX,YY), black(XX,YY), N > 0.