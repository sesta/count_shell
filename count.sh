#!/bin/sh

SPACE='      '
START_TIME=`date +%s`
now_time=$START_TIME
seconds=0

while getopts as:m:h:t: OPT ; do
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
    "t" )
      h=`echo "$OPTARG" | sed -e "s/[0-9]*m//g"`
      h=`echo "$h" | sed -e "s/[0-9]*s//g"`
      h=`echo "$h" | sed -e "s/h//g"`
      m=`echo "$OPTARG" | sed -e "s/[0-9]*h//g"`
      m=`echo "$m" | sed -e "s/[0-9]*s//g"`
      m=`echo "$m" | sed -e "s/m//g"`
      s=`echo "$OPTARG" | sed -e "s/[0-9]*h//g"`
      s=`echo "$s" | sed -e "s/[0-9]*m//g"`
      s=`echo "$s" | sed -e "s/s//g"`
        # TODO: もっとちゃんと正規表現する
      seconds="$(( seconds + ( h * 60 + m ) * 60 + s ))"
  esac
done

if [ $seconds -ne 0 ] ; then
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

