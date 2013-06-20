
(* exceptions in ML

a structured way to signal an error to the caller
 - allows the caller to deal with the error
 - can't confuse the error from a normal result

*)

exception NotFound of string

let rec assoc k assocL =
  match assocL with
      [] ->
	raise (NotFound "no value for key")
    | (key,v)::rest ->
	if key=k then v else (assoc k rest)
	  
(* try e with exn1 -> e1 | ... | exnN -> eN
*)

let addBindingIfNotAlreadyThere k v assocL =
  try 
    let _ = assoc k assocL in
      assocL
  with
      NotFound -> (k,v)::assocL
(*    | AnotherExn -> ...
      | ... 
*)	
