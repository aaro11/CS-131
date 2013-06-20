
(* You don't need to understand or modify anything in this file *)

(* PRETTY PRINTING *)

(* Print a 'sep'-separated list of things. *)	    
let rec print_lst (f:'a -> string) (l:'a list) (sep:string) :string =
  match l with
      [] -> ""
    | [x] -> (f x)
    | x::xs -> (f x) ^ sep ^ print_lst f xs sep
	    
let rec print_typ (t:motyp) :string =
  match t with
      IntType -> "int"
    | BoolType -> "bool"
    | UnitType -> "unit"
    | FunType(t1,t2) ->
	"(" ^ print_typ t1 ^ " -> " ^ print_typ t2 ^ ")"
    | TupleType(ts) ->
	"(" ^  print_lst print_typ ts " * " ^ ")"


let rec print_val (v:movalue) :string =
  match v with
      IntVal(i) -> string_of_int i
    | BoolVal(b) -> string_of_bool b
    | FunVal(_) -> "<fun>"
    | TupleVal(vs) ->
	"(" ^ print_lst print_val vs ", " ^ ")"
  

(* ENTRY POINT *)	  

(* Typecheck and evaluate the given expression, and return a string
   representation of the results. *)
let doit (e:moexpr) :string =
  let t =
    (* allow testing of evaluation before typechecking has been implemented *)
    try
      print_typ (tc e (Env.empty_env()))
    with
	ImplementMe s -> "<" ^ s ^ " is not yet implemented>"
  in
  let v = print_val (eval e (Env.empty_env())) in
    "- : " ^ t ^ " = " ^ v
      
let readEvalPrint() =
  let _ = print_string "mocaml# "; flush stdout in
  let lexbuf = Lexing.from_channel stdin in
  let result = main token lexbuf in
    print_string (doit result); print_newline(); flush stdout

let repl() =
  print_newline();
  print_string "**********Welcome to MOCaml!**********";
  print_newline(); flush stdout;
  while true do
    try
      readEvalPrint()
    with
	Eof ->
	  exit 0
      | Parsing.Parse_error ->
	  print_string "parse error";
	  print_newline(); flush stdout
      | TypeError(s) ->
	  print_string ("type error: " ^ s); 
	  print_newline(); flush stdout
      | EvalError(s) ->
	  print_string ("evaluation error: " ^ s); 
	  print_newline(); flush stdout
      | MatchFailure ->
	  print_string "match failure";
	  print_newline(); flush stdout
      | ImplementMe(s) ->
	  print_string (s ^ " is not yet implemented");
	  print_newline(); flush stdout
  done

let _ = repl()
