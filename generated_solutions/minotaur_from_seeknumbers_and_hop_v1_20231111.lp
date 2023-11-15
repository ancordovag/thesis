                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% start at "start" for player and minotaur
player(X,Y,0) :- start(X,Y).
minotaur(X,Y,0) :- start(X,Y).
% possible movements
move(0,1). move(0,-1). move(1,0). move(-1,0).
% player moves
1 {player(X+A,Y+B,T+1) : move(A,B), cell(X+A,Y+B)} 1 :- player(X,Y,T), not numsteps(T).
% minotaur moves
1 {minotaur(X+A,Y+B,T+1) : move(A,B), cell(X+A,Y+B)} 1 :- minotaur(X,Y,T), not numsteps(T).
% no wall crossing
:- player(X,Y,T), wall(X,Y).
:- minotaur(X,Y,T), wall(X,Y).
% no collision
:- player(X,Y,T), minotaur(X,Y,T).
% goal reached
reached :- player(X,Y,T), goal(X,Y).
% show output
#show player/3.
#show minotaur/3.
% The player and the Minotaur cannot be at the same position at the same time
:- player(X,Y,T), minotaur(X,Y,T).
% The player and the Minotaur cannot move to a position where there is a wall
:- player(X,Y,T), wall(X,Y).
:- minotaur(X,Y,T), wall(X,Y).
% The player must start at the start field and the Minotaur must start at the goal field
:- not player(X,Y,0), start(X,Y).
:- not minotaur(XX,YY,0), goal(XX,YY).
% The player must reach the goal field and the Minotaur must reach the start field
:- not player(XX,YY,T), goal(XX,YY).
:- not minotaur(X,Y,T), start(X,Y).
% The player and the Minotaur can only move to an adjacent position (up, down, left, right)
:- player(X,Y,T), not player(X+1,Y,T+1), not player(X-1,Y,T+1), not player(X,Y+1,T+1), not player(X,Y-1,T+1).
:- minotaur(X,Y,T), not minotaur(X+1,Y,T+1), not minotaur(X-1,Y,T+1), not minotaur(X,Y+1,T+1), not minotaur(X,Y-1,T+1).
% The player and the Minotaur cannot move to a position they have already visited
:- player(X,Y,T), player(X,Y,TT), T != TT.
:- minotaur(X,Y,T), minotaur(X,Y,TT), T != TT.