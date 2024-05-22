                    % The possible cells are defined
            cell(X,Y) :- row(X), column(Y).
            % The possible hints are defined
            hint(X,Y,N) :- hint(X,Y,N).
            % The possible black cells are defined
            black(X,Y) :- hint(X,Y,N), N > 0.
            black(X+1,Y) :- hint(X,Y,N), N > 1.
            black(X,Y+1) :- hint(X,Y,N), N > 2.
            black(X+1,Y+1) :- hint(X,Y,N), N > 3.
            % If there is no hint at cell(X,Y), then the cell can be either black or white
            0 { black(X,Y) } 1 :- cell(X,Y), not hint(X,Y,_).
            % All white cells must form an orthogonally connected area
            connected(X,Y) :- not black(X,Y), (X=1; connected(X-1,Y); connected(X,Y-1)).
            :- cell(X,Y), not black(X,Y), not connected(X,Y).
            % A number in a circle indicates how many of the 4 adjacent cells must be blackened
            :- hint(X,Y,N), N != #count{1,1 : black(X-1,Y); 1,1 : black(X+1,Y); 1,1 : black(X,Y-1); 1,1 : black(X,Y+1)}.
            % Show output predicate
            #show black/2.