% Generate all possible combinations of blackened cells for each hint
1 { black(X,Y) : cell(X,Y) } 1 :- hint(X,Y,N).

% Generate a predicate to check if a cell is white
white(X,Y) :- cell(X,Y), not black(X,Y).

% Generate a predicate to check if a cell is connected to another white cell
connected(X,Y) :- white(X,Y), connected(X,Y,[]).

% Base case: a cell is connected to itself
connected(X,Y,Visited) :- white(X,Y), not member((X,Y), Visited).

% Recursive case: a cell is connected to another white cell if they are adjacent and the other cell is also connected
connected(X,Y,Visited) :- white(X,Y), neighbour(X,Y,XX,YY), not member((X,Y), Visited), connected(XX,YY,[(X,Y)|Visited]).

% Generate a predicate to check if a cell is blackened
blackened(X,Y) :- black(X,Y), blackened(X,Y,[]).

% Base case: a cell is blackened if it has a hint and all adjacent cells are blackened
blackened(X,Y,Visited) :- hint(X,Y,N), blackened(X,Y,N,Visited).

% Recursive case: a cell is blackened if it has a hint and all adjacent cells are blackened
blackened(X,Y,N,Visited) :- hint(X,Y,N), neighbour(X,Y,XX,YY), blackened(XX,YY), not member((XX,YY), Visited), blackened(X,Y,N,[(XX,YY)|Visited]).

% Generate a predicate to check if a cell is not blackened
not_blackened(X,Y) :- cell(X,Y), not blackened(X,Y).

% Show output predicate
#show cell/2.
% It cannot be the case that a cell is black and white at the same time
:- black(X,Y), white(X,Y).
% It cannot be the case that a cell is not black and not white at the same time
:- not black(X,Y), not white(X,Y), cell(X,Y).
% It cannot be the case that a cell is black and there is a hint in that cell
:- black(X,Y), hint(X,Y,_).
% It cannot be the case that a cell is white and there is no hint in that cell
:- white(X,Y), not hint(X,Y,_).
% It cannot be the case that a cell is white and there is a hint in that cell
:- white(X,Y), hint(X,Y,_), not black(X+A,Y+B), plus(A,B).
% It cannot be the case that a cell is black and there is no hint in that cell
:- black(X,Y), not hint(X,Y,_).
% It cannot be the case that a cell is visited and there is no incoming path to that cell
:- visit(X,Y), not path(X+DX,Y+DY,X,Y), dir(DX,DY).
% It cannot be the case that a cell is not visited and there is an incoming path to that cell
:- not visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY).
% It cannot be the case that a cell is visited and there is an incoming path from a black cell
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), black(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is not adjacent
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), not cell(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is not white
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), not white(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is black
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), black(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is not visited
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), not visit(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not adjacent
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), not path(X,Y,X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not white
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), not white(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but black
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), black(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not visited
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), not visit(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not adjacent
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), path(X,Y,X+DX,Y+DY), not dir(DX,DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not white
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), path(X,Y,X+DX,Y+DY), not white(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but black
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), path(X,Y,X+DX,Y+DY), black(X+DX,Y+DY).
% It cannot be the case that a cell is visited and there is an incoming path from a cell that is visited but not visited
:- visit(X,Y), path(X+DX,Y+DY,X,Y), dir(DX,DY), cell(X+DX,Y+DY), visit(X+DX,Y+DY), path(X,Y,X+DX,Y+DY), not visit(X+DX,Y+DY).