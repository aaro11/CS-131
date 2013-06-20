
/* wolf-goat-cabbage problem */

/* a configuration (or state of the world) as
   a list of four elements, say where
   Person, Wolf, Goat, Cabbage are located.

   initial state:  [west, west, west, west]
   goal state: [east, east, east, east]

*/

/* move(Config, Move, Config')

   legal moves are nothing, wolf, goat, cabbage

*/

oppositeSide(east, west).
oppositeSide(west, east).

/*
move([west, W, G, C], nothing, [east, W, G, C]).
move([east, W, G, C], nothing, [west, W, G, C]).
*/

move([P,W,G,C], nothing, [Pnew, W, G, C]) :-
	oppositeSide(P, Pnew).

move([P,P,G,C], wolf, [Pnew, Pnew, G, C]) :-
	oppositeSide(P, Pnew).

move([P,W,P,C], goat, [Pnew, W, Pnew, C]) :-
	oppositeSide(P, Pnew).

move([P,W,G,P], cabbage, [Pnew, W, G, Pnew]) :-
	oppositeSide(P, Pnew).

badState([P,W,W,_]) :- oppositeSide(P,W).

badState([P,_,G,G]) :- oppositeSide(P,G).


/* predicate boatPuzzle(Start, Goal, Actions)
*/

boatPuzzle(Goal, Goal, []).

boatPuzzle(Start, Goal, [Move|Actions]) :-
	move(Start, Move, NewState),
	\+(badState(NewState)),
	boatPuzzle(NewState, Goal, Actions).


/* a generator for numbers from 0 to N */

genNum(0).

genNum(N) :- genNum(Nsub), N is Nsub + 1. 

