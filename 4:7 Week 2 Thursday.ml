(* EXCEPTIONS IN ML *)
(* a structured way to signal an error to the caller
 - allows caller to deal with error 
 - can't confuse error with normal result

# List.assoc;;
- : 'a -> ('a * 'b) list -> 'b = <fun>
-> cant just return -1 because of the type
-> the right thing to do is return an error

*)

exception NotFound of string

let rec assoc k assocL = 
	match assocL with
		[] -> 
			raise (NotFound "no value for key k")
		| (key, v)::rest ->
			if key=k then v else (assoc key rest)

(* try e with exn1 -> e1 | … | exnN -> eN *)

let addBindingIfNotAlreadyThere k v assocL =
  try
    (* using _ because it is never used *)
    let _ = assoc k assocL in
      assocL
  with
      (* Can you a wildcard here *)
      NotFound -> (k,v) :: assocL
 (* | AnotherException -> ...
    | ... -> ...
 *)

(*
# use "/Users/jonnguy/Documents/School/Spring\ 11/CS\ 131/4:7\ Week\ 2\ Thursday.ml";;
exception NotFound
val assoc : 'a -> ('a * 'b) list -> 'b = <fun>
File "/Users/jonnguy/Documents/School/Spring 11/CS 131/4:7 Week 2 Thursday.ml", line 26, characters 8-15:
Warning 26: unused variable currVal.
val addBindingIfNotAlreadyThere :
  'a -> 'b -> ('a * 'b) list -> ('a * 'b) list = <fun>
*)

(*
SCOPING
=====

For a given reference to (or use of) a variable, which declaration does it refer to?

- global declarations
  let x = 3;;
  let double n = n*2;;

- local declarations (static scoping)
  let x = 3 in
    x+4 

# let x = x+1 in x+1;;
- : int = 5

  let x = e1 in e2
  - x is only in scope in e2

  let rec x = e1 in e2
  - x in scope in both e1 and e2

- function parameters
  - n in the double function above

  (function x -> e)
   - x is only in scope in e

in general, you can declare a pattern instead of a variable, 
  and they all have the same scope

- match expressions
  match e with
  p1 -> e1
  | ...
  | pn -> en

*STATIC (LEXICAL) SCOPING*
- a variable use refers to the nearest enclosing definition
  of that variable

(block structuring)

# let x = 45;;
val x : int = 45
# let f y = x + y;;
val f : int -> int = <fun>
# f 3;;
- : int = 48
# let x = 12;;
val x : int = 12
# f 3;;
- : int = 48 (* the x refers to 45 still *)
# x ;;
- : int = 12


Alternative is *DYNAMIC SCOPING*
- a variable use refers to the nearest enclosing definition 
  *at the point of the use dynamically*

let double n = n*2;;

n;;
 > crashes.. in both dynamic and static

double 3 --> evaluate n*2 in a new scope that augments the current scope
  with knowledge that n maps to 3 --> 6

let add =
  (function x ->
    function y -> x+y)

let addTwo = add 2
  --> evaluate (function y -> x+y) in a new scope that augments the current
  scope with the knowledge that x maps to 2

addTwo 8;; --> will crash
  --> evaluate x+y in a new scope that augments the current scope with the
  knowledge that y maps to 8 (crashes)

"scopes" = "environments"

DYNAMIC SCOPING IS BADDDD

*)
