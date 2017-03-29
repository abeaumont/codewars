def parse(town, data):
    lines = filter(lambda x: x.startswith(town + ':'), data.split('\n'))
    if not lines: return []
    fields = lines[0][len(town) + 1:].split(',')
    return map(lambda x: float(x.split(' ')[1]), fields)

_mean = lambda xs: sum(xs) / len(xs) if xs else -1
mean = lambda town, data: _mean(parse(town, data))

def variance(town, strng):
    xs = parse(town, strng)
    if not xs: return -1
    mean = _mean(xs)
    return sum(map(lambda x: (x - mean) ** 2, xs)) / len(xs)
