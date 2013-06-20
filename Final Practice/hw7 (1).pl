% Homework 7
% Jonathan Nguy
% 603 799 761
  % Collaborators: Harvey Abaya

% Problem 1:
% Implement a predicate duplist(X,Y)

duplist([],[]).
duplist([X|T], Y) :- append([X,X], R, Y), duplist(T, R).

% Problem 2: 
% Define a predicate sorted(X)

sorted([]).
sorted([_]).
sorted([X,Y|T]) :- (X =< Y), sorted([Y|T]).

% Problem 3:
% subseq(X,Y)

subseq([X|Xs], [X|Ys]) :- subseq(Xs,Ys).
subseq([X|Xs], [Y|Ys]) :- subseq([X|Xs], Ys), \+ (X=Y).
subseq([], _).

% Problem 4:
% sudoku(Initial, Final):

sudoku([[A1,B1,C1,D1],[A2,B2,C2,D2],[A3,B3,C3,D3],[A4,B4,C4,D4]], 
       [[A1,B1,C1,D1],[A2,B2,C2,D2],[A3,B3,C3,D3],[A4,B4,C4,D4]]) :-       
       check([A1,B1,C1,D1]), check([A2,B2,C2,D2]), check([A3,B3,C3,D3]), check([A4,B4,C4,D4]),
       check([A1,A2,A3,A4]), check([B1,B2,B3,B4]), check([C1,C2,C3,C4]), check([D1,D2,D3,D4]),
       check([A1,A2,B1,B2]), check([C1,C2,D1,D2]), check([A3,A4,B3,B4]), check([C3,C4,D3,D4]).

% check makes sure if the 4 values are a permutation of [1,2,3,4]
check([A,B,C,D]) :- permutation([1,2,3,4], [A,B,C,D]).

% Problem 5:
% towersOfHanoi(Init, Goal, Moves).
% | ?- length(Moves, 7), towersOfHanoi([[1,2,3],[],[]], [[],[1,2,3],[]], Moves).

towersOfHanoi(Goal,Goal,_).
towersOfHanoi(Init, Goal, [Moves|Actions]) :- 
        move(Init, NewState, Moves),
	\+(badState(NewState)),
	towersOfHanoi(NewState, Goal, Actions).

move([[X|Xs],Y,L3], [Xs,[X|Y],L3], to(peg1,peg2)).
move([[X|Xs],L2,Y], [Xs,L2,[X|Y]], to(peg1,peg3)).
move([Y,[X|Xs],L3], [[X|Y],Xs,L3], to(peg2,peg1)).
move([L1,[X|Xs],Y], [L1,Xs,[X|Y]], to(peg2,peg3)).
move([Y,L2,[X|Xs]], [[X|Y],L2,Xs], to(peg3,peg1)).
move([L1,Y,[X|Xs]], [L1,[X|Y],Xs], to(peg3,peg2)).

badState([[X,Y|_],_,_]) :- (X>Y).
badState([_,[X,Y|_],_]) :- (X>Y).
badState([_,_,[X,Y|_]]) :- (X>Y).
