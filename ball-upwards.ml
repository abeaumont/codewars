let max_ball (v0: int): int =
  let v = (float_of_int v0) /. 3.6
  and g = 9.81 in
  let rec loop tenth max =
    let t = (float_of_int tenth) /. 10. in
    let h = v *. t -. 0.5 *. g *. t *. t in
    if h <= max then tenth - 1
    else loop (tenth + 1) h
  in loop 1 0.0
