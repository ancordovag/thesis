% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% If a cell is not black, it should be white
white(X,Y) :- not black(X,Y), cell(X,Y).
% If a cell is not white, it should be black
black(X,Y) :- not white(X,Y), cell(X,Y).

% Find the minimum column containing a white cell 
mini_x(M) :- M = #min{X,Y : white(X,Y)}.
% Find the minimum row containing a white cell in the minimum column containing a white cell
mini_y(N) :- N = #min{Y : white(M,Y), mini_x(M)}.
% Declare the first visit as the minimum column and minimum row
first_visit(M,N) :- mini_x(M), mini_y(N).
% Declare a cell as visited if there is an incoming path from the first visited cell
visit(X+DX,Y+DY) :- first_visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Declare a cell as visited if there is an incoming path from a already visited cell
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).

% The possible aditions for a hint cell
plus(0,0). plus(0,1). plus(1,0). plus(1,1).

% Define minimum N and maximum N cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y, 
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).

% Define a path between 2 white cells when they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.

% The possible next movements of the player          
next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
next(X,Y,X,Y)   :- field(X,Y).
next(X,Y,XX,YY) :- next(XX,YY,X,Y).

% The player is at start position at timestep 0
at(X,Y,0) :- start(X,Y).

% The player chooses one position from the possible next movements if it is not at the goal cell
1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S.

% The minotaur's movements depending of the possible next movement of the player     
mino_step(X,Y,XX,YY,( 1, 0)) :- field(X,Y), field(XX,YY), X < XX, next(X,Y,X+1,Y).
mino_step(X,Y,XX,YY,(-1, 0)) :- field(X,Y), field(XX,YY), X > XX, next(X,Y,X-1,Y).
mino_step(X,Y,XX,YY,( 0, 1)) :- field(X,Y), field(XX,YY), Y < YY, next(X,Y,X,Y+1), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).
mino_step(X,Y,XX,YY,( 0,-1)) :- field(X,Y), field(XX,YY), Y > YY, next(X,Y,X,Y-1), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).
mino_step(X,Y,XX,YY,( 0, 0)) :- field(X,Y), field(XX,YY), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)), not mino_step(X,Y,XX,YY,( 0, 1)), not mino_step(X,Y,XX,YY,( 0,-1)).

% The minotaur's next position as the actual position plus the minotaur's movement
mino_next(X,Y,XX,YY,X+DX1+DX2,Y+DY1+DY2) :- mino_step(X,Y,XX,YY,(DX1,DY1)), mino_step(X+DX1,Y+DY1,XX,YY,(DX2,DY2)).

% The minotaur is at the minotaur's start position at timestep 0
mino(X,Y,0) :- mino(X,Y).

% The minotaur's next position depending on the actual position and the next position of the player
mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S, at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY).
% It cannot be that a white cell is not visited
:- not visit(X,Y), white(X,Y).

% The player and the minotaur can not be at the same cell at the same time        
:- at(X,Y,T), mino(X,Y,T).

% The goal is achieved when the player is at cell goal
goal :- at(X,Y,T), goal(X,Y).

% It can not be the case, that the goal is not achieved
:- not goal.

% Optimization: minimize the time T            
#minimize{ T : at(X,Y,T) }.

% Show the output predicate
#show at/3.

% The path starts at the cell marked with a white circle
start(X,Y) :- first(X,Y).

% The path ends at the cell marked with a black circle
end(X,Y) :- final(X,Y).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- path(X,Y,T), path(X,Y,T'), T != T'.

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
:- hint(X,Y,N), path(X,Y,T), path(X,Y,T'), T != T'+N.

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- first(X,Y), hint(X,Y,N), path(X,Y,T), T != N.

% Every problem instance contains exactly one fact over first/2 and one fact over final/2
1 { first(X,Y) } 1 :- cell(X,Y).
1 { final(X,Y) } 1 :- cell(X,Y).

% The cell (X,Y) belongs to the grid
cell(X,Y).

% The cell (X,Y) contains the hint number N
hint(X,Y,N).