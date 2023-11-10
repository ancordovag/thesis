% Define the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves from a cell in a given direction
move(X,Y,DX,DY,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% Define the possible moves from a cell in any direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% Define the possible moves from a cell in any direction until a gray area is reached
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction or a move is already made in the opposite direction of the opposite direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction or a move is already made in the opposite direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction or a move is already made in the opposite direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction or a move is already made in the opposite direction of the same direction of the opposite direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY,DX,DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction or a move is already made in the opposite direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction or a move is already made in the opposite direction of the same direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction of the opposite direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY,-DX,-DY).

% Define the possible moves from a cell in any direction until a gray area is reached or a number is reached or a goal is reached or a move is already made or a move is already made in the opposite direction or a move is already made in the same direction or a move is already made in the opposite direction of the same direction or a move is already made in the same direction of the opposite direction or a move is already made in the opposite direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction or a move is already made in the opposite direction of the same direction of the opposite direction or a move is already made in the same direction of the opposite direction of the same direction of the opposite direction or a move is already made in the opposite direction of the same direction of the opposite direction of the same direction
move(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not gray(X+DX,Y+DY), not number(X+DX,Y+DY), not goal(X+DX,Y+DY), not move(X+DX,Y+DY), not move(X+DX,Y+DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,-DX,-DY,DX,DY,-DX,-DY,DX,DY), not move(X+DX,Y+DY,DX,DY,-DX,-DY,DX,DY,-DX,-DY