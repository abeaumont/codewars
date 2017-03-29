let powersOfTwo n =
  let rec loop i pow =
    if i > n then []
    else pow :: loop (i + 1) (pow * 2)
  in loop 0 1
