#!/bin/bash

SHUTDOWN_WAIT=10

 pid=`ps -fe | grep 8080  | grep -v grep | tr -s " "|cut -d" " -f2`

  if [ -n "$pid" ]

  then
    echo -e "\e[00;31mStoping Jenkins running on port 8080\e[00m"


    let kwait=$SHUTDOWN_WAIT
    count=0;
    echo -n -e "\n\e[00;31mwaiting for jenkins processes to exit\e[00m";

    until [ `ps -p $pid | grep -c $pid` = '0' ] || [ $count -gt $kwait ]
    do
      sleep 1
      let count=$count+1;
    done

    if [ $count -gt $kwait ]; then
      ##echo -n -e "\n\e[00;31mkilling processes which didn't stop after $SHUTDOWN_WAIT seconds\e[00m"
      kill -9 $pid
    fi

    pid=`ps -fe | grep 8080  | grep -v grep | tr -s " "|cut -d" " -f2`

    if [ -n "$pid" ]
      then
      echo -e "\n\e[00;31mJenkins is not stopped\e[00m"
      else
      echo -e "\n\e[00;31mJenkins is stopped\e[00m"
    fi

  else
    echo -e "\e[00;31mJenkins is not running\e[00m"
  fi
