
#use "env.ml";;
#use "ast.ml";;
#use "parser.ml";;
#use "lexer.ml";;
#use "interp.ml";;

(* put your tests for the eval function here:
   each test is a pair of an input expression and the expected output value,
   both expressed as a string.
   use the string "EvalError" if an EvalError is expected to be raised.
   use the string "MatchFailure" if a MatchFailure is expected to be raised.
   use the string "ImplementMe" if an ImplementMe exception is expected to be raised

   call the function testEval() to run these tests
*)
let evalTests = [("3", "3"); ("true", "true"); ("let (x:int) = 4 in x+5", "9");
		("true + 4", "EvalError")]

(* put your tests for the tc function here:
   each test is a pair of an input expression and the expected output type,
   both expressed as a string.
   use the string "TypeError" if a TypeError is expected to be raised.
   use the string "ImplementMe" if an ImplementMe exception is expected to be raised 

   call the function testTC() to run these tests
*)
let tcTests = [("3", "int"); ("true", "bool"); ("let (x:int) = 4 in x+5", "int");
	       ("true + 4", "TypeError")]

  
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

(* The Test Harness *)	  
  
let testOne (test, expectedResult)  testF =
  try
    let expr = main token (Lexing.from_string (test^";;")) in
    testF expr
  with
      Parsing.Parse_error -> "parse error"

let testF f e =
  try
    f e
  with
      EvalError s -> "EvalError"
    | MatchFailure -> "MatchFailure"
    | TypeError s -> "TypeError"
    | ImplementMe s -> "ImplementMe"
      
let test f tests =
  let results =
    List.map
      (function pair -> testOne pair (testF f))
      tests
  in
  List.iter2
    (fun (t,er) r ->
      let out = if er=r then "ok" else "expected " ^ er ^ " but got " ^ r in
      print_endline
	(t ^ "....................." ^ out))
      tests results

(* CALL THESE FUNCTIONS TO RUN THE TESTS *)
let testEval () = test (fun e -> print_val (eval e (Env.empty_env()))) evalTests
let testTC () = test (fun e -> print_typ (tc e (Env.empty_env()))) tcTests
  
