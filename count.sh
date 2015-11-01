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

  while [ $seconds -ne $(( now_time - START_TIME )) ] ; do
    now_time=`date +%s`
    echo " $SPACE\r\c"
    echo " $(( seconds + START_TIME - now_time ))\r\c"
  done

  echo Finish!
  echo "$alert\r\c"
else
  while true ; do
    now_time=`date +%s`
    echo " $SPACE\r\c"
    echo " $(( now_time - START_TIME ))\r\c"
  done
fi

