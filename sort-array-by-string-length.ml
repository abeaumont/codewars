let sort_by_length =
  let cmp x y = compare (String.length x) (String.length y) in
  List.sort cmp
