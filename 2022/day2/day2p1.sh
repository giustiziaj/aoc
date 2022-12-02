#!/usr/bin/env bash

rps_move() {
  # function to decode RPS moves from line
  local opp=$1
  local player=$2

  case $opp in
    A) oppmove='ROC' ;;
    B) oppmove='PAP' ;;
    C) oppmove='SCI' ;;
  esac

  case $player in
    X) playermove='ROC' ;;
    Y) playermove='PAP' ;;
    Z) playermove='SCI' ;;
  esac

  echo $oppmove $playermove
}

score=0

while read line; do
  # decode line, split into array, name elements of array
  moves=($(rps_move $line))
  oppmove=${moves[0]}
  playermove=${moves[1]}

  # score for player's move
  case $playermove in
    ROC) ((score += 1));;
    PAP) ((score += 2));;
    SCI) ((score += 3));;
  esac


  # scoring competition: draw is early return, wins are hardcoded, loss is unnecessary
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
