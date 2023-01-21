#!/bin/bash

LOADING=""
INTERVAL=0
TIMEOUT=0.5

get_cpu() {
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | \
      sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
      awk '{print 100 - $1"%"}'
  )
  cpu_icon=""
  echo "$cpu_icon $cpu_usage"
}

get_ram() {
  ram_usage=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
  ram_icon=""
  echo "$ram_icon $ram_usage"
}

get_disk() {
  disk_usage=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')
  disk_icon=""
  echo "$disk_icon $disk_usage"
}

get_vol() {
  volume=$(pamixer --get-volume-human)
  if [ -z $volume ]; then
    volume=$LOADING
  fi
  vol_icon=""
  echo "$vol_icon $volume"
}

get_bat() {
	declare -i bat_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  bat_icon=""
  echo "$bat_icon $bat_capacity%"
}

get_bght() {
  bght=$(printf "%.0f" $(xbacklight -get))
  bght_icon=""
  echo "$bght_icon $bght%"
}

get_date() {
	date=$(date +'%a %d %B')
  date_icon=""
  echo "$date_icon $date"
}

get_hour() {
	hour=$(date '+%H:%M')
  hour_icon=""
  echo "$hour_icon $hour"
}

get_network() {
	if timeout $TIMEOUT curl -I https://www.gnu.org &> /dev/null; then
    net_icon=" "
	else
	  net_icon=$LOADING
	fi
  echo $net_icon
}

while true; do
  # volume
  status="$(get_vol)"
  # brightness
  status="$status   $(get_bght)"
	# battery
  status="$status   $(get_bat)"
  # CPU
  status="$status   $(get_cpu)"
	# date and hour
  status="$status   $(get_date)  $(get_hour)"
	# network
  status="$status   $(get_network)"

	xsetroot -name "  $status  "
	sleep $INTERVAL
done
