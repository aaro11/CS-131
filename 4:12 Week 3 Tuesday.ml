(*
(*
WEEK 3 MONDAY

SCOPING
=====

For a given reference to (or use of) a variable, which declaration does it refer to?

~ We keep an *environment*, a map from variable names to their values

- global declarations
env = [] --> environment is empty
  let x = 3;;
env = [(x,3)] 
  let double n = n*2;;
  let double = (function n -> n*2)
env = [(double, <fun>), (x,3)] --> double is this particular function

- local declarations (static scoping)
//env = [(double, <fun>), (x,3)]
  let y = 3 in
//env = [(y,3), (double, <fun>), (x,3)]
    y+x
//env = [(double, <fun>), (x,3)]

# let x = x+1 in x+1;;
- : int = 5

  let x = e1 in e2
  - x is only in scope in e2

  let rec x = e1 in e2
  - x in scope in both e1 and e2

- function parameters
  - n in the double function above

env = [(double, (function n -> n*2)), (x,3)]
  double 5
env = [(n,5), (double, (function n -> n*2)), (x,3)]
  n * 2
env = [(double, (function n -> n*2)), (x,3)]

  (function x -> e)
   - x is only in scope in e

in general, you can declare a pattern instead of a variable, 
  and they all have the same scope
In all cases above, can generalize x to an arbitrary pattern p

let (x,y) in x + y...

- match expressions
  match e with
  p1 -> e1
  | ...
  | pn -> en

*STATIC (LEXICAL) SCOPING*
- a variable use refers to the nearest enclosing definition
  of that variable

(block structuring)
env = []
  let x = 45;;
env = [(x, 45)]
  let f = (function y -> x + y);;
env = [(f, function y -> x + y, [(x, 45)]), (x, 45)]
  f 3;;
  1. grab the lexical (static) environment of f
  [(x, 45)]
  2. add bindings from formals to actuals
  env = [(y,3), (x, 45)]
  ---> evaluate x + y
env = [(f, function y -> x + y), (x, 45)]
  let x = 12;;
env = [(x, 12), (f, function y -> x + y), (x, 45)]
  f 3;;
  - same process as for the first call
  env = [(y,3), (x,45)]
  --> evaluate x+y
> for the homework, copy the whole environment


Another example:

env = []
  let add = (function x -> (function y -> x + y))
  // same as let add x y = x + y
env = [(add, (<fun>, []))]
  add 3 4 // same as (add 3) 4
  1. evaluate (add 3)
     evaluate body of add
     env = [(x,3)] // this gives us...
     (function y -> x + y)
     that evaluates to
     ((function y->x + 3), [(x, 3)])
  2. invoke the above function on 4
     [(y,4),(x,3)]
     evaluate x+y 

=============================
Types
====

What is a type?

- a set of values, along with operations on a those values
- int is the set of 32-bit integers, with operations +,-,<

- int * bool
  - pairs of integers and booleans
  (3, true)
--> things you can do
  grab an element of the pair

- int list
  - integer lists
--> things you can do
  cons, head, tails

- int -> bool
  - functions from integers to bools
--> things you can do
  invoke

Goal of typechecking: ensure that each value is only ever 
manipulated consistently with its type
  - dynamically, each operation to be invoked on values of the proper types

* Static vs. dynamic typechecking *
  - static typechecking means that each program expression is 
    given a type at compile time (before the program is even run)
    - same as C, C++, Java, ML
 > guarantees types work

  - dynamic typechecking means that at runtime you ensure that a primitive
  operation (e.g., +, taking the head of a list) is only ever invoked on
  values of the right type
    - exactly what our evaluator does
    - Python, Lisp, Perl, JavaScript, PHP, Ruby
 > doesn't necessarily guarantee work

Advantages/ Disadvantages
 - static gives early feedback on possible errors
 - static TC is modular 
   - you don't need the whole program to give feedback
     on possible errors )
   - can typecheck a function independtly of its callers
 - static is conservative

 - dynamic typechecking is more precise
   - only signals error when there really is an error
   - (if true then 0 else "hi") + 4
     - in ML, a list is *homogeneous* -- all elements have the same type
       - ameliorated by things like tuples and user-defined types
         - type intorbool = Int of int | Bool of bool;
   - has a run-time cost

*)
