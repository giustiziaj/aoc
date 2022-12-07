#!/usr/bin/env bash

prefix=$(mktemp -d)
cwd=$prefix

# create actual filesystem model in TEMPDIR 
while read line; do
  case "$line" in
    "$ cd"*) cwd=$cwd/${line/'$ cd '/} ;;
    "dir "*) mkdir "$cwd/${line/'dir '/}" ;;
    "$ ls") continue ;;
    *) echo "${line% *}" > "$cwd/${line#* }" ;;
  esac
done

total=0

while read d; do
  size=0
  while read f; do
    content=$(cat $f)
    (( size += content ))
  done < <(find "$d" -type f)
  if [[ $size -le 100000 ]]; then (( total += size )); fi
done < <(find "$prefix" -type d)

echo $total

