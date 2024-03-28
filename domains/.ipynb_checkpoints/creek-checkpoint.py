creek = {"story":"creek",
         
         "problem":'''The goal of the game is to blacken some cells of a rectangular grid so that the following conditions are met:
1. All white cells (non-blackened) must form an orthogonally connected area, i.e., it must be possible to get from any white cell to any other white cell by moving only horizontally and vertically (never diagonally!), and without having to cross a black cell.
2. A number in a circle indicates how many of the 4 adjacent cells must be blackened.''',
         "Representation in ASP":'''%% INPUT
cell(X,Y). % there is a cell with coordinates (X,Y)
hint(X,Y,N). % N of the (maximum four) cells at coordinates (X,Y), (X+1,Y), (X,Y+1) and (X+1,Y+1) must be blackened
%% OUTPUT
black(X,Y) % the cell at the coordinates (X,Y) is blackened ''',
         
         "constants": '''rows: 1; ..; R.
                         columns: 1; ..; C.''',
         
        "predicates":''' % Resulting Predicate representing blackened cells: black/2. The cell at the coordinates (X,Y) is blackened
            black(X,Y) ''',
         
        "rules": '''% The possible aditions for a hint cell: 0 or 1 for each axis
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define all possible directions (up, down, left, right) in terms of the two axis
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define minimum N and maximum N cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y, 
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).

% Define a path between 2 white cells when they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.

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
% Show output predicate black
#show black/2.''',
         
        "constraints": '''% It cannot be that a white cell is not visited
:- not visit(X,Y), white(X,Y).''',
         
         "normal_rules":'''% The possible aditions for a hint cell
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between 2 white cells when they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.
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
% Define cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y,
black(X+A,Y+B) :- cell(X+A,Y+B), plus(A,B), hint(X,Y,N).''',
         
         "integrity_constraints":'''% It cannot be that a white cell is not visited
:- not visit(X,Y), white(X,Y). ''',

         "possible_rules":'''% Any cell, in principle, could be black
possible_black(X,Y) :- cell(X,Y).''',

         "Generation rules":'''% The possible aditions for a hint(X,Y) to mark their adjacents: (X,Y), (X+1,Y), (X,Y+1) and (X+1,Y+1)
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define minimum N and maximum N cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y, 
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).
% Show output predicate black
#show black/2.''',   
         
        "encoding":'''% The possible additions for a hint cell: 0 or 1 for each axis
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define all possible directions (up, down, left, right) in terms of the two axis
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define minimum N and maximum N cells to be blackened among the subset of possible cells, when there is a hint in cell X,Y, 
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).

% Define a path between 2 white cells when they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.

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
% It cannot be that a white cell is not visited
:- not visit(X,Y), white(X,Y).
% Show output predicate
#show black/2.'''} 