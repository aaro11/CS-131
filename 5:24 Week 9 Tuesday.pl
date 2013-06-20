
functional programming is mathematics

object-oriented programming is communication

logic programming is search (to compute.. you put constraints, then search until you match the constraints) 
	- you could also program in "first order logic"

---------------------------------
a *term* 
- constants are terms
 - 3, etc
 - *atom*
  - an identifier starting with a lowercase letter
  - kind of like constructors in user-defined type in ML
	// in ML: type day = Mon | Tues | Wed

 - variables are terms
  - an identifier starting with an uppercase letter
 - compound term
  - an atom followed by a parenthesized list of terms
 ie. parent(adam, bob)
     parent(X, bob)

------------
/* prereq is a predicate */
/* each of these is a *fact* */
prereq(___, ___)

//courses is a .pl file
| ?- consult(courses).
| ?- prereq(cs32, cs33).

the semi colon says to search the rest of the list
hitting return just ends it there

//tell me all the classes that have CS 131 as a prereq
| ?- prereq(cs131, X).

//list a class that has cs32 as a pre req
| ?- prereq(cs32, X).

//can also go the other way:
| ?- prereq(X, 131).

// find x and y that have cs32 as a prereq
| ?- prereq(cs32, X), prereq(cs32, Y).

// to make X and Y not the same as each other
| ?- prereq(cs32, X), prereq(cs32, Y), \+(X=Y).

// find me a course that has a prereq of CS32, 
// but is also a prereq of cs132
| ?- prereq(cs32, X), prereq(X, cs132).

// find two courses that are both prereqs of the same course
// gives all X,Y,Z in which X Y and both prereqs of Z
| ?- prereq(X,Z), prereq(Y,Z), \+(X=Y).

// find X which is a prereq for Z, which is a prereq of cs131
| ?- prereq(X,Z), prereq(Z, cs131).


--------------------------------------------------------
/* rules allow us to derive new facts from old ones */
// X is a prereq of a prereq of Z 
/*
  forall X,Z. if exists Y. prereq(X,Y) and prereq(Y,Z),
              then prereq2(X,Z)
*/
// head of the rule
prereq2(X, Z) :- prereq(X,Y), prereq(Y,Z).
                //body of the rule
// the scope of X,Z are only for the body, then they're gone 

// add second RULE for prereq2:
prereq2(U,V) :- prereq(U,V).

/* either a prereq, or a pre of a pre, or a pre of a pre of a pre
prereq3(X,Z) :- prereq2(X,Z).
prereq3(X,Z) :- prereq2(X,Y), prereq(Y,Z).

// predicates can be recursive
/* a transitive prereq */
ancestor(X,Z) :- prereq(X,Z).
ancestor(X,Z) :- prereq(X,Y), ancestor(Y,Z).

everything is uninterpreted.

/* Prolog Lists:

[] is the empty list

'.' is the same as ML ::

.(1, []) is the list [1]

//they are the same
.(1, .(2, [])) = [1,2] 

// give me a Z that appends [1,2] with [3,4]
| ?- append([1,2], [3,4], Z) 

// give me a Y that appended to [1,2] gives [1,2,3,4]
| ?- append([1,2], Y, [1,2,3,4])

---------------
// DEFINING append

/* in ML
 let rec append l1 l2 =
   match l1 with
     [] -> l2
  | x::xs -> x :: (append xs l2)
*/

myappend([], L2, L2).
myappend([X|Xs], L2, [X|Lres]) :- myappend(Xs, L2, Lres). 


mylength([], 0).
mylength([X|Xs], R) :- mylength(Xs, L), R is L+1.
// you can do :
| ?- mylength([1,2,3], X).
// you cannot do it backwards:
| ?- mylength(L, 1).

// because it's dynamically typed, you can make errors:
myappend([], L2, L2).
myappend([X|Xs], L2, [X|Lres]) :- myappend(Xss, L2, Lres). /* typo of Xss */

/* wolf-goat-cabbage problem */

/* a configuration (or state of the world) as a list of 
  four elements, say where Person, Wolf, Goat, Cabbage are located.

  initial state: [west, west, west, west]
  goal state: [east, east, east, east]

*/

/* move (Config, Move, Config')
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

| ?- length(Actions, y), boatPuzzle([west,west,west,west], [east,east,east,east], Actions).
Actions = [goat,nothing,wolf,goat,cabbage,nothing,goat] ? ;
Actions = [goat,nothing,cabbage,goat,wolf,nothing,goat] ? ;
no
