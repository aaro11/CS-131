(* 
Name: Jonathan Nguy
UID: 603 799 761

HOMEWORK 2
*)
(* This is a marker for places in the code that you have to fill in.
   Your completed assignment should never raise this exception. *)
exception ImplementMe

(* Problem 1 *)    
let allPos (l : int list) : int list =
  List.filter (fun a -> a > 0) l

(* Problem 2 *)  
let tails (l : 'a list) : 'a list list =
  List.fold_right (
    (* x::xs matches the outer list
       a would be the next element from the right
       (a::x) creates another list with a concatenated with the other tail
       finally, cons that with the outer list*)
    fun a b -> 
      let x::xs = b in 
        (a::x)::b
      ) l [[]]
  
(* Problem 3 *)
let filter (f : 'a -> bool) (l : 'a list) : 'a list = 
  List.fold_right (fun x y -> if (f x) then x::y else y) l []

(* Problem 4 *)    
let rec map2 (f : 'a * 'b -> 'c) (l1 : 'a list) (l2 : 'b list) : 'c list =
  match (l1, l2) with
      ([], []) -> []
    | (x::xs, y::ys) -> f(x,y)::(map2 f xs ys)

(* Problem 5 *)	
let zip ((l1, l2) : 'a list * 'b list) : ('a * 'b) list = 
  map2 (fun (x,y) -> (x,y)) l1 l2
 
(* Problem 6 *)    
let curry (f : 'a * 'b -> 'c) : 'a -> 'b -> 'c = 
  (fun x -> fun y -> f (x,y))

let uncurry (f : 'a -> 'b -> 'c) : 'a * 'b -> 'c = 
  (fun (x,y) -> f x y)
      

(* Problem 7 *)      
let primesUpTo n =
  (* compute a list of integers between 1 and n, inclusive *)
  let rec intsBetween i n = 
     if (i=n) then
       [n]
     else
       i::(intsBetween (i+1) n)
  in
 (* compute a list of all elements of the given list that are prime *)
  let rec sieve cands = 
    match cands with
	[] -> []
      | x::xs -> x::(sieve (List.filter (fun y -> ((y mod x) > 0)) xs))
  in
    sieve(intsBetween 2 n)
    
(* Problem 8 *)

(* The next two helper functions convert between a string and an
equivalent list of characters.  You do not need to modify them or
understand their implementations. *)
      
(* example: str2charList "hello" = ['h';'e';'l';'l';'o'] *)
let str2charList (s : string) : char list =
  let len = String.length s in
  let rec convert n =
    if n = len then [] else s.[n] :: (convert(n+1))
  in
    convert 0

(* example: charList2str ['h';'e';'l';'l';'o'] = "hello" *)
let charList2str (l : char list) : string =
  let s = String.create (List.length l) in
  let rec convert n lst =
    match lst with
	[] -> s
      | c::cs -> s.[n] <- c; (convert (n+1) cs)
  in
    convert 0 l
      
let ccipher (n : int) : (string -> string) * (string -> string) = 
  (* the last thing we need to do is return a string, so charList2str is outside
     next, the function basically gets the ASCII and adds n, 
     mod would wrap around the a-z ASCII values *)
  ((fun x -> charList2str (List.map 
			     (fun a -> 
			       if (Char.code a + n) > 122 
			       then Char.chr (Char.code a mod n + Char.code 'a')
			       else Char.chr (Char.code a + n)) (str2charList x))),
   (fun y -> charList2str (List.map 
			     (fun b -> 
			       if (Char.code b - n) < 97
			       then Char.chr (Char.code 'z' - (Char.code b mod n))
			       else Char.chr (Char.code b - n)) (str2charList y))))

