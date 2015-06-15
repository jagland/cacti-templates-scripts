Eximstats script and template for Cacti

1. From the folder exim-server, put the script eximstats.sh onto your exim server - You may need to modify the paths in this script.
2. On Solaris you might need to download gawk
3. On the exim server configure snmp (If your using Solaris make sure you use net-snmp not Sun's SNMP) with the following lines (I've included the echo Duff and echo Beer lines as I use this and my bind stats script on the same box.

exec VALUES /bin/echo Duff
exec VALUES /bin/echo Beer
exec VALUES /bin/echo RECIEVED DELIVERED INQUEUE FROZEN
exec eximstats /usr/scripts/eximstats.sh

5. From the folder cacti-server, put the script eximstats-cacti.sh onto your cacti server - Again you may need to modify the paths in the script, make sure that the cactiuser can write to the tmp folder, for this reason the log folder is used in the default file.
5. You might also need to modify extOutput.4 this will depend on the configuration of SNMP on your remote host (on how many exec lines you have)
6. Import the template file "cacti_host_template_exim_mail_server.xml"