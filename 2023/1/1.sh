#!/usr/bin/env bash

total=0
while read line; do
  nums="$(echo $line | tr -d '[:alpha:]')"
  first=${nums:0:1}
  last=${nums: -1:1}
  num="${first}${last}"
  total=$((total + num))
done

echo $total
