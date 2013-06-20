
module type SET = sig
    type 'a t
    val emptyset : 'a t
    val contains : 'a -> 'a t -> bool
    val addElem : 'a -> 'a t -> 'a t
end

module Set:SET = struct
  type 'a t = 'a list

  let emptyset = []

  let contains e lst = List.mem e lst

  let addElem e lst =
    if contains e lst
    then lst
    else e::lst

end
