/* wolf-goat-cabbage problem */

/* a configuration (or state of the world) as a list of 
  four elements, say where Person, Wolf, Goat, Cabbage are located. 

  initial state: [west, west, west, west]
  goal state: [east, east, east, east]

*/

/* move (Config, Move, Config)
  configuration (state), move, final configuration (state)

  legal moves are: nothing, wolf, goat, cabbage
*/

oppositeSide(east, west).
oppositeSide(west, east). 

/*
move([west, W, G, C], nothing, [east, W, G, C]).
move([east, W, G, C], nothing, [west, W, G, C]).
*/

move([P,W,G,C], nothing, [Pnew, W, G, C] :-
     oppositeSide(P, Pnew).

move([P,P,G,C], wolf, [Pnew, Pnew, G, C] :-
     oppositeSide(P, Pnew).

move([P,W,P,C], goat, [Pnew, W, Pnew, C] :-
     oppositeSide(P, Pnew).

move([P,W,G,P], cabbage, [Pnew, W, G, Pnew] :-
     oppositeSide(P, Pnew).

badState([P,W,W,C]) :- oppositeSide(P,W).
badState([P,W,G,G]) :- oppositeSide(P,G).
 
/* predicate boatPuzzle(Start, Goal, Actions) */

boatPuzzle(Goal, Goal, []).
boatPuzzle(Start, Goal, [Move|Actions]) :- 
     move(Start, Move, NewState), 
     \+(badState(NewState)),
     boatPuzzle(NewState, Goal, Actions).

/* ?- length(Actions, y), boatPuzzle([west,west,west,west], [east,east,east,east], Actions).
 Actions = [goat,nothing,wolf,goat,cabbage,nothing,goat] ? ;
 Actions = [goat,nothing,cabbage,goat,wolf,nothing,goat] ? ;*/


/* a generator for numbers from 0 to N */
genNum (0).

/* generates numbers from 0 to infinity */
genNum(N) :- genNum(Nsub), N is Nsub + 1.

/* C as the upper bound: */
genNum (0, C).
genNum(N, C) :- genNum(Nsub), Nsub < C, N is Nsub + 1.

/* generate numbers upto N */
upTo(0, 0).

upTo(N,X) :- Nsub is N - 1, upTo(Nsub, X).


/* N-queens program */
/* represent a queens position as queen(X,Y) /

abs(C, C) :- C >= 0.
abs(C, A) :- C < 0, A is C * -1.

/* column or row are equal */
attacks(queen(X1,_), queen(X2,_)) :- X1 =:= X2.
attacks(queen(_,Y1), queen(_,Y2)) :- Y1 =:= Y2.

/* if the diagonal is equal */
attacks(queen(X1,Y1), queen(X2,Y2)) :- 
  Xdiff is X1 - X2, Ydiff is Y1 - Y2,
  abs(Xdiff, Xabs), abs(Ydiff, Yabs),
  Xabs =:= Yabs. 

attacksNothing(_, []).
attacksNothing(Q, [H|T]) :-
  \+(attacks(Q,H)), attacksNothing(Q,T).

/* no queens means it's true */
nqueens([]).

validQueen(queen(X,Y)) :- member(X, [1,2,3,4,5,6,7,8]),
    member(Y, [1,2,3,4,5,6,7,8]).

/* if one queen, it's true */
% nqueens([queen(X,Y)]) :- validQueen(queen(X,Y)).


nqueens([H|T]) :- validQueen(H), nqueens(T), attacksNothing (H,T).


/* | ?- nqueens([Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8]).
 | ?- nqueens([Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8]). */

dist(losAngeles, seattle, 1130).
dist(losAngeles, sanFrancisco, 390).
dist(losAngeles, sanDiego, 130).
dist(seattle, sanDiego, 1260).
dist(seattle, sanFrancisco, 810).
dist(sanFrancisco, sanDiego, 510).

/* symmetry */
symmetricDist(X,Y,L) :- dist(X,Y,L).
symmetricDist(X,Y,L) :- dist(Y,X,L).

sum([], 0).
sum([_], 0).
sum([H1,H2|T], L) :- symmetricDist(H1,H2,D),
  sum([H2|T], Drest), L is D + Drest.

tsp(Cities, Tour, Length) :- 
  permutation(Cities, [Head|Rest]),
  append([Head|Rest], [Head], Tour),
  sum(Tour, Length).


