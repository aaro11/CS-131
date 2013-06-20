
% duplist

duplist([], []).
duplist([H|T1], [H,H|T2]) :- duplist(T1, T2).

% sorted

sorted([]).
sorted([_]).
sorted([F,S|Rest]) :- F =< S, sorted([S|Rest]).

% subseq

subseq([], []).
subseq([H|T1], [H|T2]) :- subseq(T1, T2).
subseq(L, [_|T2]) :- subseq(L, T2).

% 4x4 sudoku

isSafe(R) :- permutation([1,2,3,4], R).

sudoku(Initial,Final) :-
	Initial = [R1, R2, R3, R4],

	% the rows cover all numbers
	isSafe(R1), isSafe(R2), isSafe(R3), isSafe(R4),
	
	R1 = [A1,A2,A3,A4],
	R2 = [B1,B2,B3,B4],
	R3 = [C1,C2,C3,C4],
	R4 = [D1,D2,D3,D4],

	% the columns cover all numbers
	isSafe([A1,B1,C1,D1]), isSafe([A2,B2,C2,D2]),
	isSafe([A3,B3,C3,D3]), isSafe([A4,B4,C4,D4]),

	% the 2x2 squares cover all numbers
	isSafe([A1,A2,B1,B2]), isSafe([A3,A4,B3,B4]),
	isSafe([C1,C2,D1,D2]), isSafe([C3,C4,D3,D4]),
	
	Final = Initial.


% towers of hanoi

isLegal(_, []).
isLegal(N, [H|_]) :- N < H.
    
move([[H|T], P2, P3], to(p1, p2), [T, [H|P2], P3]) :- isLegal(H, P2).
move([[H|T], P2, P3], to(p1, p3), [T, P2, [H|P3]]) :- isLegal(H, P3).
move([P1, [H|T], P3], to(p2, p1), [[H|P1], T, P3]) :- isLegal(H, P1).
move([P1, [H|T], P3], to(p2, p3), [P1, T, [H|P3]]) :- isLegal(H, P3).
move([P1, P2, [H|T]], to(p3, p1), [[H|P1], P2, T]) :- isLegal(H, P1).
move([P1, P2, [H|T]], to(p3, p2), [P1, [H|P2], T]) :- isLegal(H, P2).

towersOfHanoi(Goal, Goal, []).
towersOfHanoi(Curr, Goal, [Action|Rest]) :-
	move(Curr, Action, Curr2), towersOfHanoi(Curr2, Goal, Rest).

