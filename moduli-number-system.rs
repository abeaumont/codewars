fn gcd(a: i64, b: i64) -> i64 {
  if a < b {
    gcd(b, a)
  } else if b == 0 {
    a
  } else {
    gcd(b, a % b)
  }
}

fn from_nb_2str(n: i64, sys: Vec<i64>) -> String {
  // Check the product is greater than n
  if sys.iter().product::<i64>() <= n {
    return "Not applicable".to_string()
  }

  // Check if all the moduli are coprime
  for i in 0 .. sys.len() {
    for j in i + 1 .. sys.len() {
      if gcd(sys[i], sys[j]) > 1 { return "Not applicable".to_string() }
    }
  }

  sys.iter()
    .map(|&x| format!("-{}-", n % x))
    .collect::<Vec<String>>()
    .join("")
}
