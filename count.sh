#!/bin/sh

START_TIME=`date +%s`
now_time=$START_TIME
seconds=0

line_1=("888888" "    88" "888888" "888888" "88  88" "888888" "888888" "888888" "888888" "888888")
line_2=("88  88" "    88" "    88" "    88" "88  88" "88    " "88    " "88  88" "88  88" "88  88")
line_3=("88  88" "    88" "888888" "888888" "888888" "888888" "888888" "88  88" "888888" "888888")
line_4=("88  88" "    88" "88    " "    88" "    88" "    88" "88  88" "    88" "88  88" "    88")
line_5=("888888" "    88" "888888" "888888" "    88" "888888" "888888" "    88" "888888" "888888")


function echoTime(){
  cols=`tput cols`
  space=`makeSpace $(( ( cols - 6*6 - 2*3 - 6*2 )  / 2 ))`

  s=$1
  m=$(( ( s / 60 ) % 60 ))
  h=$(( s / 60 / 60 ))
  s=$(( s % 60 ))

  h_10=$(( h / 10 ))
  h_1=$((  h % 10 ))
  m_10=$(( m / 10 ))
  m_1=$((  m % 10 ))
  s_10=$(( s / 10 ))
  s_1=$((  s % 10 ))

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

  echo ""
  echo "$space${line_1[h_10]}  ${line_1[h_1]}      ${line_1[m_10]}  ${line_1[m_1]}      ${line_1[s_10]}  ${line_1[s_1]}"
  echo "$space${line_2[h_10]}  ${line_2[h_1]}  88  ${line_2[m_10]}  ${line_2[m_1]}  88  ${line_2[s_10]}  ${line_2[s_1]}"
  echo "$space${line_3[h_10]}  ${line_3[h_1]}      ${line_3[m_10]}  ${line_3[m_1]}      ${line_3[s_10]}  ${line_3[s_1]}"
  echo "$space${line_4[h_10]}  ${line_4[h_1]}  88  ${line_4[m_10]}  ${line_4[m_1]}  88  ${line_4[s_10]}  ${line_4[s_1]}"
  echo "$space${line_5[h_10]}  ${line_5[h_1]}      ${line_5[m_10]}  ${line_5[m_1]}      ${line_5[s_10]}  ${line_5[s_1]}"
  echo ""
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
  echo "\n\n\n\n\n\n"
  while [ $seconds -gt $(( now_time - START_TIME )) ] ; do
    cursorUp 7
    echoTime $(( seconds + START_TIME - now_time ))

    sleep 1s

    now_time=`date +%s`
  done

  cursorUp 7
  echo "\n$space Finish! $space\n$alert"
else
  echo "\n\n\n\n\n\n"
  while true ; do
    cursorUp 7
    echoTime $(( now_time - START_TIME ))

    sleep 1s

    now_time=`date +%s`
  done
fi
