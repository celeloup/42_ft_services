#!/bin/sh
if pgrep "/usr/sbin/nginx" > /dev/null
then
    exit 0
else
    exit 1
fi