
module Point = struct
  type point = P of int * int
  let makePoint (x,y) = P (x,y)
    
  let distSquared (P (x,y)) = x*x + y*y
end;;
