(* Homework 1 *)
(* 
JONATHAN NGUY 
UID: 603 799 761

Collaborators:
Harvey Abaya
*)


(* Problem 1 *)
let rec fib (n:int) : int = 
  match n with
(* defined 0 and 1, then the formula for the rest *)
      0->0
  |   1->1
  |   _-> fib (n-1) + fib (n-2)

(* Problem 2 *)
let rec clone ((e, n) : 'a * int) : 'a list =
  match n with
      0 -> []
  |   _ -> e :: clone (e,n-1)

(* Problem 3 *)
let rec allPos (l:int list) : int list = 
  match l with
      [] -> []
  |x::xs-> if x>0 
           then x::allPos(xs)
           else allPos(xs)

(* Problem 4 *)
let rec everyOther (l:'a list) : 'a list =
  match l with
      [] -> []
  |x1::x2::xs -> x1::everyOther(xs)  
  |x::xs -> [x]

(* Problem 5 *)
let rec tails (l : 'a list) : 'a list list =
  match l with
      [] -> [l]
  |x::xs -> l::(tails xs)

(* Problem 6 *)  
let rec reverse (l : 'a list) : 'a list = 
  match l with
      [] -> []
(* reverse the rest of the list, then concat it with the first element *)
  |x::xs -> ((reverse xs) @ [x])

(* Problem 7 *)
let fastRev (l : 'a list) : 'a list =
  let rec revHelper(suffixToReverse, reversedPrefix) = 
     match suffixToReverse with
(* if there's no more to reverse, return the reversed list *)
         [] -> reversedPrefix
     |x::xs -> (revHelper (xs, (x::reversedPrefix)))
  in
    revHelper(l, [])

(* Problem 8 *)  
type opn = Add | Sub | Mult | Divide
type aexp = Num of float | Opn of aexp * opn * aexp

let rec evalAExp (e:aexp) : float =
  match e with
      Num value -> value
    | Opn (x, operate, y) -> 
      match operate with
(* x and y can be another expression or a value, so we have to check that *)
	Add -> evalAExp(x) +. evalAExp(y)
	| Sub -> evalAExp(x) -. evalAExp(y)
	| Mult -> evalAExp(x) *. evalAExp(y)
	| Divide -> evalAExp(x) /. evalAExp(y)

(* Problem 9 *)  
type sopn = Push of float | DoOpn of opn

let rec evalRPN (args : (sopn list * float list)) : float = 
  match args with
      ([], []) -> 0.0
    | ([], [x]) -> x
    |  (x::xs, y) -> 
    match x with
	Push a -> evalRPN (xs, a::y)
      | DoOpn b ->
	match b with
	    Add -> let y1::y2::ys=y in evalRPN (xs, (y1 +. y2)::ys)
	  | Sub -> let y1::y2::ys=y in evalRPN (xs, (y1 -. y2)::ys)
	  | Mult -> let y1::y2::ys=y in evalRPN (xs, (y1 *. y2)::ys)
	  | Divide -> let y1::y2::ys=y in evalRPN (xs, (y1 /. y2)::ys)

(* Problem 10 *)  
let rec toRPN (e:aexp) : sopn list =
  match e with
      Num value -> [Push value]
    | Opn (x, operate, y) ->
      match operate with
(* this is a postorder traversal *)
	  Add -> toRPN(x)@toRPN(y)@[DoOpn Add]
	| Sub -> toRPN(x)@toRPN(y)@[DoOpn Sub]
	| Mult -> toRPN(x)@toRPN(y)@[DoOpn Mult]
	| Divide ->toRPN(x)@toRPN(y)@[DoOpn Divide]
(* 
   9
 3  3
1 2 
Opn(Opn(Num 1.0, Add, Num 2.0), Mult, Num 3.0) -> what we have
[Push 1.0; Push 2.0; DoOpn Add; Push 3.0; DoOpn Mult] -> what we want

*)

