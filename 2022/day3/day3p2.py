#!/usr/bin/env python3

from itertools import islice

def priority(c):
    if c.islower():
        return ord(c) - ord('a') + 1
    if c.isupper():
        return ord(c) - ord('A') + 27

score = 0

with open('input') as infile:
    while True:
        elves = list(islice(infile, 3))
        if not elves:
            break
        elf = list(dict.fromkeys(elves[0][:-1]))
        for item in elf:
            if item in elves[1][:-1] and item in elves[2][:-1]:
                score += priority(item)

print(score)

