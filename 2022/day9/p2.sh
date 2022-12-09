#!/usr/bin/env bash

#init rope
declare -a rope
for i in {0..9}; do
  rope[$i]="0 0"
done

#debug=1

while read direction distance; do
  [[ $debug == 1 ]] && echo $direction $distance
  for _ in $(seq $distance); do
    h=${rope[0]}
    head_x=${h% *}
    head_y=${h#* }
    case $direction in
      U) (( head_y += 1 )) ;;
      D) (( head_y -= 1 )) ;;
      R) (( head_x += 1 )) ;;
      L) (( head_x -= 1 )) ;;
    esac
    rope[0]="$head_x $head_y"

    for segment in {1..9}; do
      h=${rope[$((segment - 1))]}
      t=${rope[$segment]}
      head_x=${h% *}
      head_y=${h#* }
      tail_x=${t% *}
      tail_y=${t#* }

      hor_gap=$(( head_x - tail_x ))
      ver_gap=$(( head_y - tail_y ))
      ahg=${hor_gap/-/}
      avg=${ver_gap/-/}

      if [[ $avg -ge 2 ]]; then
        tail_x=$head_x
        tail_y=$(( tail_y + (ver_gap / avg) ))
      elif [[ $ahg -ge 2 ]]; then
        tail_y=$head_y
        tail_x=$(( tail_x + (hor_gap / ahg) ))
      fi

      rope[$segment]="$tail_x $tail_y"

      if [[ $segment == 9 ]]; then
        echo $tail_x $tail_y
      fi
    done
    [[ $debug == 1 ]] && for i in {0..9}; do echo $i: ${rope[$i]}; done
  done
done | sort | uniq | wc -l
