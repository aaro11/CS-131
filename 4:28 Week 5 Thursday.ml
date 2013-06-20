(* Week 5 Thursday 

HOW TO STUDY:
1. reread notes
2. do practice problems
3. understand concepts
 -> currying, tail recursive

possible exam questions:
1. scoping
2. polymorphism
3. higher order functions * 
4. types
5. tail recursion
   -> take a problem, make it tail recursive > turn solved problem
   -> "solve this problem with tail recursion" > create solution with tail recursion
 NEED:
 1. one rec call
 2. having an accumulator   

6. matching style problems (patMatchOne, etc...)
7. fold right, fold left
8. modules
===========
STATIC VS LEXICAL SCOPING
 -> variables refer to nearest enclosing definition of that variable


DYNAMIC SCOPING
 -> variable that refers to nearest enclosing definition at the point of use
===========
TYPES
 -> purpose of checking types:
   1. catch errors early

   STATIC VS DYNAMIC TYPECHECKING
    -> dynamic is runtime checking
    -> static is before
-> disadvantages of static
   1. overhead during compilation
   2. 
 -> advantages of static
   1. program will run as planned

-> disadvatages of dynamic
   1. overhead during runtime, not compile time
   2. 
 -> advantages of dynamic
   1. more precise

STRONG VS WEAK LANGUAGE
Strong:
1. must declare a type before using it
2. can never have a function execute with parameters of the wrong type
Weak:
1. some variables in place of others 
   -> sometimes errors get through in these type of languages
   -> eg. 32bit vs 64bit pointers

'a -> ANYTHING
============
PARAMETRIC POLYMORPHISM
   *'a -> ANYTHING
   "syntactic convenience"

   1. overloading

============
CURRYING
   -> functions that return functions
   -> uncurry/curry functions in the hw

simple example:
   let divide (x,y) = y/x
 -> to curry
   let divide x y = y / x

=============
MODULES
   Benefits:
   1. give encapsulation 
   2. flexibility 
   3. enforce "rules"
   4. hide data types

module stack
*)
