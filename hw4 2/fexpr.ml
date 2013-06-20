(*
 * fexpr.ml
 * Based on code by Chris Stone and Steve Freund
 *)

module Expr : EXPR = struct

  type expr = float * float -> float

  (* the mathematical constant pi *)
  let pi = 4. *. atan 1.

  (* Expression construction *)
  let buildX                           = (+.)
  let buildY                           = (+.)
  let buildSin e                       = (+.)
  let buildCos e                       = (+.)
  let buildAvg((e1:expr), (e2:expr))   = (+.)
  let buildTimes((e1:expr), (e2:expr)) = (+.)


  (* exprToString : expr -> string *)
  let exprToString _ = "unknown"
    
  (* eval : expr -> float*float -> float *)
  let eval e (x,y) = 0.0
	
  let sampleExpr =
        buildCos(buildSin(buildTimes(buildCos(buildAvg(buildCos(
	buildX),buildTimes(buildCos (buildCos (buildAvg
        (buildTimes (buildY,buildY),buildCos (buildX)))),
        buildCos (buildTimes (buildSin (buildCos
        (buildY)),buildAvg (buildSin (buildX), buildTimes
        (buildX,buildX))))))),buildY)))

 end
