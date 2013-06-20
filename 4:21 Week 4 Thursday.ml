(* Week 4 Thursday 4/21/11
Parametric  Polymorphism
------
let rec length lst = 
   match lst with
   [] -> 0
   | x::xs -> 1 + (length xs)

how to typecheck (length [1;2;3])?
   - gets the type of length
    - 'a list -> int
   - gets the type of [1;2;3]
    - int list
   - can I find an instantiation of 'a that makes a list equal to int list?
    - 'a = int, YES!

you can think of the type variable as an extra argument

'a is a type variable 
   - can be instatiated with any time
   - this instantiation happens at compile time

key point about parametric polymorphism:
   - one piece of code
   - can be used safely with arguments of several different types

==========
can contrast parametric polymorphism with static overloading:
overloading is opposite of that

key point of overloading:
   - a separate piece of code (function) per type
   - typechecker uses the type of actual arguments to determine which
     piece of code to execute
   - typechcker does this at compile time 

   - overloading a syntactic convenience
    - could just give each function a separate name
==========
Recursion vs. Iteration
why is there more overhead in recursion than iteration?

let rec fact n =
   match n with
     0 -> 1
   | _ -> n * (fact (n-1))

   (fact 3)
[(n,3)]
   n * (fact (n-1))
[(n,2),(n,3)]
   n * (fact (n-1))
[(n,1),(n,2),(n,3)]
   n * (fact (n-1))
[(n,0),(n,1),(n,2),(n,3)]
   1

--> then you unroll upwards (using the environment)
    as you move up, you lose a binding
--> in c, you only update 1 variable
--> in ocaml, your size grows linearly

fortunately, there's a way to make it linear by:
   creating a *tail recursive* version of factorial
 - a *tail call* is a function call that is the last operation done in a function body
 - a function is tail recursive if all recursive calls are tail calls

rewrite factorial in a way it's tail recursive:

let rec trFact n acc =
   match n with
     0 -> acc
   | _ -> trFact (n-1) (n*acc)

[naive]
trFact 3 1                [(n,3),(acc,1)]
   trFact 2 3             [(n,2),(acc,3),(n,3),(acc,1)]
      trFact 1 6          [(n,1),(acc,6),(n,2),(acc,3),(n,3),(acc,1)]
         trFact 0 6       [(n,0),(acc,6),(n,1),(acc,6),(n,2),(acc,3),(n,3),(acc,1)]
             6

OCaml will implement a tail-call optimation for tail-recursive functions
   - reuse the sapce for n and acc on each recursive call

[with tail call optimation]
trFact 3 1                [(n,3),(acc,1)]
   trFact 2 3             [(n,2),(acc,3)]
      trFact 1 6          [(n,1),(acc,6)]
         trFact 0 6       [(n,0),(acc,6)]
             6

--> uses constant space
--> directly sends "6" to the caller
--> ML knows that it's a tail call because it only calls the function at the end


SOMETHING THAT CANT BE TAIL RECURSIVE
-> adding two functions?
-> tree

type bintree = Leaf | Node of bintree * int * bintree

let rec size t =
   match t with
      Leaf -> 0
   | Node(l,n,r) -> size(l) + 1 + size(r)

-> here you can make one of the recursive calls a tail call, but not both

*)
