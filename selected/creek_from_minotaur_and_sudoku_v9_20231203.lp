                    % The possible cells around a hint
            around(X,Y,XX,YY) :- hint(X,Y,_), cell(XX,YY), |XX-X| + |YY-Y| = 1.
            % The possible black cells around a hint
            black(X,Y) :- around(X,Y,X,Y).
            % The number of black cells around a hint must be equal to the hint
            N { black(XX,YY) : around(X,Y,XX,YY) } N :- hint(X,Y,N).
            % If there is no hint at cell(X,Y), it can be either black or white
            { black(X,Y) } :- cell(X,Y), not hint(X,Y,_).
            % All white cells must form an orthogonally connected area
            connected(X,Y) :- not black(X,Y), cell(X,Y).
            connected(XX,YY) :- connected(X,Y), not black(XX,YY), around(X,Y,XX,YY).
            :- cell(X,Y), not black(X,Y), not connected(X,Y).
            % Show output predicate
            #show black/2.