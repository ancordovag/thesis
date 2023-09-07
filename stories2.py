nqueens = {"story" : "NQueens",
             "problem" :  """Consider N-Queens Puzzle on a chessboard of size 8x8. The goal is to assign 8 queens on the chessboard 
                            so that no two queens can share the same row, column, or diagonal.""",
             "constants" : """ index_of_row: 1; 2; 3; 4; 5; 6; 7; 8.
                   index_of_column: 1; 2; 3; 4; 5; 6; 7; 8.
               """,
             "predicates" : """
                % The categories in Constants include index_of_row and index_of_column. We use different variables Ir and Ic to represent index_of_row and index_of_column.
                % We assign a queen at row Ir and column Ic, where Ir belongs to index_of_row and Ic belongs to index_of_column.
                assign(Ir, Ic)""",
             "rules":'''% Define the constants in each category.
                number(1; 2; 3; 4; 5; 6; 7; 8).
                % For each row N1, there is exactly 1 queen assigned at some column N2.
                {assign(N1, N2): number(N2)}=1 :- number(N1).'''
            }

furniture = {"story" : "furniture",
            "problem" : """ 
            "Against the Grain" offers hand-made wooden furniture at reasonable prices. Each item is made by an in-house employee. Using only the clues that follow, match each item to the employee who
            crafted it, and determine its price and the type of wood used to make it. Remember, as with all grid-based logic puzzles, no option in any category will ever be used more than once.
            1. Bonita’s piece costs $325. 
            2. The item made of poplar costs more than Yvette’s piece.
            3. Tabitha’s item costs 50 dollars less than the piece made of sandalwood.
            4. The $275 item is either the piece made of ash or Yvette’s item.
            """,
              "constants" : """ employee: "Bonita"; "Yvette"; "Tabitha".
                    price: 225; 275; 325.
                    wood_type: "ash"; "poplar"; "sandalwood".    
                """,
             "predicates" : """
                    % The categories in Constants include employee, price, and wood_type. We use different variables E, P, and W to represent employee, price, and wood_type.
                    % We match an employee E with price P and wood type W, where E belongs to employee, P belongs to price, and W belongs to wood_type.
                    match(E, P, W)
                    """,
             "rules" : """
                       % Define the constants in each category.
                       employee("Bonita"; "Yvette"; "Tabitha").
                       price(225; 275; 325).
                       wood_type("ash"; "poplar"; "sandalwood").
                       % For each employee E, it matches with exactly 1 price P and 1 wood type W.
                       {match(E, P, W): price(P), wood_type(W)}=1 :- employee(E).
                       """,
             "constraints" : """
                        % No option in any category will ever be used more than once.
                        {E1=E2; P1=P2; W1=W2}=0 :- match(E1,P1,W1), match(E2,P2,W2), (E1,P1,W1)!=(E2,P2,W2).
                        % 1. Bonita’s piece costs $325. 
                        P=325 :- match(E,P,W), E="Bonita".
                        % 2. The item made of poplar costs more than Yvette’s piece.
                        P1>P2 :- match(E1,P1,W1), match(E2,P2,W2), W1="poplar", E2="Yvette".
                        % 3. Tabitha’s item costs 50 dollars less than the piece made of sandalwood.
                        P1=P2-50 :- match(E1,P1,W1), match(E2,P2,W2), E1="Tabitha", W2="sandalwood".
                        % 4. The $275 item is either the piece made of ash or Yvette’s item.
                        {W="ash"; E="Yvette"}=1 :- match(E,P,W), P=275.
                        """
        }
jobs = {"story" : "jobs",
             "problem" :"""
                        1. There are four people: Roberta, Thelma, Steve, and Pete.
                        2. Among them, they hold eight different jobs.
                        3. Each holds exactly two jobs.
                        4. The jobs are: chef, guard, nurse, telephone operator, police officer (gender not implied), teacher, actor, and boxer.
                        5. The job of nurse is held by a male.
                        6. The husband of the chef is the telephone operator.
                        7. Roberta is not a boxer.
                        8. Pete has no education past the ninth grade.
                        9. Roberta, the chef, and the police officer went golfing together.""",
                "constants":'''person: "Roberta"; "Thelma"; "Steve"; "Pete".
                job: "chef"; "guard"; "nurse"; "telephone operator"; "police officer"; "teacher"; "actor"; "boxer".''',
                "predicates":'''% The categories in Constants include person, job, gender, and education. We use different variables P, J, G, and E to represent person, job, gender, and education.
                        % We assign a person P to job J, with gender G and education E, where P belongs to person, J belongs to job, G belongs to gender, and E belongs to education.
                        assign(P, J, G, E)'''
            }

olympics = {"story":"olympics",
            "problem":'''The Winter Olympics have just wrapped up in Norway. Using only the clues that follow,
                determine the number of gold, silver and bronze medals won by each country. Remember,
                as with all grid-based logic puzzles, no option in any category will ever be used more than once.
                1. The four teams are the team from Bolivia, the team that won 3 gold medals, the team that won 6 silver medals, and the team from Argentina.
                2. The team from Oman and the team that won 10 silver medals are different.
                3. The team from Oman finished with 2 gold medals or finished with 1 gold medal.
                5. The squad that won 3 gold medals, the squad that won 6 silver medals and the squad from Bolivia were all different teams.
                6. Neither the team from Argentina nor the squad that won 2 silver medals is the squad that won 4 gold medals.
                8. The squad that won 2 gold medals is either the squad that won 6 silver medals or the team from Grenada.''',
            "constants":'''country: "Argentina"; "Bolivia"; "Grenada"; "Oman".
                silver_medals: 2; 6; 10; 11.
                gold_medals: 1; 2; 3; 4.''',
            "predicates":'''% The categories include country, silver_medals, and gold_medals. We use different variables C, S, and G to represent country, silver_medals, and gold_medals.
                % We assign a country C with silver medals S and gold medals G, where C belongs to country, S belongs to silver_medals, and G belongs to gold_medals.
                assign(C, S, G) ''',
            "rules":'''% Define the constants in each category.
                country("Argentina"; "Bolivia"; "Grenada"; "Oman").
                silver_medals(2; 6; 10; 11).
                gold_medals(1; 2; 3; 4).
                % For each country C, it is assigned with exactly 1 silver medals S and 1 gold medals G.
                {assign(C, S, G): silver_medals(S), gold_medals(G)}=1 :- country(C).''',
            "constraints":'''% No option in any category will ever be used more than once.
                {C1=C2; S1=S2; G1=G2}=0 :- assign(C1,S1,G1), assign(C2,S2,G2), (C1,S1,G1)!=(C2,S2,G2).
                % 1. The four teams are the team from Bolivia, the team that won 3 gold medals, the team that won 6 silver medals, and the team from Argentina.
                {C="Bolivia"; G=3; S=6; C="Argentina"}=1 :- assign(C,S,G).
                % 2. The team from Oman and the team that won 10 silver medals are different.
                C1!=C2 :- assign(C1,S1,G1), assign(C2,S2,G2), C1="Oman", S2=10.
                % 3. The team from Oman finished with 2 gold medals or finished with 1 gold medal.
                {G=2; G=1}=1 :- assign(C,S,G), C="Oman".'''    
}

sudoku = {"story":"sudoku",
          "problem":'''The task of this project is to solve a Sudoku puzzle using ASP. The goal of the game is to fill a 9x9 grid with digits so that each column, each row and each of the nine 3x3 sub-grids that compose the grid contains all numbers from 1 to 9. In other words, the grid has to be filled with numbers from 1 to 9 so that the same number does not appear twice in the same row, column or in any of the nine 3x3 sub-grids of the 9x9 playing board. Initially the grid is partially filled.
          Instance: initial(1,1,5). initial(1,2,3). initial(1,5,7). initial(2,1,6). initial(2,4,1). initial(2,5,9). initial(2,6,5). initial(3,2,9). initial(3,3,8). initial(3,8,6). initial(4,1,8). initial(4,5,6). initial(4,9,3). initial(5,1,4). initial(5,4,8). initial(5,6,3). initial(5,9,1). initial(6,1,7). initial(6,5,2). initial(6,9,6). initial(7,2,6). initial(7,7,2). initial(7,8,8). initial(8,4,4). initial(8,5,1). initial(8,6,9). initial(8,9,5). initial(9,5,8). initial(9,8,7). initial(9,9,9).''',
          "constants":'''index_of_row: 1; 2; 3; 4; 5; 6; 7; 8; 9.
                   index_of_column: 1; 2; 3; 4; 5; 6; 7; 8; 9.
                   digits: 1; 2; 3; 4; 5; 6; 7; 8; 9.''',
          "predicates":'''% There should be a match between index of row, index of column and digit. 
                  match(Ir,Ic,D)''',
          "input_predicates":'''% Those are the predicates you count with:
                  % The initial value V of cell in column X and row Y
                  initial(X,Y,V).''',
          "output_predicate":'''% Sudoku is a unique match of column X, row Y and a digit N
                  sudoku(X,Y,N).''',
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
          "constraints":''':- initial(X,Y,N), not sudoku(X,Y,N). 
                  % For each cell, choose only one possibility of digit 
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).
                  % For each column and digit, choose only one possibility of row 
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(N).
                  % For each row and digit, choose only one possibility of column
                  1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(Y), dim(N).
                  % For each digit and subgrid, choose only one possibility for each subgrid identifier in map
                  1 { sudoku(X,Y,N) : poss(X,Y,N), map(X,Y,S) } 1 :- dim(N), subgrid(S).''',
         }

seeknumbers = {"story":"seeknumbers",
               "problem":'''Given a square grid as shown on the left side, the goal is to construct a directed path by linking horizontally or vertically adjacent cells such that:
    - the path starts at the cell marked with a white circle and ends at the cell marked with a black circle,
    - the path traverses each remaining cell of the square grid without ever crossing or intersecting itself,
    - between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates, and
    - the path does not bend between the cell marked with a white circle and the first cell with a number.
    Instance: cell(1..3,1..3). first(1,1). final(3,3). hint(2,1,2). hint(2,2,2).''',
"constants":'''% A grid is composed by rows and columns.
rows: 1; 2; ...; R;
columns: 1; 2; ...; C;''',
"predicates":'''% Every cell cell(X,Y) should be traversed, that means visited
visited(X,Y)
% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY)''',
"input_predicates":'''% the cell (X,Y) belongs to the grid
cell(X,Y).
% the first cell of the path (marked with a white circle) is (X,Y)
first(X,Y).
% the final cell of the path (marked with a black circle) is (X,Y)
final(X,Y).
% the cell (X,Y) contains the hint number N.
hint(X,Y,N).''',
"output_predicate":'''% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY) ''',
"rules":'''% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhintand cell (XX,YY), and it is 0 in the cell (XX,YY) when 
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.
% Show output predicate
#show path/4.''',
               
    "constraints" : '''% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).
% it cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).
% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_).'''
}

minotaur = {"story":"minotaur",
            "problem":'''The task of this project is to solve the Minotaur puzzle using ASP. You are in a labyrinth and the goal of the game is to go from a start field to a goal field without being eaten by the Minotaur. The labyrinth has walls, and neither you nor the Minotaur can go through them. At every step you can stay in your current field, or move one field in any direction: up, down, left or right. The Minotaur is faster than you, but luckily he is a bit foolish. He can move two fields every step, but his movements are determined by his and our position: there is no choice for him. He will try to move right or left to become closer to you. If that is not possible, he will try to move up and down to become closer. If this is also not possible, the Minotaur will not move. In this way the Minotaur may move in a step first in one direction (e.g., up) and then in another direction (e.g., left). Typically, to solve a puzzle you have to trap the Minotaur between the walls of the labyrinth, so that you can run free to the goal.
            Instance: maxsteps(6). field(1..3,1..3). start(2,1). goal(3,2). mino(2,3). wall(2,1,2,2). wall(2,2,3,2). wall(2,2,2,3).''',
            "constants":'''rows: 1; 2; ...; R;
                        columns: 1; 2; ...; C; ''',
            "predicates":'''% the player is at field (X,Y) at step S 
                at(X,Y,S).''',
            "input_predicates":'''% In which cell (row and column) the player is at time T
                at(X,Y,T)
                % The position (row and column) of the minotaur at Time T
                mino(X,Y,T)''',
                "input_predicates":'''% the field (X,Y) belongs to the labyrinth
                field(X,Y).  
                % the start field is (X,Y)
                start(X,Y).         
                % the goal  field is (X,Y)
                goal(X,Y).
                % the Minotaur starts at (X,Y)
                mino(X,Y).
                % there is a wall between (X,Y) and (XX,YY)
                wall(X,Y,XX,YY).    
                % there are at most S steps to reach the goal
                maxsteps(S).''',
            "output_predicate":'''% the player is at field (X,Y) at step S 
                at(X,Y,S).''',
            "rules":'''% The possible next movements of the player          
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
            % Show the output predicate
            #show at/3.
            ''',
            
            "constraints":'''% The player and the minotaur can not be at the same cell at the same time        
            :- at(X,Y,T), mino(X,Y,T).
            % The goal is achieved when the player is at cell goal
            goal :- at(X,Y,T), goal(X,Y).
            % It can not be the case, that the goal is not achieved
            :- not goal.            
            % Optimization: minimize the time T            
            #minimize{ T : at(X,Y,T) }.'''
}
}

creek = {"story":"creek",
         "problem":'''The task of this project is to solve a Creek puzzle using ASP. The goal of the game is to to blacken some cells of a rectangular grid so that the following conditions are met:
1. All white cells (non-blackened) must form an orthogonally connected area, i.e., it must be possible to get from any white cell to any other white cell by moving only horizontally and vertically (never diagonally!), and without having to cross a black
cell.
2. A number in a circle indicates how many of the 4 adjacent cells must be blackened. One example is shown in figure 1. The left side shows a 6x4 grid with nine numbers given in nodes. The right side shows a (here the unique) solution for the grid. Observe that the number of blackened cells adjacent to the (nine) nodes corresponds to each given number, and that all white cells are connected to each other.
Instance: cell(1..3,1..4). hint(0,2,1). hint(2,1,0). hint(2,3,4).''',
         "constants": '''rows: 1; ..; R.
                         columns: 1; ..; C.''',
        "predicates":''' % Resulting Predicate representing blackened cells: black/2. The cell at the coordinates (X,Y) is blackened
            black(X,Y) ''',
         "input_predicates":'''% there is a cell with coordinates (X,Y)
            cell(X,Y). 
            % N of the (maximum four) cells at coordinates (X,Y) => (X+1,Y), (X,Y+1) and (X+1,Y+1) must be blackened
            hint(X,Y,N).''',
         "output_predicate":'''% there is a cell with coordinates (X,Y)
            cell(X,Y).''',
                "rules": '''% The possible aditions for a hint cell
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
% Define all possible directions
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
:- not visit(X,Y), white(X,Y).'''} 

hop = {"story":hop,
      "problem":'''In this internship task, you are required to solve a logic puzzle using an ASP encoding. The goal of the puzzle is to find a path between predefined start and end points. The path consists of jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3, 1, 2, 3, and so on. Your task is to determine the cells where you land between these jumps. Some of these cells are already provided, but without a specific order.
      Instance. cols(5). rows(4). numsteps(4). start(1,4). goal(5,1). dot(2,2).'''}