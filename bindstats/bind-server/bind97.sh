#!/bin/bash

STATSFILE="/chroot/dns/tmp/bind.stats"
RNDC="/chroot/dns/usr/local/bind/sbin/rndc"
AWK="/bin/awk"
STATS=`/bin/mktemp`

# generate statistics
rm $STATSFILE
${RNDC} stats >>/dev/null 2>&1
grep -20 "++ Name Server Statistics ++" $STATSFILE > $STATS
SUCCESS=`$AWK '/queries resulted in successful answer/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`
REFERRAL=`$AWK '/queries resulted in referral answer/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`
#REFERRAL=0
NXRRSET=`$AWK '/queries resulted in nxrrset/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`
NXDOMAIN=`$AWK '/queries resulted in NXDOMAIN/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`
RECURSION=`$AWK '/queries caused recursion/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`
FAILURE=`$AWK '/queries resulted in SERVFAIL/ { result=\$1 } END { print result ? result  :0 }' ${STATS}`

echo $SUCCESS $REFERRAL $NXRRSET $NXDOMAIN $RECURSION $FAILURE
rm $STATS

