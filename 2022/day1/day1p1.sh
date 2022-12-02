#!/usr/bin/env bash

tally=0

while read line; do
  if [[ $line == "" ]]; then
    echo $tally
    tally=0
    continue
  fi
  ((tally += line))
done | sort -n | tail -1

