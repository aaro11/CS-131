
/* prereq is a predicate */

/* each of these is a *fact* */
prereq(cs31, cs32).
prereq(cs32, cs33).
prereq(phys1C, csM51A).
prereq(cs32, cs111).
prereq(cs33, cs111).
prereq(stat110A, cs112).
prereq(cs32, cs118).
prereq(cs33, cs118).
prereq(cs32, cs131).
prereq(cs33, cs131).
prereq(cs32, cs132).
prereq(cs131, cs132).
prereq(cs181, cs132).

/* rules allow us to derive new facts from old ones */

/* X is a prereq of a prereq of Z */
/*
  forall X,Z. if exists Y. prereq(X,Y) and prereq(Y,Z),
              then prereq2(X,Z)
  */
prereq2(X,Z) :- prereq(X,Y), prereq(Y,Z).

prereq2(U,V) :- prereq(U,V).


/* either a prereq, or a pre of a pre, or a
   pre of a pre of a pre */
prereq3(X,Z) :- prereq2(X,Z).

prereq3(X,Z) :- prereq2(X,Y), prereq(Y,Z).

/* a transitive prereq */

ancestor(X,Z) :- prereq(X,Z).

ancestor(X,Z) :- prereq(X,Y), ancestor(Y,Z).

/* Prolog Lists:

[] is the empty list

. is the same as ML ::

.(1, []) is the list [1]

.(1, .(2, []))

[1,2]

*/

/*
  let rec append l1 l2 =
    match l1 with
       [] -> l2
     | x::xs -> x :: (append xs l2)

*/

myappend([], L2, L2).

myappend([X|Xs], L2, [X|Lres]) :-
	myappend(Xs, L2, Lres).


mylength([], 0).

mylength([_|Xs], R) :- mylength(Xs, L), R is L+1.