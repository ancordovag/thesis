hop = {"story":"hop",
      "problem":'''The goal of the puzzle is to find a path between predefined start and end points. The path consists of jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3, 1, 2, 3, and so on. The task is to determine the cells where it lands between these jumps. Some of these cells are already provided, but without a specific order.''',
       
      "Representation in ASP":'''%% INPUT
cols(C). % Number of columns
rows(R). % Number of rows
numsteps(N). % Number of steps necessary
start(X,Y). % Start cell
goal(X,Y). % Goal cell
dot(X,Y). % Predefined intermediate step 
%% OUTPUT
step(X,Y,T) % cell X,Y is visited in timestep T ''',
       
      "possible_rules":'''% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% possible jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3
jump(0,1). jump(0,2). jump(0,3). jump(0,-1). jump(0,-2). jump(0,-3).
jump(1,0). jump(2,0). jump(3,0). jump(-1,0). jump(-2,0). jump(-3,0).
 % The first step is at "start"
possible_step(X,Y,0) :- start(X,Y).
% The next possible step depends of the previous one, given that is in a cell
possible_step(X+A,Y+B,T) :-  possible_step(X,Y,T-1), cell(X+A,Y+B), jump(A,B), not numsteps(S).''',
      
      "Generation rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Possible jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3
jump(0,1). jump(0,2). jump(0,3). jump(0,-1). jump(0,-2). jump(0,-3).
jump(1,0). jump(2,0). jump(3,0). jump(-1,0). jump(-2,0). jump(-3,0).
 % The first step is at "start"
step(X,Y,0) :- start(X,Y).
% The next possible step depends of the previous one, given that is in a cell
{ step(X+A,Y+B,T+1) : jump(A,B) } :-  possible_step(X,Y,T), cell(X+A,Y+B), numsteps(S), T < S.'''

}