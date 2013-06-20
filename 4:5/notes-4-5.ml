let square x = x * x
  
let y = 4

(* the above definition of square is shorthand for this *)  
let square2 = (function x -> x * x)

(* in general: function expression (or lambda function or closure)
   has the form
   function p -> e
*)

(* can pass functions to other functions
   a function that takes another function as an arg is called
   a higher-order function *)

let twice (f, x) = f(f x)


(* the next four functions are all equivalent ways of writing the same thing *)
  
let betterTwice f = function x -> f(f x)

let betterTwice2 =
  (function f ->
     (function x -> f(f x)))

(* this style of passing multiple args via functions that return functions is called
 *currying* *)

let betterTwice3 =
  (fun f x -> f(f x))
    
(* in general:  fun p1 ... pn -> e
   translates to: function p1 -> function p2 -> ... -> function pn -> e
*)

let betterTwice4 f x = f(f x)  

let rec concat l1 l2 =
  match l1 with
      [] -> l2
    | x::xs ->  x :: (concat xs l2)
	
(* concat: 'a list -> 'a list -> 'a list
   -> is right associative, so equivalent to
   'a list -> ('a list -> 'a list)

   concat [1;2;3] [4;5;6]
   function calling is left associative, so equivalent to
   (concat [1;2;3]) [4;5;6]
*)

let rec incLst l =
  match l with
      [] -> []
    | x::xs -> (x+1)::(incLst xs)

let rec swapLst l =
  match l with
      [] -> []
    | (x,y)::rest -> (y,x)::(swapLst rest)
	

(* equivalent to the above 2 functions *)
	
let incLst2 l = List.map (function x -> x+1) l

let swapLst2 l = List.map (function (x,y) -> (y,x)) l

(* making use of the fact that map is curried *)

let incLst3 = List.map (function x -> x+1)
  
  
let rec map f l =
  match l with
      [] -> []
    | x::xs -> (f x)::(map f xs)

let expList exp lst =
  map (function x -> x ** exp) lst
    
(* List.fold_right f [x1;...;xn] b
   computes this expression:
   f(x1, f(x2, ... f(xn, b) ... ))
*)

let rec sumList l =
  match l with
      [] -> 0
    | x::xs -> x + (sumList xs)

	
let sumList2 l =
  List.fold_right (fun x y -> x+y) l 0

let sumList3 l =
  List.fold_right (+) l 0
    
let rec fold_right f l b =
  match l with
      [] -> b
    | x::xs -> f x (fold_right f xs b)

let concat l1 l2 =
  List.fold_right (fun x l -> x::l) l1 l2

(* ::(x1, ::(x2, ... ::(xn, l2) ... ))
   where l1 = [x1;x2;...;xn]
*)

(* dupList [1;2;3] returns [1;1;2;2;3;3] *)    
let dupList l =
  List.fold_right (fun x rest -> x::x::rest) l []

(* List.fold_left f b l computes the expression
   f(f(...(f(b,x1), x2), ...),xn)
*)
    
let maxList l =
   List.fold_left (fun currMax elem -> if (currMax > elem) then currMax else elem)
     0 l
