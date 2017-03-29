const e1 = input => r1(e2(input));

const r1 = ({s: input, v: a}) => {
  if (input.length > 0 && input[0] == '+' || input[0] == '-') {
    const {s, v} = e2(input.substr(1));
	  return r1({s, v: input[0] == '+' && a + v || a - v});
  }
  return {s: input, v: a};
};

const e2 = input => r2(e3(input));

const r2 = ({s: input, v: a}) => {
  if (input.length > 0 && input[0] == '*' || input[0] == '/') {
  	const {s, v} = e3(input.substr(1));
	  return r2({s, v: input[0] == '*' && a * v || a / v});
  }
  return {s: input, v: a};
};

const e3 = input => {
  if (input[0] == '-') {
    const {s, v} = e4(input.substr(1));
    return {s, v: -v};
  }
  return e4(input);
};

const e4 = input => {
  if (input[0] == '(') {
  	const {s, v} = e1(input.substr(1));
	  if (s[0] == ')') {
	    return {s: s.substr(1), v};
  	}
	  throw "Unexpected token: Expected ), found " + s[0];
  }
  if (is_digit(input[0])) {
  	return number(input);
  }
  throw "Invalid token for e4: " + input[0];
};

const is_digit = c => c >= '0' && c <= '9';

const number = input => {
  let li = 0;
  let vi = 0;
  let lf = 0;
  let vf = 0;
  while (is_digit(input[li])) {
  	vi = vi * 10 + (input[li] - '0');
	  li += 1;
  }
  if (input[li] == '.') {
    lf = 1;
    let m = .1;
    while (is_digit(input[li + lf])) {
      vf += m * (input[li + lf] - '0');
      m *= .1;
      lf += 1;
    } 
  }
  return {s: input.substr(li + lf), v: vi + vf};
}

const calc = e => e1(e.replace(/ /g, '')).v;
