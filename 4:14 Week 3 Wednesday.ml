(*
Another dimension to compare forms of typechecking:

*strong vs weak
  - a strongly typed language never allows a primitive operation to be invoked
  with arguments of the wrong type
  (goal: prevent arguments of wrong types)
  (LISTS are static and strongly typed)

   - ML, Java, C#, Python, Perl, Lisp

  - a weakly typed language can allow some type errors to go undetected
  ( 
   - C/C++
     - casts aren't checked at runtime 
       - don't plug the "holes" because of performance costs
     - pointer arithmetic 
       - *(p+4) ... can be reading arbitrary memory beyond the scope
     - array bounds
       - buffer overruns -> lead to securty exploits
     - dangling pointers

  tradeoffs: strong typechecking preferred, but costs more at runtime,
             but *much* safer
 
 ML equivalent of "cast"
  # type intorbool = Int of int | Bool of bool;;
  type intorbool = Int of int | Bool of bool
 ML has no pointers (undercovered but not at the programming level)
 ML uses garbage collection to free memory 
   - memory that cant be accessed anymore

There are languages that are :
  - statically, strongly typed
    - ML, Java, C#
  - statically, weakly typed
    - C, C++
  - dynamically, strongly typed
    - Lisp, Python, Ruby,...
  - dynamically, weakly typed
    - nothing

A final dimension:
  * type checking versus type inference
  ML uses type inference (it'll figure out the variable types)
  Java uses type checking (you have to declare the variables)

Type checking doesn't check all the errors of a program
  - need things like testing

==========================

A *module* or a *structure* is just a name sequence of declarations
e.g. 
  module Name = struct 
    d1
    d2
    ...
    dn
  end
*)

module Point = struct
  type point = P of int * int
  let makePoint (x,y) = P (x,y)
  let distSquared (P(x,y))= x*x + y*y
end;;

(*
# type weightInPounds = int;;
  -> used as a synonym for int
  -> "weak" form of type

Key idea: separation of interface from implementation
  - clients depend only on the interface
  - can enforce important invariants
    - e.g. ensures that a set never has duplicates
  - allows the implementer flexibility
    - implementer can change the implementation without
      breaking clients (as long as the interface doesn't change)
*)

(*to hide the set*)
module type SET = sig
    type t
    val emptyset : t
    val contains : int -> t -> bool
    val addElem : int -> t -> t
end

module Set:SET = struct
  type t = S of int list
  let emptyset = S []
  let contains e (S lst) = List.mem e lst
  let addElem e (S lst) =
    if contains e (S lst)
    then (S lst)
    else (S (e::lst))
end
