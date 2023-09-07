% domain projections
mNode(X,Y) :- mNode(X,Y,_,_).
mNodeLast(X,Y,L) :- mNode(X,Y,L,_).
mNodeCon(X,Y,C) :- mNode(X,Y,_,C).
lNode(X,Y) :- lNode(X,Y,_).

% guess metrospots
H {metro(X,Y):mNode(X,Y)} H :- metros(H).

% guess wires to two metrospots for each node 

2 {wires(NX,NY,HX,HY):mNode(HX,HY)} 2:- lNode(NX,NY).
wiresTo(HX,HY) :- wires(_,_,HX,HY).	
:- wiresTo(X,Y), not metro(X,Y). %geht vielleicht eleganter?

% determine distance
% compute all possible distances while grounding 

dist(NX,NY,HX,HY,D) :- lNode(NX,NY), mNode(HX,HY), D = #abs(NX - HX) * #abs(NX - HX) + #abs(NY - HY) * #abs(NY - HY).

usedDis(NX,NY,HX,HY,D) :- dist(NX,NY,HX,HY,D), wires(NX,NY,HX,HY).
#minimize[usedDis(NX,NY,HX,HY,D) = D].

% side conditions
%max. connections
:- metro(X,Y), mNodeCon(X,Y,C), not {wires(XL,YL,X,Y)}C.

% max. last
wiresLast(XL,YL,XM,YM,L) :- lNode(XL,YL,L), wires(XL,YL,XM,YM).
:- metro(X,Y), mNodeLast(X,Y,MaxL), not [wiresLast(_,_,X,Y,L)=L] MaxL.

% maximal loss after breakdown
commonmetros(NX,NY,HX1,HY1,HX2,HY2) :- metro(HX1,HY1), metro(HX2,HY2),(HX1,HY1) != (HX2,HY2), wires(NX,NY,HX1,HY1), wires(NX,NY,HX2,HY2). 
:- metro(HX1,HY1), metro(HX2,HY2),(HX1,HY1) != (HX2,HY2), N=#count{commonmetros(NX,NY,HX1,HY1,HX2,HY2)}, maxLoss(L), N > L.
#hide.
#show metro/2.
#show wires/4.