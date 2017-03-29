let rec last = function
    [] -> None
  | [x] -> Some x
  | x :: xs -> last xs
