#!/bin/bash

DIR=$(which cowsay)
COWLIST=$(cowsay -l|cut -d: -f2-|sed '/^$/d')
WORDS=$(echo "$COWLIST"|wc --words)
COWS=( $COWLIST )
NMBR=0

for i in "${COWS[@]}"; do
  fortune|cowsay -f $i|lolcat
  sleep 5
  NMBR+=1;
done

