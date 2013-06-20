
(* the syntax of expressions:
mlexp ::= n | b | not mlexp | x | let x = mlexp in mlexp
n ::= int constant
b ::= boolean constant
x ::= variable
*)

(* not (not true)
   represented by the tree
   Not(Not (Bool true))
*)   
type mlexp =
    Int of int
  | Bool of bool
  | Not of mlexp
  | Var of string
      (* let v = e1 in e2 *)
  | Let of string * mlexp * mlexp
      
(* a *value* is the legal result of a computation *)

type mlval =
    IntVal of int
  | BoolVal of bool

exception EvalError

(* we need an environment that represents the current scope *)
(* we'll represent it as a map from strings to mlvals *)
  
let rec eval (e:mlexp) (env : (string*mlval) list) : mlval =
  match e with
      Int n -> IntVal n
    | Bool b -> BoolVal b
    | Not e0 ->
	let v0 = eval e0 env in
	  (match v0 with
	       IntVal n -> raise EvalError
	     | BoolVal b -> BoolVal (not b))
    | Var x ->
	(try
	   List.assoc x env
	 with
	     Not_found -> raise EvalError)
    | Let(x,e1,e2) ->
	let v1 = eval e1 env in
	  eval e2 ((x,v1)::env)
	    
