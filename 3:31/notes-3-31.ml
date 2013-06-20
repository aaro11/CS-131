
(* bad contains -- e in the pattern is a fresh variable decl *)
let rec badcontains(e, lst) =
  match lst with
      [] -> false
    | e::xs -> true
    | _::xs -> badcontains(e, xs)

(* bad contains -- e referred to twice in one pattern *)	
(* let rec badcontains2 args = *)
(*   match args with *)
(*       (e, []) -> false *)
(*     | (e, e::xs) -> true *)
(*     | (e, _::xs) -> badcontains2(e, xs) *)

(* the right way *)	
let rec contains(e, lst) =
  match lst with
      [] -> false
	       (* if x=e then true else contains(e, xs) *)
    | x::xs -> x=e || contains(e, xs)

let rec contains2(e, lst) =
  match lst with
      [] -> false
    | x::xs ->
	let isFirst = (x=e) in
	  isFirst || contains2(e, xs)
  
  
let rec unzip (lst: ('a * 'b) list) : 'a list * 'b list =
  match lst with
      [] -> ([], [])
    | (x,y)::xs ->
	let (l1, l2) = unzip xs in
	  (x::l1, y::l2)
	    
(* algebraic datatypes (or recursive datatypes) *)

type sign = Pos | Neg | Zero
    
let signOf n =
    match n with
	0 -> Zero
      | _ -> if n > 0 then Pos else Neg
	  
let signToInt s =
  match s with
      Pos -> 1
    | Neg -> -1
    | Zero -> 0
	
type shape = Square of float | Triangle of float * float

let area s =
  match s with
      Square x -> x*.x
    | Triangle (base, height) -> base *. height /. 2.0

	
(* type intList = Empty | Cons of int * intList *)

type 'a myList = Empty | Cons of 'a * 'a myList  

(* [1;2;3] is the same as 1::2::3::[]
   represented as Cons(1, Cons(2, Cons(3, Empty))) *)

let rec sumList lst =
  match lst with
      Empty -> 0
    | Cons(x,xs) -> x + (sumList xs)

type intTree = Leaf | Internal of int * intTree * intTree

let rec size tree =
  match tree with
      Leaf -> 0
    | Internal (_, l, r) -> 1 + (size l) + (size r)

(* ML defines this exactly as written *)	
type 'a option = None | Some of 'a
  
let sqrt n =
  if n > 0. then (* this should be the square root *) Some 1.
  else None
