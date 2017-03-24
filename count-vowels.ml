let count_vowels =
  let open Core.Std in
  let vowels = Set.of_list ~comparator:Char.comparator ['a';'e';'i';'o';'u'] in
  let is_vowel = Set.mem vowels in
  String.fold ~f:(fun n c -> if is_vowel c then n + 1 else n) ~init:0
