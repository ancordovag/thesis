                    % Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% Possible moves for player and Minotaur
move(0,1). move(0,-1). move(1,0). move(-1,0).

% The first step is at "start" for player and at "minotaur" for Minotaur
step(X,Y,0) :- start(X,Y).
minotaur(MX,MY,0) :- minotaur(MX,MY).

% The next possible step for player depends on the previous one, given that is in a cell and not in the same cell as Minotaur
step(X+A,Y+B,T) :-  step(X,Y,T-1), cell(X+A,Y+B), move(A,B), not minotaur(MX,MY,T-1), not (MX=X+A, MY=Y+B).

% The next possible step for Minotaur depends on the previous one, given that is in a cell and not in the same cell as player
minotaur(MX+A,MY+B,T) :-  minotaur(MX,MY,T-1), cell(MX+A,MY+B), move(A,B), not step(X,Y,T-1), not (MX+A=X, MY+B=Y).

% If Minotaur cannot move closer to player horizontally, he will try to move vertically
minotaur(MX,MY+A,T) :-  minotaur(MX,MY,T-1), cell(MX,MY+A), move(0,A), not step(X,Y,T-1), not (MX=X, MY+A=Y), not can_move_horizontally(MX,MY,X,Y).

% If Minotaur cannot move closer to player vertically, he will not move
minotaur(MX,MY,T) :-  minotaur(MX,MY,T-1), not step(X,Y,T-1), not can_move_vertically(MX,MY,X,Y).

% Check if Minotaur can move closer to player horizontally
can_move_horizontally(MX,MY,X,Y) :- MX<X, cell(MX+1,MY), not wall(MX+1,MY).
can_move_horizontally(MX,MY,X,Y) :- MX>X, cell(MX-1,MY), not wall(MX-1,MY).

% Check if Minotaur can move closer to player vertically
can_move_vertically(MX,MY,X,Y) :- MY<Y, cell(MX,MY+1), not wall(MX,MY+1).
can_move_vertically(MX,MY,X,Y) :- MY>Y, cell(MX,MY-1), not wall(MX,MY-1).                    % Player and Minotaur cannot be in the same cell
:- step(X,Y,T), minotaur(X,Y,T).
% Player and Minotaur cannot move through walls
:- step(X,Y,T), wall(X,Y).
:- minotaur(X,Y,T), wall(X,Y).
% Player must reach the goal
:- not step(X,Y,T), goal(X,Y).
% Minotaur cannot reach the goal
:- minotaur(X,Y,T), goal(X,Y).
% Player cannot move more than one cell per step
:- step(X,Y,T-1), step(P,Q,T), |P-X|+|Q-Y| > 1.
% Minotaur cannot move more than two cells per step
:- minotaur(MX,MY,T-1), minotaur(P,Q,T), |P-MX|+|Q-MY| > 2.
% Player cannot stay in the same cell if Minotaur is one cell away
:- step(X,Y,T-1), step(X,Y,T), minotaur(MX,MY,T-1), (|MX-X|+|MY-Y| = 1).
% Minotaur cannot stay in the same cell if player is one cell away
:- minotaur(MX,MY,T-1), minotaur(MX,MY,T), step(X,Y,T-1), (|MX-X|+|MY-Y| = 1).