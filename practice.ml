exception Error of string

let rec index lst value =
  if value > (List.length lst)
  then raise (Error "1")
  else (
    let x::xs = lst in
    (match value with
	1 -> x
      | _ -> index xs (value-1))
  )

let revRight lst =
  List.fold_right (fun x y -> y@[x]) lst []

let revLeft lst =
  List.fold_left (fun x y -> y::x) [] lst
 
let fib n = 
  let rec seq ind prev accum =
    (
      match ind with
	1 -> accum
      | _ -> (seq (ind-1) accum (accum+prev))
    ) 
  in (seq n 0 1)

let rec unzip lst =
  match lst with
      [] -> ([], [])
    | (x,y)::xs ->
      let (a,b) = (unzip xs) in 
      (x::a, y::b)

let maxMin (lst : int list) : (int * int) =
  match lst with
      [] -> raise (Error "NOOOO")
    | x::xs -> 
      let h = (List.fold_right 
		 (fun a b ->
		   if a > b
		   then a
		   else b) lst x) in
      let l = (List.fold_right
		 (fun a b ->
		   if a < b
		   then a
		   else b) lst x) in
      (h,l)

module type LLINK = sig
  type linkList
  val head: linkList -> int
  val push: linkList -> int -> linkList
  val remove: linkList -> int -> linkList 
  val length: linkList -> int
  val display: linkList -> int list
  val create: unit -> linkList

end ;;
module  LLink:LLINK  = struct
  type linkList = NULL | NODE of (int * linkList)
 
  let head (ll:linkList) : int =
    match ll with
	NULL -> raise (Error "NULL LIST")
      | NODE (a,b) -> a

  let rec push (ll:linkList) (value:int) : linkList = 
    match ll with
	NULL -> NODE (value, NULL)
      | NODE (a,b) -> NODE(a, (push b value))
	
  let rec remove (ll:linkList) (value:int) : linkList =
    match ll with
	NULL -> raise (Error "Value not found")
      | NODE (a, NULL) -> NULL
      | NODE (a,b) ->
	(if a = value
	then b
	else NODE (a, (remove b value)))

  let rec length (ll:linkList) : int=
    match ll with
	NULL -> 0
      | NODE (a,b) -> 1 + length (b)

  let rec display (ll:linkList) : (int list) = 
    match ll with
	NULL -> []
      | NODE (a,b) -> a::(display b)
    
  let create (a:unit) : linkList = NULL

end ;;
