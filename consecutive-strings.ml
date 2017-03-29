let longestConsec (xs: string list) (k: int): string =
  let xs = Array.of_list xs in
  let n = Array.length xs in
  if n = 0 || k > n || k <= 0 then ""
  else
    let build xs = xs |> Array.to_list |> String.concat "" in
    let xs =
      Array.init (n - k + 1) (fun i -> Array.sub xs i k)
      |> Array.map build in
    Array.sort (fun x y -> - compare (String.length x) (String.length y)) xs;
    xs.(0)
