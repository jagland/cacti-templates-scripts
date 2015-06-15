#!/bin/bash

SNMPGET=/usr/local/bin/snmpget
TMP=/home/cactiuser/log
UNIQUEPART=`date "+%S%N"`
TMPFILE=$TMP/bindstats-$UNIQUEPART.tmp
AWK=/usr/bin/awk

$SNMPGET -v2c -c $2 $1 extOutput.2 > $TMPFILE
SUCCESS=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$4} END { print result ? result :0}' $TMPFILE`
REFERRAL=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$5} END { print result ? result :0}' $TMPFILE`
NXRRSET=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$6} END { print result ? result :0}' $TMPFILE`
NXDOMAIN=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$7} END { print result ? result :0}' $TMPFILE`
RECURSION=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$8} END { print result ? result :0}' $TMPFILE`
FAILURE=`$AWK '/UCD-SNMP-MIB::extOutput.2/ { result=\$9} END { print result ? result :0}' $TMPFILE`

rm $TMPFILE
echo SUCCESS:$SUCCESS REFERRAL:$REFERRAL NXRRSET:$NXRRSET NXDOMAIN:$NXDOMAIN RECURSION:$RECURSION FAILURE:$FAILURE
