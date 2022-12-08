#!/usr/bin/env python3

#get input file as a matrix of ints
with open('input') as infile:
    trees = [list([int(c) for c in line.strip()]) for line in infile.readlines()]

most_scenic = 0

for x, y in [(x, y) for x in range(len(trees[0])) for y in range(len(trees))]:
    if x == 0 or y == 0 or x == (len(trees[0]) - 1) or y == (len(trees) - 1):
        continue

    height = trees[y][x]
    scenic = 1

    # look left
    distance = 1
    while x - distance > 0:
        if trees[y][x - distance] >= height:
            break
        distance += 1
    scenic *= distance

    print(f'{x} {y}: l {distance}')
    # look right
    distance = 1
    while x + distance < len(trees[0])-1:
        if trees[y][x + distance] >= height:
            break
        distance += 1
    scenic *= distance

    print(f'{x} {y}: r {distance}')
    # look up
    distance = 1
    while y - distance > 0:
        if trees[y - distance][x] >= height:
            break
        distance += 1
    scenic *= distance

    print(f'{x} {y}: u {distance}')
    # look down
    distance = 1
    while y + distance < len(trees)-1:
        if trees[y + distance][x] >= height:
            break
        distance += 1
    scenic *= distance

    print(f'{x} {y}: d {distance}')
    print(f'{x} {y}: s {scenic}')

    most_scenic = max(most_scenic, scenic)

print(most_scenic)

