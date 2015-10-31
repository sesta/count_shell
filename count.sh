#!/bin/sh

if [ "$1" = "" ] ; then
  echo no argument
else
  start_time=`date +%s`
  now_time=$start_time
  space='      '

  while [ $1 -ne $(( now_time - start_time )) ] ; do
    now_time=`date +%s`

    echo " $space\r\c"
    echo " $(( $1 + start_time - now_time ))\r\c"
  done

  echo Finish!
fi

