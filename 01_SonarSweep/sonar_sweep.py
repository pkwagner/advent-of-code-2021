from functools import partial

with open("input.txt", "r") as f:
    input = [int(x) for x in f.readlines()]

solve = lambda offset: sum(y > x for x, y in zip(input, input[offset:]))
part1 = partial(solve, 1)
part2 = partial(solve, 3)
