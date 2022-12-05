#!/usr/bin/env bash

infile="$1"

divider="$(grep --line-number -x '^$' $infile | cut -d: -f1)"

operations="$(mktemp)"

tail -n "+$((divider + 1))" "$infile" > "$operations"

declare -a stacks

init_stacks(){
  before_state=$(mktemp)
  head -n $(( divider - 1 )) "$infile" | 
    sed 's/\]/ /g;s/\[/ /g' | # strip brackets
    sed 's/  / |/g; s/| |/|  /g'| # write in separators
    tac > "$before_state"
  # at this point the before state is a flipped version of the 
  # one in the input with the brackets stripped.  table alignment
  # is still preserved, and the first line is the stack index
  # each stack is separated by a pipe character

  for i in {1..9}; do
    stacks[i]="$(echo $(tail -n +2 $before_state | cut -d\|   -f $i) | sed 's/ //g')"
  done
}

move() {
  local quantity=$1
  local from_stack=$2
  local to_stack=$3

  src=${stacks[$from_stack]}
  move_stack=${src: -$quantity}
  if [[ $move_stack = "" ]]; then return; fi #weird edge case with string slicing in bash
  
  stacks[$from_stack]=${src%${move_stack}}
  stacks[$to_stack]=${stacks[$to_stack]}${move_stack}
}

init_stacks

while read _ x _ y _ z; do
  move $x $y $z
done < $operations

for i in {1..9}; do
  echo $i ${stacks[${i}]}
done
