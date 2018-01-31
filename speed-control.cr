def gps(s, x)
  x.size > 1 ? 3600.0 / s * x.each_cons(2).map{|xs| xs[1] - xs[0]}.max : 0
end
