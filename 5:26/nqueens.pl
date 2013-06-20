
/* represent a queen's position as queen(X,Y) */

abs(C, C) :- C >= 0.

abs(C, A) :- C < 0, A is C * -1.

attacks(queen(X1,_), queen(X2,_)) :- X1 =:= X2.

attacks(queen(_,Y1), queen(_,Y2)) :- Y1 =:= Y2.

attacks(queen(X1,Y1), queen(X2,Y2)) :-
	Xdiff is X1 - X2, Ydiff is Y1 - Y2,
	abs(Xdiff, Xabs), abs(Ydiff, Yabs),
	Xabs =:= Yabs.


attacksNothing(_, []).

attacksNothing(Q, [H|T]) :-
	\+(attacks(Q, H)), attacksNothing(Q, T).

validQueen(queen(X,Y)) :- member(X, [1,2,3,4,5,6,7,8]),
	member(Y, [1,2,3,4,5,6,7,8]).

nqueens([]).

nqueens([H|T]) :- validQueen(H), nqueens(T), attacksNothing(H, T).
