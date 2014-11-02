#!/bin/sh
 
### BEGIN INIT INFO
# Provides:   serf
# Required-Start:    $local_fs $remote_fs $network $syslog $named
# Required-Stop:     $local_fs $remote_fs $network $syslog $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the serf agent
# Description:       starts serf agent using start-stop-daemon
### END INIT INFO

# set -x

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=serf
DESC=serf

NODE=$(hostname)
TAGS=/var/tmp/${NODE}_tags.txt
SNAP=/var/tmp/${NODE}_snap.txt
CONFIG=/usr/local/serf/etc/config.txt
DAEMON=/usr/local/serf/bin/serf

DAEMON_OPTS="agent -node=$HOSTNAME -snapshot=${SNAP} -rejoin -config-file=$CONFIG"
 
# Include serf defaults if available
if [ -f /etc/default/serf ]; then
    . /etc/default/serf
fi
 
test -x $DAEMON || exit 0
 
set -e
 
. /lib/lsb/init-functions
 
PID=/var/run/serf.pid
 
# Check if the ULIMIT is set in /etc/default/serf
if [ -n "$ULIMIT" ]; then
  # Set the ulimits
  ulimit $ULIMIT
fi
 
start() {
        if [ -f $PID ]; then
            echo "Instance of ${DAEMON} already running."
            exit 1
        fi

        nohup $DAEMON $DAEMON_OPTS > /dev/null &
        sleep 2
        ps -ef | grep serf
        pgrep -f "$NAME agent" > /var/run/serf.pid
}
 
stop() {
        start-stop-daemon --stop --pidfile $PID \
            --retry 5 --oknodo --exec $DAEMON
}
 
case "$1" in
    start)
        log_daemon_msg "Starting $DESC" "$NAME"
        start
        log_end_msg $?
        ;;
 
    stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        stop
        log_end_msg $?
        ;;
 
    restart|force-reload)
        log_daemon_msg "Restarting $DESC" "$NAME"
        stop
        sleep 1
        start
        log_end_msg $?
        ;;
 
    reload)
        log_daemon_msg "Reloading $DESC configuration" "$NAME"
        start-stop-daemon --stop --signal HUP --quiet --pidfile $PID \
            --oknodo --exec $DAEMON
        log_end_msg $?
        ;;
 
    status)
        status_of_proc -p $PID "$DAEMON" serf
        ;;
 
    *)
        echo "Usage: $NAME {start|stop|restart|reload|force-reload|status}" >&2
        exit 1
        ;;
esac
 
exit 0
