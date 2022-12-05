#!/usr/bin/env bash

counter=0

buffer=$(mktemp)

sed 's/,/ /g' | sed 's/-/ /g' > $buffer

while read first_start first_end second_start second_end; do
  if [[ $first_start -le $second_start ]] && [[ $first_end -ge $second_end ]]; then
    (( counter += 1 ))
  elif [[ $first_start -ge $second_start ]] && [[ $first_end -le $second_end ]]; then
    (( counter += 1 ))
  fi

done < $buffer

echo $counter
