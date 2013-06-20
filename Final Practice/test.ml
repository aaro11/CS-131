let rec fib (num: int) : int =
  match num with
      0 -> 1
    | 1 -> 1
    | x -> fib(x-1) + fib(x-2)

let rec clone (str, num) =
  match num with
      0 -> []
    | _ -> str::(clone (str, num-1))

(* let rec allPos (lst: int list) : int list =
  match lst with
      [] -> []
    | x::xs -> if x > 0 then x::allPos(xs) else allPos(xs) *)

let rec everyOther (lst: 'a list) : 'a list =
  match lst with
      [] -> []
    | x::y::xs -> x::everyOther(xs)
    | x::xs -> [x]

let rec tails (lst: 'a list) : 'a list list =
  match lst with
      [] -> [[]]
    | x::xs -> [x::xs]@tails(xs)

let allPos (lst: int list) : int list=
  List.fold_right (fun x y -> if x > 0 then x::y else y) lst []
 
