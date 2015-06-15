Bindstats script and template for Cacti

27/05/10 - Updated for Bind 9.6.x - It's a bit of a kludge actually, but it
will allow you graphs to continue as before.  Time for a rebuild :)

1. Setup RNDC and RNDC stats on the Bind server
2. From the folder bind-server, put the script bind9.sh onto your BIND server - You may need to modify the paths in this script.
3. On Solaris you might need to download gawk
4. On the bind server configure snmp (If your using Solaris make sure you use net-snmp not Sun's SNMP) with these lines.

exec VALUES /bin/echo SUCCESS REFERRAL NXRRSET NXDOMAIN RECURSION FAILURE
exec bindstats /usr/scripts/bind9.sh

5. From the folder bind-server, put the script bindstats-cacti.sh onto your cacti server - Again you may need to modify the paths in the script, make sure that the cactiuser can write to the tmp folder, for this reason the log folder is used in the default file.
5. You might also need to modify extOutput.2 this will depend on the configuration of SNMP on your remote host (on how many exec lines you have)
6. Import the template file "cacti_graph_template_bind_dns_stats.xml"
