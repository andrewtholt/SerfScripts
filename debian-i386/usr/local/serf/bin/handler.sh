#!/bin/bash

[ ! -f /tmp/tst.txt ] && touch /tmp/txt.txt

/usr/bin/env >> /tmp/tst.txt
date  >> /tmp/tst.txt
echo "=========================="  >> /tmp/tst.txt

echo >> /tmp/tst.txt
echo "SERF_EVENT      : ${SERF_EVENT}" >> /tmp/tst.txt
echo "SERF_USER_EVENT : ${SERF_USER_EVENT}" >> /tmp/tst.txt
echo "SERF_SELF_ROLE  : ${SERF_SELF_ROLE}" >> /tmp/tst.txt
echo "SERF_SELF_NAME  : ${SERF_SELF_NAME}" >> /tmp/tst.txt
echo "SERF_QUERY_NAME : ${SERF_QUERY_NAME}" >> /tmp/tst.txt

echo "more Data follows..." >> /tmp/tst.txt
while read line; do
    printf "${line}\n" >> /tmp/tst.txt
done

case ${SERF_USER_EVENT} in
    TEST )
        echo "Do nothing, just a test."
        ;;
esac
echo "... done"
