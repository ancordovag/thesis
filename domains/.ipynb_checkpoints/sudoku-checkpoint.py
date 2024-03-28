sudoku = {"story":"sudoku",
          "problem":'''The goal of the game is to fill a 9x9 grid with digits so that each column, each row and each of the nine 3x3 sub-grids that compose the grid contains all numbers from 1 to 9, so that the same number does not appear twice in the same row, column or in any of the nine 3x3 sub-grids of the 9x9 playing board. Initially the grid is partially filled.''',
          "Short Problem":'''The goal of the game is to fill a 9x9 grid with digits from 1 to 9. Initially the grid is partially filled.''',
          "Representation in ASP":'''%% INPUT
          initial(X,Y,N). % initially cell (X,Y) contains number N
          %% OUTPUT 
          sudoku(X,Y,V). % match of a cell and a value''',
          "constants":'''index_of_row: 1; 2; 3; 4; 5; 6; 7; 8; 9.
                   index_of_column: 1; 2; 3; 4; 5; 6; 7; 8; 9.
                   digits: 1; 2; 3; 4; 5; 6; 7; 8; 9.''',
          "predicates":'''% There should be a match between index of row, index of column and digit. 
                  match(Ir,Ic,D)''',
          "rules":'''% The size of the subgrid is defined
                  subgrid_size(3).
                  % The possible digits are from 1 to S times S, being S the size of the subgrid
                  dim(1..S*S) :- subgrid_size(S).
                  % The identifier of the subgrid goes from 0 to the possible digits minus 1
                  subgrid(D-1) :- dim(D).
                  % A map is defined between X and Y, indicating the number of subgrid in which they belong
                  map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).
                  % A predicate that indicates which cell has a value in the beginning
                  init(X,Y) :- initial(X,Y,N).
                  % the initial value of each cell in another predicate poss
                  poss(X,Y,N) :- initial(X,Y,N).
                  % Generation of all possible digits for the cells that were not initialized 
                  poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).
                  % Show the goal predicate
                  #show sudoku/3.''',
          "constraints":'''% It cannot be the case that a initial value is not a sudoku
                  :- initial(X,Y,N), not sudoku(X,Y,N). 
                  % For each cell, choose only one possibility of digit 
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
                  % For each column and digit, choose only one possibility of row 
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
                  % For each row and digit, choose only one possibility of column
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
                  % For each digit and subgrid, choose only one possibility for each subgrid identifier in map
                  1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).''',
           "normal_rules":'''% Initial parameters
                        #const s=3.
                        subgrid_size(s).
                        value(1..s*s).
                        row(1..s*s).
                        column(1..s*s).

                        % A cell is the interseccion between a row and a column
                        cell(X,Y) :- row(X), column(Y). 

                        % Each cell (X,Y) is mapped to an identificator number S of the subgrid it belongs 
                        map(X,Y,S) :- cell(X,Y), S=(((X-1)/s)*s + (Y-1)/s).
                        
                        % The combination of a cell and a value is a possible sudoku
                        sudoku(X,Y,V) :- cell(X,Y), value(V).''',
          "integrity_constraints":'''% It is not possible that an initial value for a cell is not in the sudoku
            :- initial(X,Y,V), not sudoku(X,Y,V).
            
            % There can not be 2 values in the same cell
            :- sudoku(X,Y,V), sudoku(X,Y,Z), V!=Z.
            
            % There should be no repetition in the column
            :- sudoku(X,Y,V), sudoku(X,Y',V), Y!=Y'.
            
            % There should be no repetition in the row
            :- sudoku(X,Y,V), sudoku(X',Y,V), X!=X'.
            
            % There should be no repetition in the subgrid
            :- sudoku(X,Y,V), sudoku(X',Y',V), X'!=X, Y != Y', cell(X,Y), cell(X',Y'), map(X,Y,S), map(X',Y',S). ''',
          
          "possible_rules":'''% Initial parameters
            value(1..9).
            row(1..9).
            column(1..9).
          
            % A cell is the interseccion between a row and a column
            cell(X,Y) :- row(X), column(Y). 
            
            % The combination of a cell and a value is a possible sudoku
            possible_sudoku(X,Y,V) :- cell(X,Y), value(V).''',

          "Generation rules":'''% Initial parameters
            value(1..9).
            row(1..9).
            column(1..9). 
            cell(X,Y) :- row(X), column(Y).
            sudoku(X,Y,Z) :- initial(X,Y,Z).
            1 { sudoku(X,Y,V) : value(V) } 1 :- cell(X,Y).
            % Show output predicate
            #show sudoku/3.''',
          
            "encoding":'''% The size of the subgrid is defined
subgrid_size(3).

% The possible digits are from 1 to S times S, being S the size of the subgrid
dim(1..S*S) :- subgrid_size(S).

% The identifier of the subgrid goes from 0 to the possible digits minus 1
subgrid(D-1) :- dim(D).

% A map is defined between X and Y, indicating the number of subgrid in which they belong
map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).

% A predicate that indicates which cell has a value in the beginning
init(X,Y) :- initial(X,Y,N).

% the initial value of each cell in another predicate poss
poss(X,Y,N) :- initial(X,Y,N).
% Generation of all possible digits for the cells that were not initialized 
poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).

% For each cell, choose only one possibility of digit 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
% For each column and digit, choose only one possibility of row 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
% For each row and digit, choose only one possibility of column
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
% For each digit and subgrid, choose only one possibility for each subgrid identifier in map
1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).

% It cannot be the case that a initial value in cell (X,Y) is not the same as sudoku in cell (X,Y)
:- initial(X,Y,N), not sudoku(X,Y,N).

% Show output predicate
#show sudoku/3.''',

          "lines":'''% The size of the subgrid is defined
subgrid_size(3).

% The possible digits are from 1 to S times S, being S the size of the subgrid
dim(1..S*S) :- subgrid_size(S).

% The identifier of the subgrid goes from 0 to the possible digits minus 1
subgrid(D-1) :- dim(D).

% A map is defined between X and Y, indicating the number of subgrid in which they belong
map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).

% A predicate that indicates which cell has a value in the beginning
init(X,Y) :- initial(X,Y,N).

% the initial value of each cell in another predicate poss
poss(X,Y,N) :- initial(X,Y,N).
% Generation of all possible digits for the cells that were not initialized 
poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).

% For each cell, choose only one possibility of digit 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
% For each column and digit, choose only one possibility of row 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
% For each row and digit, choose only one possibility of column
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
% For each digit and subgrid, choose only one possibility for each subgrid identifier in map
1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).

% It cannot be the case that a initial value in cell (X,Y) is not the same as sudoku in cell (X,Y)
:- initial(X,Y,N), not sudoku(X,Y,N).

% Show output predicate
#show sudoku/3.''',

          "lines_nlp":'''% The size of the subgrid is defined
subgrid_size(3).

% The size of the grid is defined from the size of the subgrid
dim(1..S*S) :- subgrid_size(S).

% The identifier for each subgrid is defined from the dimension of grid
subgrid(D-1) :- dim(D).

% A map between each cell and the subgrid in which they belong
map(X,Y,((X-1)/S)*S + (Y-1)/S) :- dim(X), dim(Y), subgrid_size(S).

% Storing the cells of the grid that have a given initial value
init(X,Y) :- initial(X,Y,N).

% The possible values for each cell, intialized with a duplicate of the given initial value
poss(X,Y,N) :- initial(X,Y,N).

% Generation of all possible digits for the cells that were not initialized 
poss(X,Y,D) :- dim(X), dim(Y), dim(D), not init(X,Y).

% Generate the output predicate choosing only one possibility of digit
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).

% Generate the output predicate choosing only one possibility of row 
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).

% Generate the output predicate choosing only one possibility of column
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).

% Generate the output predicate choosing only one possibility for each subgrid identifier in map
1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).

% It cannot be the case that a initial value is not the same as the value in the output predicate
:- initial(X,Y,N), not sudoku(X,Y,N).

% Show output predicate
#show sudoku/3.'''
         }
