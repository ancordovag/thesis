skip(X,Y) :- empty(X,Y).
skip(X,Y) :- digit(X,Y,_).
cell(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not skip(X,Y).

xseg(1,  Y,1,  Y) :- cell(1,Y).
xseg(X+1,Y,X+1,Y) :- skip(X,Y), cell(X+1,Y).
xseg(X1, Y,X+1,Y) :- xseg(X1,Y,X,Y), cell(X+1,Y).

yseg(X,1,  X,1)   :- cell(X,1).
yseg(X,Y+1,X,Y+1) :- skip(X,Y), cell(X,Y+1).
yseg(X,Y1, X,Y+1) :- yseg(X,Y1,X,Y), cell(X,Y+1).

1 #count{ light(X1,Y1) : xseg(XX,YX,X1,Y1),
          light(X2,Y2) : yseg(XY,YY,X2,Y2) } :- xseg(XX,YX,X,Y), yseg(XY,YY,X,Y).
 :- xseg(X,Y,X,Y), 2 #count{ light(X1,Y1) : xseg(X,Y,X1,Y1) }.
 :- yseg(X,Y,X,Y), 2 #count{ light(X2,Y2) : yseg(X,Y,X2,Y2) }.
 :- digit(X,Y,N), not N #count{ light(X-1;X+1,Y), light(X,Y-1;Y+1) } N.

#hide.
#show light/2.
