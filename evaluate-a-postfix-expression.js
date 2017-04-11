const postfixEvaluator = (string) => {
    let stack = [];
    for (const x of string.split(' ')) {
        if (isNaN(x)) {
            const b = stack.pop(x);
            const a = stack.pop(x);
            switch (x) {
            case '+': stack.push(a + b); break;
            case '-': stack.push(a - b); break;
            case '*': stack.push(a * b); break;
            case '/': stack.push(Math.floor(a / b)); break;
            }
        } else {
            stack.push(parseInt(x));
        }
    }
    return stack.pop();
};
