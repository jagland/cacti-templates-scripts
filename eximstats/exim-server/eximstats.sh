#!/bin/bash
# generate statistics
RECEIVED=`cat /usr/local/exim/spool/log/mainlog  | grep -c "<="`
DELIVERED=`cat /usr/local/exim/spool/log/mainlog | grep -c "=>"`
INQUEUE=`/usr/local/exim/bin/exim -bpc`
#FROZEN=`/usr/local/exim/bin/exim -bpu | grep -c "*** frozen ***"`
echo $RECEIVED $DELIVERED $INQUEUE
