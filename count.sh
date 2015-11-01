#!/bin/sh

SPACE='      '
START_TIME=`date +%s`
seconds=0

while getopts as:m:h: OPT ; do
  case $OPT in
    "a" )
      alert="\a"
      ;;
    "s" )
      seconds="$(( seconds + OPTARG ))"
      ;;
    "m" )
      seconds="$(( seconds + OPTARG * 60 ))"
      ;;
    "h" )
      seconds="$(( seconds + OPTARG * 60 * 60 ))"
      ;;
  esac
done

if [ $seconds -ne 0 ] ; then
  now_time=$START_TIME

  while [ $seconds -gt $(( now_time - START_TIME )) ] ; do
    echo " $SPACE\r\c"
    echo " $(( seconds + START_TIME - now_time ))\r\c"

    sleep 1s

    now_time=`date +%s`
  done

  echo Finish!
  echo "$alert\r\c"
else
  while true ; do
    echo " $SPACE\r\c"
    echo " $(( now_time - START_TIME ))\r\c"

    sleep 1s

    now_time=`date +%s`
  done
fi

