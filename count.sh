#!/bin/sh

START_TIME=`date +%s`
now_time=$START_TIME
seconds=0

function echoTime(){
  cols=`tput cols`
  space=`makeSpace $(( ( cols - 9 )  / 2 ))`

  s=$1
  m=$(( ( s / 60 ) % 60 ))
  h=$(( s / 60 / 60 ))
  s=$(( s % 60 ))

  if [ $h -lt 10 ] ; then
    h_space='0'
  else
    h_space=''
  fi

  if [ $m -lt 10 ] ; then
    m_space='0'
  else
    m_space=''
  fi

  if [ $s -lt 10 ] ; then
    s_space='0'
  else
    s_space=''
  fi

  echo "\n$space$h_space$h:$m_space$m:$s_space$s$space\n"
}

function makeSpace(){
  space_length=$1
  space=""

  for i in `seq 1 1 $space_length` ; do
    space=" $space"
  done
  echo "$space"
}

function cursorUp(){
  for i in `seq 1 1 $1` ; do
    echo "$(tput cuu1)\c"
  done
}

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
      h=`echo "$OPTARG" | sed -E "s/[0-9]+[ms]//g"`
      h=`echo "$h" | sed -E "s/h//g"`
      m=`echo "$OPTARG" | sed -E "s/[0-9]+[hs]//g"`
      m=`echo "$m" | sed -E "s/m//g"`
      s=`echo "$OPTARG" | sed -E "s/[0-9]+[hm]//g"`
      s=`echo "$s" | sed -E "s/s//g"`
      seconds="$(( seconds + ( h * 60 + m ) * 60 + s ))"
      ;;
  esac
done

if [ $seconds -ne 0 ] ; then
  echo "\n\n"
  while [ $seconds -gt $(( now_time - START_TIME )) ] ; do
    cursorUp 3
    echoTime $(( seconds + START_TIME - now_time ))

    sleep 1s

    now_time=`date +%s`
  done

  cursorUp 3
  echo "\n$space Finish! $space"
  echo "$alert"
else
  echo "\n\n"
  while true ; do
    cursorUp 3
    echoTime $(( now_time - START_TIME ))

    sleep 1s

    now_time=`date +%s`
  done
fi
