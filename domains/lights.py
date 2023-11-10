lights = {"story":"lights",
         "problem":'''The puzzle involves illuminating a two-dimensional grid with lights. The grid is square, and some cells are given as initial conditions. These given cells are either empty or contain a whole number between 0 and 4.

The objective of the puzzle is to place lights on the cells that are not initially given, ensuring that each non-given cell is horizontally or vertically illuminated by (at least) one light. Light rays must not pass through given cells (either empty or containing a number). Additional constraints include that no two lights should illuminate each other, and for each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light.''',
          "Representation in ASP":'''%% INPUT
rows(R). % Number of rows
cols(C). % Number of columns
digit(X,Y,D). % Digit D at position (X,Y), i.e., in row X and column Y
empty(X,Y). % Empty cell at position (X,Y), i.e., in row X and column Y
%% OUTPUT
light(X,Y) % light placed in cell X,Y''',
         "encoding":'''field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
digit(X,Y) :- digit(X,Y,N).

delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

{ light(X,Y) } :- field(X,Y), not digit(X,Y).

lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

:- light(X,Y), lighted(X,Y).
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.
#show light/2.''',
          
         "possible_rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Possible lights could be set in cells that are not declared empty
possible_light(X,Y) :- cell(X,Y), not empty(X,Y).''',

        "Generation rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R). 
{ light(X,Y) } :- field(X,Y), not digit(X,Y).'''
         }