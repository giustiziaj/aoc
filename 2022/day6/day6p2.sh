#!/usr/bin/env bash

while read line; do
  buffer=${line:0:14}
  for i in $(seq 14 ${#line}); do
    echo $i: $buffer
    flag=0
    for j in {0..12}; do
      char=${buffer:$j:1}
      if [[ $buffer == *${char}*${char}* ]]; then
        flag=1
        break
      fi
    done
    if [[ $flag == 0 ]]; then exit 0; fi
    buffer=${buffer:1:13}${line:$i:1}
  done
done
