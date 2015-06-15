#!/bin/bash
SNMPGET=/usr/local/bin/snmpget
TMP=/home/cactiuser/log
AWK=/usr/bin/awk
UNIQUEPART=`date "+%S%N"`
TMPFILE=$TMP/eximstats-$UNIQUEPART.tmp
TODAYS_DATE=`date "+%b %d %H:%M:%S"`
SNMPCOMMUNITY=$3
HOSTNAME=$2

exim_stats () {
$SNMPGET -v2c -c $SNMPCOMMUNITY $HOSTNAME extOutput.4 > $TMPFILE
RECEIVED=`$AWK '/UCD-SNMP-MIB::extOutput.4/ { result=\$4} END { print result ? result :0}' $TMPFILE`
DELIVERED=`$AWK '/UCD-SNMP-MIB::extOutput.4/ { result=\$5} END { print result ? result :0}' $TMPFILE`
echo RECEIVED:$RECEIVED DELIVERED:$DELIVERED
echo $TODAYS_DATE $HOSTNAME RECEIVED:$RECEIVED DELIVERED:$DELIVERED >> $TMPFILE
/bin/rm $TMPFILE
}

exim_queue () {
$SNMPGET -v2c -c $SNMPCOMMUNITY $HOSTNAME extOutput.4 > $TMPFILE
INQUEUE=`$AWK '/UCD-SNMP-MIB::extOutput.4/ { result=\$6} END { print result ? result :0}' $TMPFILE`
echo INQUEUE:$INQUEUE
echo $TODAYS_DATE $HOSTNAME INQUEUE:$INQUEUE >> $TMPFILE
/bin/rm $TMPFILE
}

case "$1" in
'stats')
  exim_stats
  ;;
'queue')
  exim_queue
  ;;
*)
  echo "usage $0 stats|queue ipaddress snmpcommunity"
esac
