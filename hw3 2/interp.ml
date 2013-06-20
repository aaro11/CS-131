
(* Homework 1:  MOCaml interpreter *)


(* EXCEPTIONS *)

(* This is a marker for places in the code that you have to fill in.
   Your completed assignment should never raise this exception. *)
exception ImplementMe of string

(* This exception is thrown to indicate an error during typechecking
   (e.g., a name has not been declared before it is used).
   The string should provide an error message.
*)
exception TypeError of string

(* This exception is thrown when an error occurs during evaluation
   (e.g., attempting to invoke something that's not a function).
   The string should provide an error message.
*)
exception EvalError of string

(* This exception is thrown when pattern matching fails during evaluation. *)  
exception MatchFailure  



(* EVALUATION *)

(* See if a value matches a given pattern.  If there is a match, return
   an environment for any name bindings in the pattern.  If there is not
   a match, raise the MatchFailure exception.

   - only integers match integer patterns, and only if the values agree
   - only booleans match boolean patterns, and only if the values agree
   - any value matches the wildcard pattern
   - any value matches the variable pattern
     and additionally creates a new name binding
   - only tuples match tuple patterns, and only if they have the
     same length and each component value matches the associated pattern
   - otherwise pattern matching failures
   
*)
let rec patMatchOne (pat:mopat) (value:movalue) : moenv =
  match (pat, value) with
      (IntPat(i), IntVal(j)) ->
	if i=j then Env.empty_env() else raise MatchFailure
    | (BoolPat(b1), BoolVal(b2)) ->
	if b1=b2 then Env.empty_env() else raise MatchFailure
    | _ -> raise (ImplementMe "patMatchOne")

(* Match a value to a list of (pattern, expression) pairs.  Return the
   expression corresponding to the first pattern that matches, as well as
   an environment resulting from the match. Raise a MatchFailure exception
   if no pattern matches.  *)
let rec patMatch (l:(mopat * moexpr) list) (value:movalue) : (moexpr * moenv) =
  raise (ImplementMe "patMatch")

(* Evaluate an expression in the given environment.  Raise a MatchFailure if
   pattern matching fails.  Raise an EvalError if any other kind of error
   occurs (e.g., trying to add a boolean to an integer) which prevents evaluation
   from continuing.
*)	      
let rec eval (e:moexpr) (env:moenv) : movalue =
  match e with
      IntConst(c) -> IntVal(c)
    | BoolConst(b) -> BoolVal(b)
      (* Lookup the variable's value in the environment.
	 Raise an EvalError if not found. *)
    | Var(s) -> raise (ImplementMe "variable evaluation")
      (* Functions evaluate to themselves and also keep a copy of their
	 lexical environment. *)
    | Fun(pat, body) -> raise (ImplementMe "function evaluation")
    | Plus(e1,e2) -> raise (ImplementMe "plus evaluation")
      (* Based on the conditional expression's value, either evaluate
	 the "then" or the "else" expression. *)
    | If(cond,thn,els) -> raise (ImplementMe "if evaluation")
      (* Evaluate each component of the tuple and return a tuple value. *)
    | Tuple(es) -> raise (ImplementMe "tuple evaluation")
      (* Evaluate e1 to a value v1, match v1 against pattern p, and then
	 evaluate e2 using any new bindings created by the pattern matching. *)
    | Let((p,e1), e2) -> raise (ImplementMe "let evaluation")
    (* Evaluate e1 to a function f and e2 to an argument v.
       Invoke the first case of f whose pattern is matched by v, using
       any new bindings created by the pattern matching. *)
    | App(e1,e2) -> raise (ImplementMe "application evaluation")
    (* Evaluate the withExp to a value v, and then invoke the body of
       the first case whose pattern is matched by v, using any new
       bindings created by the pattern matching. *)	    
    | Match(withExp, cases) -> raise (ImplementMe "match evaluation")


(* TYPECHECKING *)

(* Determine the type of a pattern and also produce a type environment for
   any names bound in the pattern. You may assume that a pattern never refers
   to the same variable name more than once.

   - an integer pattern has type int
   - a boolean pattern has type bool
   - a wildcard pattern has its declared type
   - a variable pattern has its declared type and adds a name binding
     to the type environment
   - an empty tuple pattern has type unit
   - a non-empty tuple pattern has a tuple type, with component types
     determined by the types of the component patterns
*)
let rec patMatchType (pat:mopat) : (motyp * motenv) =
  match pat with
      IntPat(i) -> (IntType, Env.empty_env())
    | BoolPat(b) -> (BoolType, Env.empty_env())
    | _ -> raise (ImplementMe "patMatchType")


(* Typecheck an expression in the given type environment. Raise a TypeError
   if a type error is found (e.g., trying to use an expression of type bool
   as if it has type int). *)    
let rec tc (e:moexpr) (tenv:motenv) :motyp =
  match e with
      IntConst(c) -> IntType
    | BoolConst(b) -> BoolType
    (* Lookup the variable's type in the environment.
       Raise a TypeError if not found. *)
    | Var(s) -> raise (ImplementMe "variable typechecking")
    | Plus(e1,e2) -> raise (ImplementMe "plus typechecking")
    (* The guard expression must have type boolean, and the
       then and else branches must have the same type. *)
    | If(cond,thn,els) -> raise (ImplementMe "conditional typechecking")
    (* As a special case, the type of the empty tuple is unit. Otherwise,
       the type of a tuple is a tuple type, whose component types are determined
       by the types of the tuple components. *)
    | Tuple(es) -> raise (ImplementMe "tuple typechecking")
    (* Typecheck the pattern, producing the function's argument type.
       Then typecheck the body to determine the result type, using any new
       name bindings from the pattern.  The type of a function is a function
       type. *)
    | Fun(pat, body) -> raise (ImplementMe "function typechecking")
    (* Typecheck e1 and pat, and make sure their types agree.  Then typecheck
       e2 using any new name bindings from the pattern. *)
    | Let((pat,e1), e2) -> raise (ImplementMe "let typechecking")
    (* Typecheck e1 to a function type and e2 to a type t2.  Require t2
       to agree with the function's argument type, and return the function's
       result type as the type of the whole expression. *)
    | App(e1,e2) -> raise (ImplementMe "application typechecking")
    (* Typecheck the "with" expression to a type t.  Typecheck each
       case, which involves typechecking its pattern and then its
       body, the latter using any new bindings from the pattern.  The
       type of each pattern must agree with the type of the "with"
       expression.  The types of each body expression must agree with
       one another. *)
    | Match(withExp, cases) -> raise (ImplementMe "match typechecking")
