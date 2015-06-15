#!/bin/bash

STATS="/usr/local/etc/named.data/named.stats"
RNDC="/usr/local/sbin/rndc"
AWK="/usr/local/bin/awk"

# generate statistics
rm $STATS
${RNDC} stats >>/dev/null
SUCCESS=`$AWK '/success/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
REFERRAL=`$AWK '/referral/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
NXRRSET=`$AWK '/nxrrset/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
NXDOMAIN=`$AWK '/nxdomain/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
RECURSION=`$AWK '/recursion/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
FAILURE=`$AWK '/failure/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`

echo $SUCCESS $REFERRAL $NXRRSET $NXDOMAIN $RECURSION $FAILURE
