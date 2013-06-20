
type mltype =
    IntType | BoolType

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
      (* let (v:t) = e1 in e2 *)
  | Let of (string * mltype * mlexp) * mlexp
      
(* a *value* is the legal result of a computation *)

type mlval =
    IntVal of int
  | BoolVal of bool


exception TypeError of string

let rec tc (e:mlexp) (tenv: (string * mltype) list) : mltype =
  match e with 
      Int n -> IntType
    | Bool b -> BoolType
    | Not e0 -> 
      let t0 = tc e0 tenv in
        (match t0 with
	    BoolType -> BoolType
	  | _ -> raise (TypeError "can only negate booleans")
    | Var x -> 
        (try
	   List.assoc x tenv
	 with
	     Not_found -> raise (TypeError "variable not declared"))
    | Let((x,t,e1), e2) ->
      let t1 = tc e1 tenv in
        if t=t1 then
	  tc e2 ((x,t)::tenv)
	else 
	  raise (TypeError "variable and value don't agree on types")

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
    | Let((x,t,e1),e2) ->
	let v1 = eval e1 env in
	  eval e2 ((x,v1)::env)
