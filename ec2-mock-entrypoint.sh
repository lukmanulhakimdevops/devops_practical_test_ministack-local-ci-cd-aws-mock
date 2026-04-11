#!/bin/sh
dockerd &
sleep 5
tail -f /dev/null
