(*
FIRST-ORDER FUNCTION
  *functions are values in OCaml
    - arguments (inputs) to a functin
    - Output of functions
    - Values for local "variables"

HIGHER-ORDER FUNCTION
  - a function that can take a function
  - or return a function

CURRYING (functions within functions ... replaces two-poles)
  let rec foo (a,b) : c = ...
  (not curried)
   ('a * 'b) -> c
  currying --> 
    a -> (b -> c)
 
 ex. 
  NOT CURRYING
  let func = fun (a, b) -> a + b 
    type: --> int * int -> int (maybe we dont always want ints)
  let func = fun a b -> a + b in
    let func 2 = func 3 in 
    type: --> 3 -> (int * int)

BUILT-IN HIGHER-ORDER FUNCTIONS
(the more important ones
  fn = 'b)
  * filter = ('a -> bool) -> 'a list -> 'a list
  [fn a1; fn a2; fn a3; ...; fn an]
  (outputs...)
  -> [...all elements where fn ai = true]
  
  * find = ('a -> bool) -> 'a list -> 'a 
  [fn a1; fn a2; ...; fn an]
  (outputs...)
  -> first ai that satisfies fn ai

  * map : ('a -> 'b) -> 'a list -> 'b list
  [fn a1; fn a2; fn a3; ...; fn an]
  
  * map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  [fn a1 b1; fn a2 b2; ...; fn an bn]

~~~~

[1;2;3;4;5]
= 1::2::3::4::5::[]

(thinking of it as a tree..)
    /   \
   1   /  \
      2  /  \
        3  /  \
          4  /  \
            5   []

FOLD_LEFT
  ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
       ("fn")      seed^value  "l1"
           fn
          /   \
         fn   5
        /  \ 
       fn   4
      /  \  
     fn   3
    /  \  
   fn  2
  /  \  
seed  1

ex. fold_left (-) 0 l1
fn = (-)
  from bottom left to top right:
  seed: 0
  -1, -3, -6, -10, -15
  final result = int -15

FOLD_RIGHT
  ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b 
       "fn"          "list"   seed^ 

    fn
   /   \
  1    fn
      /  \
     2   fn
         /  \
        3    fn
             /   \
            4     fn
                /   \
               5    seed

List.fold_right (-) l1 0
fn = (-)
seed = 0
  from bottom right to top left
  5, -1, 4, -2, 3
  final result = int 3
*)

(* want to take all the elements of the list and
  return the list of the elements greater than 5 *)

let func = fun l ->
  let blah = fun a -> a > 5 in
    List.filter blah l

(* this would return the first element with value greater than 5 *)
let func = fun l ->
  let blah = fun a -> a > 5 in
    List.find blah l
