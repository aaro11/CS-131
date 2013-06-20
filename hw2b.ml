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
    fun a b -> 
      let x::xs = b in 
        a::x@xs
        ) l [[]]
  
(* Problem 3 *)
let filter (f : 'a -> bool) (l : 'a list) : 'a list = raise ImplementMe

(* Problem 4 *)    
let rec map2 (f : 'a * 'b -> 'c) (l1 : 'a list) (l2 : 'b list) : 'c list = raise ImplementMe

(* Problem 5 *)	
let zip ((l1, l2) : 'a list * 'b list) : ('a * 'b) list = raise ImplementMe

(* Problem 6 *)    
let curry (f : 'a * 'b -> 'c) : 'a -> 'b -> 'c = raise ImplementMe

let uncurry (f : 'a -> 'b -> 'c) : 'a * 'b -> 'c = raise ImplementMe

(* Problem 7 *)      
let primesUpTo n =
  (* compute a list of integers between 1 and n, inclusive *)
  let rec intsBetween i n = raise ImplementMe in
 (* compute a list of all elements of the given list that are prime *)
  let rec sieve cands = raise ImplementMe in
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
      
let ccipher (n : int) : (string -> string) * (string -> string) = raise ImplementMe
  
