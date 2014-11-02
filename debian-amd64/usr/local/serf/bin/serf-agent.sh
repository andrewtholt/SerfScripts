#!/bin/bash

set -x

SERF=/usr/local/serf/bin/serf
NODE=$(hostname)
TAGS=/var/tmp/${NODE}_tags.txt
SNAP=/var/tmp/${NODE}_snap.txt
CONFIG=/usr/local/serf/etc/config.txt

# serf agent -node=$HOSTNAME -tags-file=${TAGS} -snapshot=${SNAP} -log-level=debug -event-handler=./handler.sh -rejoin -config-file=$CONFIG

# serf agent -discover=fred -node=$HOSTNAME -snapshot=${SNAP} -log-level=debug -event-handler=./handler.sh -rejoin -config-file=$CONFIG 2>&1 /dev/null

${SERF} agent -node=$HOSTNAME -snapshot=${SNAP} -rejoin -config-file=$CONFIG 2>&1 /dev/null

