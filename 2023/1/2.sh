#!/usr/bin/env bash

buffer=$(mktemp)

sed 's/one/one1one/g;s/two/two2two/g;s/three/three3three/g;s/four/four4four/g;s/five/five5five/g;s/six/six6six/g;s/seven/seven7seven/g;s/eight/eight8eight/g;s/nine/nine9nine/g' < input > "$buffer"

total=0
while read line; do
  nums="$(echo $line | tr -d '[:alpha:]')"
  first=${nums:0:1}
  last=${nums: -1:1}
  num="${first}${last}"
  total=$((total + num))
  echo $num
done < "$buffer"

echo $total
