
let rec fact n =
  match n with
      0 -> 1
    | 1 -> 1
    | 2 -> 2
    | _ -> n * (fact (n-1))

(* bad style *)	
let rec fact2 n =
  if n=0
  then 1
  else n * (fact2 (n-1))
    
let rec sumList lst =
  match lst with
      [] -> 0
    | x::xs -> x + (sumList xs)
	
let rec concat (l1, l2) =
  match l1 with
      [] -> l2
    | x::xs ->  x :: concat(xs, l2)

let rec sumConsecutive lst =
  match lst with
      [] -> []
    | [_] -> lst
    | x1::x2::xs -> (x1+x2)::(sumConsecutive xs)
	
	
let add(x,y) = x+y

let three() = 3
  
(* zip ([1;2;3], [4;5;6]) = [(1,4); (2,5); (3,6)] *)

let rec zip args =
  match args with
    | ([], []) -> []
    | (x::xs, y::ys) -> (x,y)::zip(xs,ys)

	
