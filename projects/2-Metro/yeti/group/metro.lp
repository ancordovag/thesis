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
wires(MX,MY) :- wires(_,_,MX,MY). % metro(MX,MY) :- wires(_,_,MX,MY).

M { metro(MX,MY) : mNode(MX,MY,_,_) } M :- metros(M).
metro(MX,MY) :- wires(MX,MY).

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%

fill(MX1,MY1) :- near(MX1,MY1,MX2,MY2), metro(MX2,MY2), not wires(MX2,MY2).
fill(MX1,MY1) :- near(MX1,MY1,MX2,MY2), fill(MX2,MY2).
:- fill(MX,MY), not metro(MX,MY).

:- mNode(MX,MY,_,C), not { wires(_,_,MX,MY) } C.
:- mNode(MX,MY,B,_), not [ wires(LX,LY,MX,MY) : lNode(LX,LY,L) = L ] B.

drop(MX1,MY1,MX2,MY2,LX,LY) :- comp(MX1,MY1,MX2,MY2), wires(LX,LY,MX1,MY1;;LX,LY,MX2,MY2).
:- comp(MX1,MY1,MX2,MY2), maxLoss(M), not { drop(MX1,MY1,MX2,MY2,_,_) } M.

%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

#minimize [ wires(LX,LY,MX,MY) : X = #abs(MX-LX) : Y = #abs(MY-LY) = X*X + Y*Y ].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display (only metro/2 and wires/4) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show metro/2.
#show wires/4.
