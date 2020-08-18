#!/bin/bash

info_txt(){
	echo 'Usage: ./laptop-tool.sh [OPTION]

  --boost-off

  --boot-on

  --powersave

  --ondemand

  --cpu-info
 
  --ip-info
'
}

case $1 in
	"--boost-off")
		echo 0 > /sys/devices/system/cpu/cpufreq/boost;;
	"--boost-on")
		echo 1 > /sys/devices/system/cpu/cpufreq/boost;;
	"--powersave")
		cpupower frequency-set -g powersave;;
	"--ondemand")
		cpupower frequency-set -g ondemand;;

	"--cpu-info")
		echo ""
		lscpu | grep "Model name:"	
		echo ""
		[ $(cat /sys/devices/system/cpu/cpufreq/boost) == 1 ] && echo "BOOST ON" || echo "BOOST OFF"
		echo ""
		lscpu | grep "CPU MHz"
		lscpu | grep "CPU max MHz"
		lscpu | grep "CPU min MHz"
		echo ""
		cpupower frequency-info;;
	"--ip-info")
		ip a | grep "inet ";;

	"--help")
		info_txt;;
	"--update")
		mv laptop-tool.sh laptop-tool.old
		wget https://raw.githubusercontent.com/leftside97/laptop-tool/master/laptop-tool.sh
		chmod +x laptop-tool.sh;;


	*) echo "Try 'laptop-tool --help' for more information.";;

esac



