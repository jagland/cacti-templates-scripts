#!/bin/bash

STATS="/usr/local/etc/named.data/named.stats"
RNDC="/usr/local/sbin/rndc"
AWK="/usr/local/bin/awk"

# generate statistics
rm $STATS
${RNDC} stats >>/dev/null
SUCCESS=`$AWK '/queries resulted in successful answer/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
#REFERRAL=`$AWK '/referral/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
REFERRAL=0
NXRRSET=`$AWK '/queries resulted in nxrrset/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
NXDOMAIN=`$AWK '/queries resulted in NXDOMAIN/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
RECURSION=`$AWK '/queries caused recursion/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`
FAILURE=`$AWK '/queries resulted in SERVFAIL/ { result=\$2 } END { print result ? result  :0 }' ${STATS}`

echo $SUCCESS $REFERRAL $NXRRSET $NXDOMAIN $RECURSION $FAILURE
