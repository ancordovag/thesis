lights = {"story":"lights",
         "problem":'''The puzzle involves illuminating a two-dimensional grid with lights. The grid is square, and some cells are given as initial conditions. These given cells are either empty or contain a whole number between 0 and 4.

The objective of the puzzle is to place lights on the cells that are not initially given, ensuring that each non-given cell is horizontally or vertically illuminated by (at least) one light. Light rays must not pass through given cells (either empty or containing a number). Additional constraints include that no two lights should illuminate each other, and for each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light.''',
          "Short Problem":'''There is a square grid. Some cells are given as initial conditions, either empty or containing a whole number between 0 and 4. The objective of the puzzle is to place lights on the cells that are not initially given. For each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light.''',
          "Representation in ASP":'''%% INPUT
rows(R). % Number of rows
cols(C). % Number of columns
digit(X,Y,D). % Digit D at position (X,Y), i.e., in row X and column Y
empty(X,Y). % Empty cell at position (X,Y), i.e., in row X and column Y
%% OUTPUT
light(X,Y) % light placed in cell X,Y''',
          
          "constants":'''grid_size: 1; 2; ...; N;
initial_condition: 0; 1; 2; 3; 4. ''',
          
          "predicates":'''% Predicate representing the placement of lights: light/2. The cell at the coordinates (X,Y) has a light
light(X,Y)

% Predicate representing the initial conditions: initial/3. The cell at the coordinates (X,Y) has an initial condition of N
digit(X,Y,N) ''',

          "rules":'''% Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate digit/2 from digit/3 that only shows the position of the digit N
digit(X,Y) :- digit(X,Y,N).
% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not digits are defined as reach, to indicate that one field is reachable from the other one.
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

% Generate minimum 0 predicate light for field(X,Y) if this is not a digit.  
{ light(X,Y) } :- field(X,Y), not digit(X,Y).

% Mark a field as lighted
lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY). ''',

          "constraints":'''
% Cannnot be the case that a field with a light is not lighted
:- light(X,Y), lighted(X,Y).
% Cannot be the case that a field is not digit and is not lighted
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
% A field with a difit N must have exactly N neighbors that are light
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

% Show output predicate
#show light/2. ''',
          
          "encoding":'''% Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate digit/2 from digit/3 that only shows the position of the digit N
digit(X,Y) :- digit(X,Y,N).
% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not digits are defined as reach, to indicate that one field is reachable from the other one.
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

% Generate minimum 0 predicate light for field(X,Y) if this is not a digit.  
{ light(X,Y) } :- field(X,Y), not digit(X,Y).

% Mark a field as lighted
lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

% Cannnot be the case that a field with a light is not lighted
:- light(X,Y), lighted(X,Y).
% Cannot be the case that a field is not digit and is not lighted
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
% A field with a difit N must have exactly N neighbors that are light
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

% Show output predicate
#show light/2.''',

          "lines":'''% Given a number R of rows "rows(R)", and C columns "cols(C)", define "fields" as the combination of a row X and a column Y if this combination X,Y is not "empty" 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate digit/2 from digit/3 that only shows the position (first 2 variables) of the digit
digit(X,Y) :- digit(X,Y,N).
% Define the four possible distances from a field, as "delta" with 2 variables, showing a difference of 1 field with respect to (0,0)
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define "neighbor" of 6 variables for 2 fields if there is a "delta" distance between them TODO
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not "digit" are defined as "reach" TODO
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction, have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

% Generate between 0 and 1 atoms of predicate "light" for field(X,Y) if this is not a digit. TODO
{ light(X,Y) } :- field(X,Y), not digit(X,Y).

% Mark a field as "lighted" for a position if there is a relation of "reach" between a position of "light" and that position
lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

% Cannnot be the case that a field with a light is not lighted
:- light(X,Y), lighted(X,Y).
% Cannot be the case that a field is not digit and is not lighted
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
% A field with a digit N must have exactly N neighbors that are light
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

% Show output predicate "light"
#show light/2.''',

           "normal_rules":'''% Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate digit/2 from digit/3 that only shows the position of the digit N
digit(X,Y) :- digit(X,Y,N).
% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not digits are defined as reach, to indicate that one field is reachable from the other one.
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3). 
light(X,Y) :- field(X,Y), not digit(X,Y).
% Mark a field as lighted
lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).''',

          "integrity_constraints":'''% Cannnot be the case that a field with a light is not lighted
:- light(X,Y), lighted(X,Y).
% Cannot be the case that a field is not digit and is not lighted
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
% A field with a difit N must have exactly N neighbors that are light
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N. ''',
          
         "possible_rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Possible lights could be set in cells that are not declared empty
possible_light(X,Y) :- cell(X,Y), not empty(X,Y).''',

        "Generation rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R). 
{ light(X,Y) } :- field(X,Y), not digit(X,Y).
% Show output predicate
#show light/2.'''
         }