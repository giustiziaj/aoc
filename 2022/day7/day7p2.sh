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

dirsizes=$(mktemp)

while read d; do
  size=0
  while read f; do
    content=$(cat $f)
    (( size += content ))
  done < <(find "$d" -type f)
  echo $size $d
done < <(find "$prefix" -type d) | sort -nr > "$dirsizes"

root_usage="$(head -1 $dirsizes | cut -f1 -d' ')"

while read size dir; do
  if [[ $(( root_usage - size )) -lt 40000000 ]]; then echo $size $dir; fi
done < $dirsizes


