#!/bin/bash

dependencies=(
 intl
 badges
)

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub remove ${dependencies[i]}
done

flutter pub remove clivia_base

for i in `seq 0 $[${#dependencies[*]}-1]`; do
  flutter pub add ${dependencies[i]}
done

flutter pub add clivia_base --path=../clivia_base

flutter pub get