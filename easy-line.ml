let easyline(n:int): string =
  let open Core.Std in
  let open Big_int in
  let n1 = n + 1 in
  let rec fac x =
    x + 1 |> List.range 1
    |> List.fold ~f:(fun x y -> mult_int_big_int y x) ~init:(big_int_of_int 1) in
  let (+) = add_big_int
  and ( * ) = mult_big_int
  and ( ** ) = power_big_int_positive_int
  and (/) = div_big_int in
  let binomial k = (fac n / (fac k * fac (n - k))) in
  List.range 0 n1
  |> List.map ~f:(fun x -> (binomial x) ** 2)
  |> List.fold ~f:(+) ~init:(big_int_of_int 0)
  |> string_of_big_int
