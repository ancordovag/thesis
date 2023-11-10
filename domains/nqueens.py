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
                {assign(N1, N2): number(N2)}=1 :- number(N1).''',
             "constraints": '''% Each row can only have one queen.
                :- assign(N1,N2), assign(N1,N3), N2 < N3.
                % Each columns can only have one queen.
                :- assign(N2,N1), assign(N3,N1), N2 < N3.
                % No two queens can be on the same diagonal.
                {Q1-Q2=R1-R2; Q1-Q2=R2-R1} = 0 :- assign(Q1,R1), assign(Q2,R2), Q1!=Q2.
            '''
            }