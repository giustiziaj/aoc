#!/usr/bin/env python3

#get input file as a matrix of ints
with open('input') as infile:
    trees = [list([int(c) for c in line.strip()]) for line in infile.readlines()]

visible_trees = set()

# looking from right edge
for y, row in enumerate(trees):
    tallest = -1
    for x, tree in enumerate(row):
        if tree > tallest:
            tallest = tree
            visible_trees.add((x, y))

# looking from left edge

for y, row in enumerate(trees):
    tallest = -1
    for x, tree in reversed(list(enumerate(row))):
        if tree > tallest:
            tallest = tree
            visible_trees.add((x, y))

# looking from top edge
for x in range(len(trees[0])):
    column = [row[x] for row in trees]
    tallest = -1
    for y, tree in enumerate(column):
        if tree > tallest:
            tallest = tree
            visible_trees.add((x, y))

# looking from bottom edge
for x in range(len(trees[0])):
    column = [row[x] for row in trees]
    tallest = -1
    for y, tree in reversed(list(enumerate(column))):
        if tree > tallest:
            tallest = tree
            visible_trees.add((x, y))

print(len(visible_trees))
