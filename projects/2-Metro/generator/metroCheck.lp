mNode(MX,MY) :- mNode(MX,MY,_,_).
lNode(LX,LY) :- lNode(LX,LY,_).

comp(MX1,MY1,MX2,MY2) :- mNode(MX1,MY1;;MX2,MY2), (MX1,MY1) < (MX2,MY2).

%%%%%%%%%%%%
% Check    %
%%%%%%%%%%%%

:- metro(MX,MY), not mNode(MX,MY).
:- wires(LX,LY,MX,MY), { lNode(LX,LY), metro(MX,MY) } 1.

:- lNode(LX,LY), not 2 { wires(LX,LY,_,_) } 2.
:- metros(M), not M { metro(_,_) } M.

:- mNode(MX,MY,_,C), not { wires(_,_,MX,MY) } C.
:- mNode(MX,MY,B,_), not [ wires(LX,LY,MX,MY) : lNode(LX,LY,L) = L ] B.

drop(MX1,MY1,MX2,MY2,LX,LY) :- wires(LX,LY,MX1,MY1;;LX,LY,MX2,MY2), comp(MX1,MY1,MX2,MY2).
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
