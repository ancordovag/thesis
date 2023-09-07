%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% File: metro.lp                                                              %
%                                                                             %
% Name(s) und matriculation number(s):                                        %
%                                                                             %
% At most TWO members are allowed per group!!!                                %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

comp(MX1,MY1,MX2,MY2) :- mNode(MX1,MY1,_,_;;MX2,MY2,_,_), (MX1,MY1) < (MX2,MY2).
near(MX1,MY1,MX2,MY2) :- comp(MX1,MY1,MX2,MY2), not comp(MX1,MY1,MX,MY) : comp(MX,MY,MX2,MY2).

%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

2 { wires(LX,LY,MX,MY) : mNode(MX,MY,B,C) : L <= B : 0 < C } 2 :- lNode(LX,LY,L).
wires(MX,MY) :- wires(_,_,MX,MY).

N { metro(MX,MY) : mNode(MX,MY,_,_) } N :- metros(N).
metro(MX,MY) :- wires(MX,MY).

fill(MX1,MY1) :- near(MX1,MY1,MX2,MY2), metro(MX2,MY2), not wires(MX2,MY2).
fill(MX1,MY1) :- near(MX1,MY1,MX2,MY2), fill(MX2,MY2).
:- fill(MX,MY), not metro(MX,MY).

%%%%%%%%
% Test %
%%%%%%%%

:- mNode(MX,MY,_,C), not { wires(_,_,MX,MY) } C.
:- mNode(MX,MY,B,_), not [ wires(LX,LY,MX,MY) : lNode(LX,LY,L) = L ] B.

drop(MX1,MY1,MX2,MY2,LX,LY) :- comp(MX1,MY1,MX2,MY2), wires(LX,LY,MX1,MY1;;LX,LY,MX2,MY2).
:- comp(MX1,MY1,MX2,MY2), maxLoss(M), not { drop(MX1,MY1,MX2,MY2,_,_) } M.

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

dist(LX,LY,MX,MY,X*X + Y*Y) :- lNode(LX,LY,L), mNode(MX,MY,B,C), L <= B, 0 < C,
                               X = #abs(MX-LX), Y = #abs(MY-LY).
dist(LX,LY,D) :- dist(LX,LY,_,_,D).
pair(LX,LY,D1,D2) :- dist(LX,LY,D1;D2), D1 < D2,
                     not dist(LX,LY,D) : dist(LX,LY,D) : D1 < D : D < D2.
stop(LX,LY,D) :- dist(LX,LY,D), not pair(LX,LY,DD,D) : pair(LX,LY,DD,D).

have(LX,LY,D) :- dist(LX,LY,MX,MY,D), wires(LX,LY,MX,MY).
less(LX,LY,D) :- have(LX,LY,DD), pair(LX,LY,DD,D).
less(LX,LY,D) :- less(LX,LY,DD), pair(LX,LY,DD,D).
:- dist(LX,LY,D), not have(LX,LY,D), not less(LX,LY,D), not pair(LX,LY,D,DD) : pair(LX,LY,D,DD).

mini(LX,LY,D-1) :- have(LX,LY,D), not stop(LX,LY,D), not less(LX,LY,D).
mini(LX,LY,D-1) :- mini(LX,LY,D), not stop(LX,LY,D).
maxi(LX,LY,D-1) :- have(LX,LY,D), not stop(LX,LY,D).
maxi(LX,LY,D-1) :- maxi(LX,LY,D), not stop(LX,LY,D).

#minimize { mini(_,_,D), maxi(_,_,D) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display (only metro/2 and wires/4) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show metro/2.
#show wires/4.
