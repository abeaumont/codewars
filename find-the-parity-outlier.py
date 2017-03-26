def find_outlier(integers):
    is_even = lambda x: x % 2 == 0
    is_odd = lambda x: not is_even(x)
    (a, b) = integers[:2]
    if is_even(a) and is_even(b):
        even = True
    elif is_odd(a) and is_odd(b):
        even = False
    else:
        even = is_even(integers[2])
    for n in integers:
        if even and is_odd(n) or not even and is_even(n):
            return n
    return None
