#!/usr/bin/env bash

rps_move() {
  # now decodes opp move and desired result from line
  local opp=$1
  local player=$2

  case $opp in
    A) oppmove='ROC' ;;
    B) oppmove='PAP' ;;
    C) oppmove='SCI' ;;
  esac

  case $player in
    X) result='LOSS' ;;
    Y) result='DRAW' ;;
    Z) result='WIN' ;;
  esac

  echo $oppmove $result
}

get_playermove() {
  # function to figure out which move is needed based on opp move and
  # desired result
  oppmove=$1
  result=$2
  
  case $result in
    DRAW)
      echo $oppmove ;;
    WIN)
      case $oppmove in 
        ROC) echo PAP ;;
        PAP) echo SCI ;;
        SCI) echo ROC ;;
      esac ;;
    LOSS)
      case $oppmove in
        ROC) echo SCI ;;
        PAP) echo ROC ;;
        SCI) echo PAP ;;
      esac ;;
  esac
  return 0
}

score=0

while read line; do
  # decode line, determine player move.  rest is unchanged
  moves=($(rps_move $line))
  oppmove=${moves[0]}
  result=${moves[1]}
  playermove=$(get_playermove $oppmove $result)

  case $playermove in
    ROC) ((score += 1));;
    PAP) ((score += 2));;
    SCI) ((score += 3));;
  esac

  if [[ $playermove == $oppmove ]]; then
    ((score += 3))
    continue
  fi

  compete=${playermove}${oppmove}
  if [[ $compete == 'ROCSCI' ]] || 
     [[ $compete == 'PAPROC' ]] ||
     [[ $compete == 'SCIPAP' ]]; then
    ((score += 6))
  fi

done
echo $score
