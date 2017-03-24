let max_ball (v0: int): int =
   let time = (((float v0) /. 3.6) /. 9.81) *. 10. in
   int_of_float (time +. 0.5)
