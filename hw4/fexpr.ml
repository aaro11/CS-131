(*
 * fexpr.ml
 * Based on code by Chris Stone and Steve Freund
 *)

module Expr : EXPR = struct

  type expr = float * float -> float

  (* the mathematical constant pi *)
  let pi = 4. *. atan 1.

  (* Expression construction *)
  let buildX                           = fun (x,y) -> x
  let buildY                           = fun (x,y) -> y
  let buildSin e                       = fun (x,y) -> sin(pi*.e(x,y))
  let buildCos e                       = fun (x,y) -> cos(pi*.e(x,y))
  let buildAvg((e1:expr), (e2:expr))   = fun (x,y) -> (e1(x,y)+.e2(x,y)) /. 2.0
  let buildTimes((e1:expr), (e2:expr)) = fun (x,y) -> (e1(x,y)*.e2(x,y))


  (* exprToString : expr -> string *)
  let exprToString _ = "unknown"
    
  (* eval : expr -> float*float -> float *)
  let eval e (x,y) =
      e (x,y)

  let sampleExpr =
        buildCos(buildSin(buildTimes(buildCos(buildAvg(buildCos(
	buildX),buildTimes(buildCos (buildCos (buildAvg
        (buildTimes (buildY,buildY),buildCos (buildX)))),
        buildCos (buildTimes (buildSin (buildCos
        (buildY)),buildAvg (buildSin (buildX), buildTimes
        (buildX,buildX))))))),buildY)))

 end
