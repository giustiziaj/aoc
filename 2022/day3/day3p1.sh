#!/usr/bin/env bash
# GAVE UP AND USED PYTHON
# I could've done it in bash but it would have taken my whole saturday

# init letters lookup table because bash can't coerce chars to ints :/
letters="$(mktemp)"
cat <(echo -ne {a..z}\\n) <(echo -ne {A..Z}\\n) > "$letters"

get_priority() {
  grep --line-number "$1" | cut -d: -f1
}

# splits line into left and right half
split_line() {
  local line=$1
  local len=${#line}
  local half=$(( len / 2 ))
  echo "${line:0:$half}" "${line:$half:$len}"
}


