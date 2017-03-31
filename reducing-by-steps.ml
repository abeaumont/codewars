let som = (+)

let gcdi u v =
  let rec gcd u v = if v = 0 then u else gcd v (u mod v)
  and au = abs u
  and av = abs v
  in gcd (max au av) (min au av)

let lcmu m n = (abs (m * n)) / (gcdi m n)

let maxi = max

let mini = min

let oper fct arr init =
  List.fold_left (fun xs x -> (fct (List.hd xs) x) :: xs) [init] arr
  |> List.rev |> List.tl
