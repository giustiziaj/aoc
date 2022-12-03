#!/usr/bin/env python3

def priority(c):
    if c.islower():
        return ord(c) - ord('a') + 1
    if c.isupper():
        return ord(c) - ord('A') + 27

score = 0

with open('input') as infile:
    for line in infile:
        compartment_1 = list(dict.fromkeys(line[:int(len(line)/2)]))
        compartment_2 = list(dict.fromkeys(line[int(len(line)/2):]))
        for item in compartment_1:
            if item in compartment_2:
                score += priority(item)
print(score)

