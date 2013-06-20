(* TYPES *)
  
(* The representation of MOCaml types

  t ::= int | bool | unit | t -> t | (t * ... * t)

  Note: parens are required around a tuple type
*)
type motyp =
    IntType
  | BoolType
  | UnitType
  | FunType of motyp * motyp
  | TupleType of motyp list
;;

(* The representation of type environments, which map strings to
types.  See env.ml for the definition of the Env.env type and
associated operations. *)
type motenv = motyp Env.env;;

(* The representation of MOCaml patterns.

  p ::= intconst | boolconst | (_:t) | (var:t) | (p1,...,pn)

  Wildcard and variable patterns include an explicit type provided by
  the programmer, so that we can determine the type of a pattern
  without requiring type inference.
*)
type mopat =
    IntPat of int
  | BoolPat of bool
  | WildcardPat of motyp
  | VarPat of string * motyp
  | TuplePat of mopat list
;;

(* The representation of MOCaml expressions.
   
e ::= intconst | boolconst | var | e1 + e2 | if e1 then e2 else e3
       | (e1,...,en) | let p1=e1 in e2 | function p -> e | e1 e2
       | match e with p1 -> e1 '|' ... '|' pn -> en
*)   
type moexpr =
    IntConst of int
  | BoolConst of bool
  | Var of string
  | Plus of moexpr * moexpr
  | If of moexpr * moexpr * moexpr
  | Tuple of moexpr list
  | Let of (mopat * moexpr) * moexpr
  | Fun of mopat * moexpr      
  | App of moexpr * moexpr
  | Match of moexpr * (mopat * moexpr) list
;;

(* The representation of MOCaml values.
   
  v ::= intconst | boolconst | function p -> e | (v1,...,vn)
*)
type movalue =
    IntVal of int
  | BoolVal of bool
      (* A function value carries its lexical environment with it! *)
  | FunVal of mopat * moexpr * moenv
  | TupleVal of movalue list

(* The representation of value environments, which map strings to
values.  See env.ml for the definition of the Env.env type and
associated operations. *)
and moenv = movalue Env.env;;
