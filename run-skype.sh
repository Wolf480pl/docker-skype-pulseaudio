#!/bin/sh

ndisplay=$1
if [ -z $ndisplay ]; then
  ndisplay=:1
fi

#docker run -d -p 55555:22 --name skype --volumes-from skype_data wolf480pl/skype
docker start skype

Xephyr $ndisplay &
xephyr_pid=$!
sleep 2

DISPLAY=$ndisplay dwm &

#setxkbmap pl -display $ndisplay -model pc104

DISPLAY=$ndisplay ssh -Y docker-skype dbus-launch --exit-with-session skype-pulseaudio

if [ `ps ho comm $xephyr_pid` == Xephyr ]; then
  kill $xephyr_pid
fi

docker stop skype
